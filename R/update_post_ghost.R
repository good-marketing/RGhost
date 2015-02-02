#' update_post_ghost
#' @description
#' Update and existing post. Tags are included by default.
#' @param id Post id of an existing post.
#' @param post_body a valid post object.
#' @return Response object. See the \code{\link{construct_response}} function.
#' @examples
#' update_post_ghost(1,construct_body(post_body))

update_post_ghost <- function(id,post_body){
  #Construct url
  ghost_url <- paste(construct_url(),"posts/",id,"?include=tags",sep="")

  #Make the call
  update_ghost <- make_api_call("PUT",ghost_url,post_body)

  #Create the response
  return(construct_response(update_ghost))
}
