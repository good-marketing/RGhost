get_tags <- function(){

  access_token <- get_ghost_token()
  ghost_url <- paste(construct_url(),"tags",sep="")

  get_tags <- GET(ghost_url,
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
