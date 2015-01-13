construct_response <- function(ghost_response){

  ### Create empty response list
  return_response.names   <- c("message", "status", "return_content")
  return_response         <- vector("list", length(return_response.names))
  names(return_response)  <- return_response.names

    if(ghost_response$status_code == 200 | ghost_response$status_code == 201){
      return_response$message    <- "Everything is a Ok"
      return_response$status     <- TRUE
      return_response$content    <- httr::content(ghost_response)
    }
    else{
      return_response$message    <- "There was a problem. Please see the error message"
      return_response$status     <- FALSE
      return_response$content    <- httr::content(ghost_response)$error
    }
  return(return_response)

}

construct_url <- function(token,extension,call) {

  version <- "/ghost/api/v0.1/"

  url <- paste(url_base)

}

construct_post <- function(post_body){

  # do error checking is this is a valid object

  body <- list("posts"= post_body)

}

parse_content <- function(post_body){

   parsed_content <- fromJSON(content(post_body,as="text"),flatten=TRUE)[[1]]

   return(parsed_content)
}
