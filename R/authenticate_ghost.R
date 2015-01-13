#' Authenticate ghost serive
#'
#' @param username Ghost username (format email)
#' @param password Ghost password.
#' @param url Ghost Url (using https:// format).
#' @return Access token required for any request to the url \code{access_token} and \code{y}.

authenticate_ghost <- function(ghost_info){

  access_ghost <- httr::POST("http://good-marketing.org/ghost/api/v0.1/authentication/token",
                  encode="form",
                  body = list(grant_type = "password",
                            username =   "bob@good-marketing.org",
                            password =  "GoodMarketing14",
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
  }
  else{
    response <- response$message
  }
  return (response)
}
