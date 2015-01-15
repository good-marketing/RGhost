#' Base input parameters
#'
#' @param username Ghost username (format email)
#' @param password Ghost password.
#' @param url Ghost Url (using https:// format).
#' @return Access token required for any request to the url \code{access_token} and \code{y}.

#Create package environment
ghost <- new.env(parent = emptyenv())

set_credentials <- function(username,password,url){

  ### Create empty response list
  return_credentials.names   <- c("username", "password", "url","status")
  return_credentials   <- vector("list", length(return_credentials.names))
  names(return_credentials)  <- return_credentials.names

  #Assign return variable to package environment
  ghost$creds <- return_credentials

  #Set variables
  ghost$return_credentials$time <- Sys.time()
  ghost$return_credentials$status <- FALSE
  ghost$return_credentials$username <- username
  ghost$return_credentials$password <- password
  ghost$return_credentials$url      <- url
  ghost$return_credentials$access_token   <-  authenticate_ghost()

  return (ghost$return_credentials)

}


#' Authenticate ghost serive
#'
#' @param username Ghost username (format email)
#' @param password Ghost password.
#' @param url Ghost Url (using https:// format).
#' @return Access token required for any request to the url \code{access_token} and \code{y}.

authenticate_ghost <- function(){

  ghost_url <- paste(construct_url(),"authentication/token",sep="")

  access_ghost <- httr::POST(ghost_url,
                  encode="form",
                  body = list(grant_type = "password",
                            username =   ghost$return_credentials$username,
                            password =  ghost$return_credentials$password,
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
    response <- response$content$access_token # Set the response
    ghost$return_credentials$status <- TRUE #Set ghost variable to true
  }
  else{
    response <- response$message
  }
  return (response)


}

get_ghost_token <- function()
{
  expiration <- as.numeric(difftime(Sys.time(),ghost$return_credentials$time,units =  "secs"))

  if(ghost$return_credentials$status & expiration < 3600){
    return(ghost$return_credentials$access_token)
  }
  else{
    authenticate_ghost()
    return(ghost$return_credentials$access_token)
  }
}
