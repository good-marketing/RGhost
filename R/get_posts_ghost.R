#' Get 15 Ghosts blogposts
#' @param status ghost posts either have status draft, published. The 'all' parameter gets both published and draft
#' @return Returns latest 15 post objects in a flattened list containing post objects.

get_posts_ghost <- function (){

  ghost_url <- paste(construct_url(),"posts?status=all",sep="")

  ghost_posts <- make_api_call("GET",ghost_url)

  response <- construct_response(ghost_posts)

  if(response$status){
    response <- fromJSON(content(ghost_posts,as="text"),flatten=TRUE)
  }
  else{
    response <- response$message
  }

  return (response)
}

#' Get single post
#' @param id postid to fetch
#' @return Returns latest 1 post objects.


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
