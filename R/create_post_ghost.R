create_post_ghost <- function(post_body){

  access_token <- get_ghost_token()

  ghost_url <- paste(construct_url(),"posts?include=tags",sep="")

  post_ghost <- POST(ghost_url,
                    # encode="json",
                    body = toJSON(post_body,auto_unbox=TRUE),
                    verbose(),
                    add_headers(
                      "Content-Type" = "application/json",
                      "Authorization" = paste('Bearer', access_token) ,
                      "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")
  )

  return(parse_content(post_ghost))
}
