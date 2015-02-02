#' Creates a standarized response from an api call.
#' @description
#' Internal package function to create a response
#' @param ghost_response The http object returned from an api call.
#' @return Response object. The response object is a named list with three objects.
#' #' \itemize{
#'   \item message: a string which can be used to provide feedback messages to the user.
#'   \item status: a boolean value which indicates if the api call was succesfull.
#'   \item content: the parsed content from the http request is the request was successful. If an error occurred the error is returned in the content.
#' }
construct_response <- function(ghost_response){

  ### Create empty response list
  return_response.names   <- c("message", "status", "return_content")
  return_response         <- vector("list", length(return_response.names))
  names(return_response)  <- return_response.names

    if(ghost_response$status_code == 200 | ghost_response$status_code == 201){
      return_response$message    <- "Everything is ok."
      return_response$status     <- TRUE
      return_response$content    <- parse_content(ghost_response)
    }
    else{
      return_response$message    <- "There was a problem. Please see the error message."
      return_response$status     <- FALSE
      return_response$content    <- httr::content(ghost_response)$error
    }
  return(return_response)

}

#' Creates the url to be passed to the api call.
#' @description
#' Creates the url to be passed to the api call. The current api url '/ghost/api/v0.1/' is included. the baseurl set in the RGhost environment is used to construct the url.
#' @return Response object. See the \code{\link{construct_response}} function.
#' @examples
#' create_post_ghost(construct_post(post_body))
construct_url <- function() {

  url_base <-  ghost$return_credentials$url
  version  <- "/ghost/api/v0.1/"
  api_ghost_url <- paste0(url_base,version)

  return(api_ghost_url)

}

#' Creates a post object to be passed on when a post is created or updated.
#' @description
#' Please review the api \href{https://github.com/TryGhost/Ghost/wiki/}{unofficial documentation} from ghost to obtain official information.Please review the official documentation \href{http://api.ghost.org/v0.1-alpha/docs} once it is released.
#' @param post_body is a vector with named objects. The title and markdown object are required. The other object are optional.
#'#' \itemize{
#'   \item title [required]: The post title (string).
#'   \item markdown [required] : the markdown content to be converted by Ghost to html. This contains all the content of your post (string)
#'   \item slug: The url where you post can be accessed. Ghost automagically create a slug based on the input. Spaces and other non alpanumeric characters will be escaped by Ghost. Any string is valid, if nothing is provided Ghost will create a slug for you. (string)
#'   \item status: Can either take draft or published. Default is draft. (string)
#'   \item featured: If a post is featured or not.Default is false (boolean).
#'   \item image: url to an image. Depending on the ghost template the image will be used as a cover (string)
#'   \item page: Indicated is the post serves as a static page. Default is false (boolean)
#'   \item author: The author id of the author of the post.(integer
#'   \item tags: list of tags objects (see ghost documentation for a description of the tag object. )
#' }
#'
#'
#'
#'
#' @return Response object. See the \code{\link{construct_response}} function.
#' @examples
#' post_body <- c(
#` title    = "PostTitle",
#' markdown = 'Content',
#' slug     = "Slug",
#' status   = "Publish",
#' image    = 'Image',
#' featured = Featured,
#' page     = "0",
#' author   = Author,
#' tags     = list(TagsList)
#' )
#'
#' post_body <- construct_post(post_body)
construct_post <- function(post_body){
  # do error checking is this is a valid object
  body <- list("posts"= list(post_body))
}

#' Converts the return JSON object into a nested R list.
#' @description
#' Converts the return JSON object into a nested R list. Currently using jsonlite to parse the content.
#' @param post_body a JSON object containing the content to be converted to R.
#' @return Nested r list representation of the parsed object.
parse_content <- function(post_body){
   parsed_content <- fromJSON(content(post_body,as="text"),flatten=TRUE)
   return(parsed_content)
}
