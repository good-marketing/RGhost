#' set_credentials
#' @description
#' set initial variables to be used in the package and authenticates the user to obtain an access token
#' @param username Ghost username (format email)
#' @param password Ghost password.
#' @param url Ghost Url (using https:// format).
#' @return Access token required for any request to the url \code{access_token} and \code{y}.
#'
#' @examples
#' set_credentials("foo@@barcom","foopassword","http://foo.com")



#Create package environment
ghost <- new.env(parent = emptyenv())
ghost$return_credentials$status        <- FALSE


set_credentials <- function(username,password,url){

  ### Create empty response list
  return_credentials.names   <- c("username", "password", "url","status")
  return_credentials   <- vector("list", length(return_credentials.names))
  names(return_credentials)  <- return_credentials.names

  #Assign return variable to package environment
  ghost$creds <- return_credentials

  # Set generic variables
  ghost$return_credentials$status        <- FALSE
  ghost$return_credentials$url           <- url

  #Authenticate ghost
  response_credentials <- authenticate_ghost(username,password)

  #Check status and set variables after authentication
  if(ghost$return_credentials$status){
    ghost$return_credentials$time          <- Sys.time()
    ghost$return_credentials$access_token  <-  response_credentials$access_token
    ghost$return_credentials$refresh_token <- response_credentials$refresh_token
    return (ghost$return_credentials)
  }
  else{
    ghost$return_credentials$access_token  <-  ''
    ghost$return_credentials$refresh_token <- ''
    return (ghost$return_credentials)
  }

}

#' authenticate_ghost
#' @description
#' Make call to authenticate current user.
#' @param username Ghost username (format email)
#' @param password Ghost password.
#' @return http request content is returned. If an authentication is unsuccesful the error message is returned.
#'
#' @examples
#' authenticate_ghost("foo@@barcom","foopassword")

authenticate_ghost <- function(username,password){

  ghost_url <- paste(construct_url(),"authentication/token",sep="")

  access_ghost <- httr::POST(ghost_url,
                  encode="form",
                  body = list(grant_type = "password",
                            username =   username,
                            password =  password,
                            client_id = "ghost-admin"),
                  add_headers(
                  "Content-Type" = "application/x-www-form-urlencoded",
                  "Referer" = "http://good-marketing.org/ghost/signin/",
                  "X-Requested-With" = "XMLHttpRequest",
                  "Accept" ="application/json, text/javascript, */*; q=0.01",
                  "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5)
                                AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"),
                  verbose()
  )

  response <- construct_response(access_ghost)

  if(response$status){
    response <- response$content # Set the response
    ghost$return_credentials$status <- TRUE #Set ghost variable to true
  }
  else{
    response <- response$message
    ghost$return_credentials$status <- FALSE
  }
  return (response)


}

#' refresh_authenticate_ghost
#' @description
#' Gets a new access token if the token is expired. Ghost access tokens expire after one hour. If authentication is succesful an refresh token is returned in the authetication call.
#' @param refresh token.
#' @return New access token which is valid for the next hour.
#'
#' @examples
#' refresh_authenticate_ghost("refresh_token")
refresh_authenticate_ghost <- function(refresh_token){

  ghost_url <- paste(construct_url(),"authentication/token",sep="")

  refresh_ghost <- httr::POST(ghost_url,
                             encode="form",
                             body = list(grant_type = "refresh_token",
                                         refresh_token =   refresh_token,
                                         client_id = "ghost-admin"),
                             add_headers(
                               "Content-Type" = "application/x-www-form-urlencoded",
                               "Referer" = "http://good-marketing.org/ghost/signin/",
                               "X-Requested-With" = "XMLHttpRequest",
                               "Accept" ="application/json, text/javascript, */*; q=0.01",
                               "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5)
                                AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"),
                             verbose()
  )

  response <- construct_response(refresh_ghost)

  if(response$status){
    ghost$return_credentials$access_token <- response$content$access_token # Set the response
    ghost$return_credentials$status <- TRUE #Set ghost variable to true
    ghost$return_credentials$time <- Sys.time()
  }
  else{
    response <- response$message
  }
  return (response)

}

#' get_ghost_token
#' @description
#' Checks if the current access token is valid and return the access_token. If the token has expired a new token is requested by calling the refresh_authenticate_ghost function.
#' @return  Valid access token.
#' @examples
#' get_ghost_token()

get_ghost_token <- function()
{
  expiration <- as.numeric(difftime(Sys.time(),ghost$return_credentials$time,units =  "secs"))

  if(ghost$return_credentials$status & expiration < 3600){
    return(ghost$return_credentials$access_token)
  }
  else{
    refresh_authenticate_ghost(ghost$return_credentials$refresh_token)
    return(ghost$return_credentials$access_token)
  }
}
