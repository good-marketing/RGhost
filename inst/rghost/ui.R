shinybootstrap2::withBootstrap2(
  fluidPage
  (   #Include Stuff
    tags$head(
      tags$link(rel = 'stylesheet', type = 'text/css', href = 'editR.css'),
      tags$script(src = "actions.js")),

    # Hidden buttons
    shinyFilesButton("my_open", "Open file", "Please select a file", FALSE),
    actionLink("my_save", "Save"),
    actionLink("my_render", "Render"),
    actionLink("my_ghost", "Ghost"),
    actionLink("my_ghostu", "Ghostu","update"),
    actionLink("my_ghostd", "Ghostd"),
    actionLink("my_ghostg", "Ghostg"),

    #Set Local Storage
    shinyStore::initStore("store", "shinyStore-ghost"),

    # Navigation bar
    bsNavBar("nav", brand = "GhostR", fixed = FALSE,
             leftItems = list(
               bsNavDropDown2(inputId = "dd1", label = "File",
                              choices = list(c("Open file [Ctrl+o]", "open"),
                                             c("Save file [Ctrl+s]", "save"),
                                             c("Render file [Ctrl+r]", "render"))),
               bsNavDropDown2(inputId = "dd2", label = "Ghost",
                              choices = list(c("Get Posts", "ghostg"),
                                             c("Post to  Ghost", "ghost"),
                                             c("Update Post to  Ghost", "ghostu"),
                                             c("Delete Post from  Ghost", "ghostd")
                              ))
             )
             ,rightItems = list (textOutput("test"))),
    fluidRow
    ( column
      (width=2,

       bsAlert(inputId = "alert_anchor"),

       bsCollapse(open = "col2", id = "collapse",
          bsCollapsePanel("Login", id="col1",
                  actionButton("connect", "Connect", icon("download")),actionButton("save", "Save", icon("save")),
                                   textInput("username", "Username"),
                                   textInput("password", "Password"),
                                   textInput("ghost_base_url", "Url"),
                                   div("Value stored currently:"),
                                   textOutput("curText")),

          bsCollapsePanel("Post",id="col2",
                  uiOutput("Posts"),
                  textInput("PostTitle", label ="Post title", value = "Enter title..."),
                  selectInput('Page', 'Page', c("Not a page"="0","Make a Page"="1")),
                  selectInput('Publish', 'Publish', c("Draft"="draft","Published"="published")),
                  selectInput('Featured', 'Featured', c("Normal"=0,"Feature"=1)),
                  textInput('Slug', label ="Url", value = ""),
                  textInput('Image', label ="Image", value = ""),
                  uiOutput("Tags"),
                  uiOutput("Users")
         ))
      )
      ,
      column
      (width = 6,
       #MainPaneloutput
       aceEditor("rmd", mode = "markdown", wordWrap = TRUE, fontSize = 11, debounce = 10, autoComplete = "live", height = "auto")

      ),
      column(
        width=6,
        htmlOutput("knitDoc"))
    )
  )
)

