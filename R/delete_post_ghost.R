#' delete_post_ghost
#' @description
#' Delete a post from Ghost.
#' @param Post Id from an existing Ghost post.
#' @return Response object. See the \code{\link{construct_response}} function.
#' @examples
#' delete_post_ghost(1)

delete_post_ghost <- function(id){

  ghost_url <- paste(construct_url(),"posts/",id,sep="")

  delete_ghost <- make_api_call("DELETE",ghost_url)

  return(construct_response(delete_ghost))
}
