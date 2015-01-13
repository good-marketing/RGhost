get_tags <- function(){

  access_token <- authenticate_ghost()

  get_tags <- GET("http://good-marketing.org/ghost/api/v0.1/tags",
                      # encode="json",
                      verbose(),
                      add_headers(
                        "Content-Type" = "application/json",
                        "Authorization" = paste('Bearer', access_token) ,
                        "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")
  )

  response <- list(flat = parse_content(get_tags),
                   hier = content(get_tags))
  return(response)
}
