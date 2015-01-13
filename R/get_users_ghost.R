get_users <- function(){

  access_token <- authenticate_ghost()

  get_users <- GET("http://good-marketing.org/ghost/api/v0.1/users",
                      # encode="json",
                      verbose(),
                      add_headers(
                        "Content-Type" = "application/json",
                        "Authorization" = paste('Bearer', access_token) ,
                        "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")
  )

  return(parse_content(get_users))
}

get_current_user <-function(){

  access_token <- authenticate_ghost()

  get_user <- GET("http://good-marketing.org/ghost/api/v0.1/users/me",
                   # encode="json",
                   verbose(),
                   add_headers(
                     "Content-Type" = "application/json",
                     "Authorization" = paste('Bearer', access_token) ,
                     "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")
  )

  return(parse_content(get_user))


}
