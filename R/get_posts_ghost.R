#' get_posts_ghost
#' @description
#' Get all existing posts. Posts, static pages, draft and published posts are currently returned. Future implementation will allow to pass parameters to this function to select the returned posts.
#' @return Response object. See the \code{\link{construct_response}} function. An list of post objects is returned.
#' @examples
#' get_posts_ghost()
get_posts_ghost <- function (){

  ghost_url <- paste(construct_url(),"posts?status=all&staticPages=all&limit=all",sep="")
  ghost_posts <- make_api_call("GET",ghost_url)

  response <- construct_response(ghost_posts)

  if(response$status){
    response <- content(ghost_posts)
  }
  else{
    response <- response$message
  }
  return (response)
}

#' get_post_ghost
#' @description
#' Gets a signle post.
#' @param Post id from an existing post object.
#' @return Response object. See the \code{\link{construct_response}} function. Returns a post object. Tags associated with the current blogpost are included by default.
#' @examples
#' get_post_ghost(1)
get_post_ghost <- function(id){

  #Create Url
  ghost_url <- paste(construct_url(),"posts/",id,"?include=tags&status=all",sep="")

  #Make the call
  ghost_post <- make_api_call("GET",ghost_url)

  response <- construct_response(ghost_post)

  if(response$status){
    response <- content(ghost_post)$posts[[1]]
  }
  else{
    response <- response$message
  }
  return (response)
}
