delete_post_ghost <- function(id){

  ghost_url <- paste(construct_url(),"posts/",id,sep="")

  delete_ghost <- make_api_call("DELETE",ghost_url)

  return(construct_response(delete_ghost))
}
