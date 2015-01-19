get_users <- function(){
  #Create URL
  ghost_url <- paste(construct_url(),"users",sep="")

  #Make the call
  get_users <- make_api_call("GET",ghost_url)

  return(parse_content(get_users))
}

get_current_user <-function(){

  #Create the URL
  ghost_url <- paste(construct_url(),"users/me",sep="")

  #Make the Call
  get_user <- make_api_call("GET",ghost_url)

  return(parse_content(get_user))


}