update_post_ghost <- function(id,post_body){

  ghost_url <- paste(construct_url(),"posts/",id,"?include=tags",sep="")

  update_ghost <- make_api_call("PUT",ghost_url,post_body)

  return(construct_response(update_ghost))
}
