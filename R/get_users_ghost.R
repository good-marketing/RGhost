#' get_users
#' @description
#' Get all users associated with the current logged in account.
#' @return Response object. See the \code{\link{construct_response}} function. An list of user objects is returned.
#' @examples
#' get_users()

get_users <- function(){
  #Create URL
  ghost_url <- paste(construct_url(),"users",sep="")

  #Make the call
  get_users <- make_api_call("GET",ghost_url)
  response <- construct_response(get_users)

  return(response)
}

#' get_current_user
#' @description
#' Get information on the current logged in user.
#' @return Response object. See the \code{\link{construct_response}} function. A single user object is returned
#' @examples
#' get_current_user()

get_current_user <-function(){

  #Create the URL
  ghost_url <- paste(construct_url(),"users/me",sep="")

  #Make the Call
  get_user <- make_api_call("GET",ghost_url)

  #Construct the response
  response <- construct_response(get_user)
  return(response)
}
