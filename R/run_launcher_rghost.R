#' launch_rghost_app
#' @description
#' Launches the associated shiny application. The shiny application implements the RGhost package and allows the user to take advantage of parsing R code to markdown and then posting this to Ghost. See the file for more information.
#' @examples
#' run_RGhost_app ()


launch_rghost_app <- function()
  shiny::runApp(
    system.file('rghost',
                package='RGhost'))
