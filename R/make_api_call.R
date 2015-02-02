#' make_api_call
#' @description
#' Function to call the Ghost api.
#' @param request_type Can take one of four values. POST for creating a post,GET for obtaining information,DELETE for deleting posts.,PUT for updating a existing post.
#' @param ghost_url the endpoint (including url parameters) where to call the ghost api.
#' @param post_body IF a POST or PU request is made a valid post object is required.
#' @return Response object. See the \code{\link{construct_response}} function.
#' @examples
#' make_api_call("POST",ghost_url,post_body)


make_api_call <- function(request_type,ghost_url, post_body ){

  access_token <- get_ghost_token()

  switch(request_type,
         POST = POST(ghost_url,
                    # encode="json",
                    body = toJSON(post_body,auto_unbox=TRUE),
                    verbose(),
                    add_headers(
                      "Content-Type" = "application/json",
                      "Authorization" = paste('Bearer', access_token) ,
                      "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")),

         GET = GET(ghost_url,
                      verbose(),
                      add_headers(
                        "Content-Type" = "application/json",
                        "Authorization" = paste('Bearer', access_token) ,
                        "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")
  )
,
         PUT = PUT(ghost_url,
                   body = toJSON(post_body,auto_unbox=TRUE),
                   verbose(),
                   add_headers(
                     "Content-Type" = "application/json",
                     "Authorization" = paste('Bearer', access_token) ,
                     "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")
         ),
          DELETE = DELETE(ghost_url,
                    verbose(),
                    add_headers(
                      "Content-Type" = "application/json",
                      "Authorization" = paste('Bearer', access_token) ,
                      "User-Agent"="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36")
          )
    )


}

