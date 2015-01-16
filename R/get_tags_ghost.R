get_tags <- function(){

  ghost_url <- paste(construct_url(),"tags",sep="")

  get_tags <- make_api_call("GET",ghost_url)

  response <- list(flat = parse_content(get_tags),
                   hier = content(get_tags))

  return(response)
}
