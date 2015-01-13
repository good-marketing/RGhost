#' Get 15 Ghosts blogposts
#'
#' @param status ghost posts either have status draft, published. The 'all' parameter gets both published and draft
#' @return Returns latest 15 post objects in flattened list containing post objects.

get_posts_ghost <- function (){

  access_token <- authenticate_ghost()

  ghost_posts <- GET("http://good-marketing.org/ghost/api/v0.1/posts?status=all",
                    # encode="json",
                    verbose(),
                    add_headers(
                      "Content-Type" = "application/json",
                      "Authorization" = paste('Bearer', access_token) ,
                      "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"))


  response <- construct_response(ghost_posts)

  if(response$status){
    response <- fromJSON(content(ghost_posts,as="text"),flatten=TRUE)
  }
  else{
    response <- response$message
  }

  return (response)
}

get_post_ghost <- function(id){

  access_token <- authenticate_ghost()

  url <- paste("http://good-marketing.org/ghost/api/v0.1/posts/",id,sep="")

  ghost_post <- GET(url,
                   verbose(),
                   add_headers(
                     "Content-Type" = "application/json",
                     "Authorization" = paste('Bearer', access_token) ,
                     "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"))

  response <- construct_response(ghost_post)

  if(response$status){
    response <- content(ghost_post)$posts[[1]]
  }
  else{
    response <- response$message
  }
  return (response)
}
