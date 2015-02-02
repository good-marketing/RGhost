#' create_post_ghost
#' @description
#' Create a new post on ghost bloggin platform.
#' @param post_body a R list object to be converted to a valid Ghost Post object. See the \code{\link{construct_body}} function for a detailed description of a valid post object.
#' @return Response object. See the \code{\link{construct_response}} function.
#' @examples
#' create_post_ghost(construct_post(post_body))

create_post_ghost <- function(post_body){
  #Create URL
  ghost_url <- paste(construct_url(),"posts?include=tags",sep="")

  #Make the Call
  post_ghost <- make_api_call("POST",ghost_url,post_body)

  return(construct_response(post_ghost))
}
