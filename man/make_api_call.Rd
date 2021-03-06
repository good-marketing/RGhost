% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/make_api_call.R
\name{make_api_call}
\alias{make_api_call}
\title{make_api_call}
\usage{
make_api_call(request_type, ghost_url, post_body)
}
\arguments{
\item{request_type}{Can take one of four values. POST for creating a post,GET for obtaining information,DELETE for deleting posts.,PUT for updating a existing post.}

\item{ghost_url}{the endpoint (including url parameters) where to call the ghost api.}

\item{post_body}{IF a POST or PU request is made a valid post object is required.}
}
\value{
Response object. See the \code{\link{construct_response}} function.
}
\description{
Function to call the Ghost api.
}
\examples{
make_api_call("POST",ghost_url,post_body)
}

