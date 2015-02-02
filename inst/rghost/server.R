shinybootstrap2::withBootstrap2(function(input, output, session) {

 observe({

   if (input$connect > 0){
     ## Call init variables
     set_credentials( input$store$username,
                      input$store$password,
                      input$store$ghost_base_url)

     # Save correct credentials
     if (ghost$return_credentials$status){

       # Save correct credentials to store
       updateStore(session, "username", isolate(input$username))
       updateStore(session, "password", isolate(input$password))
       updateStore(session, "ghost_base_url", isolate(input$ghost_base_url))

       #Send message
       send_message("Authentication success and settings stored.","success")

     }
   }

   #check if the session still is in effect
   if(ghost$return_credentials$status){

    # Display Stored information.
     updateTextInput(session, "username", value=isolate(input$store)$username)
     updateTextInput(session, "password", value=isolate(input$store)$password)
     updateTextInput(session, "ghost_base_url", value=isolate(input$store)$ghost_base_url)

     #Send Message
     send_message("You are logged in.","success")
   }
   else
   {
    #Open login panel
    updateCollapse(session, id = "collapse", multiple = FALSE, open = "col1", close = NULL)

    #Send message
    send_message("Check your credentials and login.","danger")
   }


 })

 #Save new credentials to store
 observe({
   if (input$save > 0){
     updateStore(session, "username", isolate(input$username))
     updateStore(session, "password", isolate(input$password))
     updateStore(session, "ghost_base_url", isolate(input$ghost_base_url))
     return()
   }
 })

 output$test <- renderText({
  input$Tags

 })

 #Show stored values.
  output$curText <- renderText({
    paste(input$store$username," <br/>",input$store$password," <br/>",input$store$ghost_base_url)})



  ### Init logic###
  # md_file <- readChar(md_name, file.info(md_name)$size)
  # isolate({updateAceEditor(session, "rmd", value = md_file)})

  ## Message Function

  send_message <- function(message,status){
    createAlert(session,
                inputId = "alert_anchor",
                alertId = "ghost_message",
                message = message,
                type = status,
                dismiss = TRUE,
                block = TRUE,
                append = FALSE
    )

    Sys.sleep(4)

    closeAlert(session,"ghost_message")

  }

  ## Create Postbody
  create_post_body <- function(){

    ## Get  the values to Post
    PostTitle <- input$PostTitle
    Content   <- knit(text = input$rmd)
    Pages     <- input$Page
    Publish   <- input$Publish
    Featured  <- input$Featured
    Slug      <- input$Slug
    Tags      <- input$Tags
    Author    <- input$Users
    Image     <- input$Image

    TagsList <- list.filter(ghost$get_tag_list$hier$tags, id %in% Tags ) #Current Selected Tags

    post_body <-
      c(
        title    = PostTitle,
        markdown = Content,
        slug     = Slug,
        status   = Publish,
        image    = Image,
        featured = Featured,
        page     = Pages,
        language = "en_US",
        meta_title  = "",
        meta_description  = "",
        author   = Author,
        tags     = list(TagsList)
    )

    post_body <- construct_post(post_body)

    return (post_body)

  }

  ### Open file logic ###
  shinyFileChoose(input, 'my_open', session = session,
                  roots = c(Computer = "~/"), filetypes = c('md', 'rmd'))

  observe({
    if (!is.null(input$my_open)) {
      file <- as.character(parseFilePaths(roots = c(Computer = "~/"), input$my_open)[1, 4])
      file <- normalizePath(file)

      md_name <<- basename(file)
      md_path <<- dirname(file)
      setwd(md_path)

      md_file <- readChar(md_name, file.info(md_name)$size)
      isolate({updateAceEditor(session, "rmd", value = md_file)})
    }
  })

  ### Update preview logic ###
  output$knitDoc <- renderUI({
    input$rmd
    return(isolate(HTML(
      tryCatch(suppressWarnings(knit2html(text = preview(input$rmd), fragment.only = TRUE, quiet = TRUE)),
               error = function(e) "<div></div>")
    )))
  })

  ### Render file logic ###
  observe({
    if (input$my_render > 0 | !is.null(input$render_key)){
      isolate({
        cat(input$rmd, file = md_name)
        doc <- render(md_name)
        browseURL(doc)
      })
    }
  })

  ### Save file logic ###
  observe({
    if (input$my_save > 0 | !is.null(input$save_key)){
      isolate({cat(input$rmd, file = md_name)})
    }
  })

  ### Get Posts
  observe({
    isolate({
      output$Posts <- renderUI({
        if (input$my_ghostg > 0 )
          {
            PostList <- get_posts_ghost() # Get posts
            post_list <- setNames(list.map(PostList$posts,id),list.mapv(PostList$posts,slug))
            selectizeInput("Posts","Select an exiting Post",choices=post_list,selected=FALSE)

          }
      })
    })
  })

  ### Get tags
  observe({
    if(ghost$return_credentials$status){
      isolate({
        output$Tags <- renderUI({
           ghost$get_tag_list <- get_tags() # Get posts
            ghost$taglist_list <- setNames(as.list(ghost$get_tag_list$flat$tags$id),ghost$get_tag_list$flat$tags$name)  #Create list to be consumed by shiny input
            selectizeInput('Tags', 'Tags',
                           choices = ghost$taglist_list,
                           multiple=TRUE,
                           options=list(create=TRUE))
        })
      })
    }
  })


  ### Get users
  observe({
    if(ghost$return_credentials$status){
      isolate({
        output$Users <- renderUI({
          get_user_list <- get_users()$content # Get posts
          userlist_list <- setNames(as.list(get_user_list$users$id),get_user_list$users$name) #Create list to be consumed by shiny input
          selectInput('Users', 'Authors', choices = userlist_list ) #Fill shiny input
        })
      })
    }
  })

  ### Select Specific Post
  observe({
   if(!is.null(input$Posts))
    {isolate
      ({ id <- input$Posts #get the selected post id
         Post <- get_post_ghost(id) # get the post object
         Tags <-
        # Update post properties
        updateTextInput(session, "PostTitle", value = Post$title)
        updateAceEditor(session, "rmd", value = Post$markdown)
        updateSelectInput(session, "Publish", selected = Post$status)
        updateSelectInput(session, "Featured", selected = Post$featured)
        updateSelectInput(session, "Page", selected = Post$page)
        updateTextInput(session, "Slug", value = Post$slug)
        updateTextInput(session, "Image", value = Post$image)
        updateSelectizeInput(session, 'Tags',choices=ghost$taglist_list,selected = setNames(list.map(Post$tags,id),list.mapv(Post$tags,name)),server = TRUE) #update tags
        updateSelectInput(session, "Users", selected = Post$author)
      })
    }

  })

  ### ### Post to Ghost
  observe({
    if (input$my_ghost > 0 | !is.null(input$ghost_key))
      {

      isolate({
           #Create post body
           post_body <- create_post_body()

           # Make the post
           post_response <- create_post_ghost(post_body)

          #Save original RMarkDown
          cat(input$rmd, file = paste("posts/",gsub('/','',post_response$content$posts$url),".Rmd",sep=""))

          #User Feedback
          if(post_response$status){
          send_message(paste(post_response$message,
                             '<a href="',ghost$return_credentials$url,post_response$content$posts$url,
                             '" target="_blank">Your new post</a> was created.',sep=''),"success")}
          else{send_message(post_response_message,"danger")}

        })
    }
  })

  ## Update Ghost
  observe({
    if (input$my_ghostu > 0 | !is.null(input$ghost_keyu)){
      isolate({

        #Create post body
        post_body <- create_post_body()

        # Set input variables
        id <- input$Posts
        post_response <- update_post_ghost(id,post_body)

        #User Feedback
        if(post_response$status){
          send_message(paste(post_response$message,
                             '<a href="',ghost$return_credentials$url,post_response$content$posts$url,
                             '" target="_blank">Your post</a> was updated',sep=''),"success")}
        else{send_message(post_response_message,"danger")}
      })
    }
  })

 ## Delete Post from Ghost
 observe({
   if (input$my_ghostd > 0){
     isolate({
       # Set input variables
       id <- input$Posts

       # Make the call
       post_response <- delete_post_ghost(id)

       #User Feedback
       if(post_response$status){
         send_message(paste(post_response$message,
                            '<a href="',ghost$return_credentials$url,post_response$content$posts$url,
                            '" target="_blank">Your post</a> was deleted',sep=''),"success")
       }
       else{send_message(post_response_message,"danger")
       }
     })
   }
 })

})
