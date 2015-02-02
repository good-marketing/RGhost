#' get_tags
#' @description
#' Get all existing tags.
#' @return Note a flattened list of tag objects and a nested list of tagobjects is returned. Implementation of this function to adhere to the standard in this package. The current implementation was done for convenience reasons to support the Shiny application.
#' @examples
#' get_tags()

get_tags <- function(){
  #Create Url
  ghost_url <- paste(construct_url(),"tags",sep="")
  #Make the api call
  get_tags <- make_api_call("GET",ghost_url)
  #Construct the response.
  response <- list(flat = parse_content(get_tags),
                   hier = content(get_tags))
  return(response)
}
