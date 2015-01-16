create_post_ghost <- function(post_body){
  #Create URL
  ghost_url <- paste(construct_url(),"posts?include=tags",sep="")

  #Make the Call
  post_ghost <- make_api_call("POST",ghost_url,post_body)

  return(construct_response(post_ghost))
}
