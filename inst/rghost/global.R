library (RGhost)
library(shiny)
library(shinyBS)
library(shinyAce)
library(shinyFiles)
library(shinyStore)
library(shinybootstrap2)
library(rmarkdown)
library(httr)
library(rCharts)
library(jsonlite)

library(tools)
library(rlist)
library(knitr)
opts_knit$set(upload.fun = imgur_upload, base.url = NULL)
opts_chunk$set(comment = NA, results = "asis", comment = NA, tidy = F)
#set img upload to imgur
library(ggplot2)

## Set Clinet variables


bsNavDropDown2 <- function (inputId, label, choices, ids, selected = "") {
  if (!inherits(label, "shiny.tag"))
    label <- HTML(label)

  choices <- lapply(choices, FUN = function(choice) {
    if (length(choice) == 1) {
      tags$li(tags$a(tabindex = "-1",
                     href = "#", HTML(choice), class="action-button"))
    } else {
      tags$li(tags$a(tabindex = "-1",
                     href = "#", id = choice[2],
                     HTML(choice[1])))
    }
  })

  tags$li(id = inputId, class = "dropdown sbs-dropdown", `data-value` = selected,
          tags$a(href = "#", class = "dropdown-toggle", `data-toggle` = "dropdown",
                 label, tags$b(class = "caret")), tags$ul(class = "dropdown-menu", choices))
}

preview <- function(rmd) {
  if (grepl("---\n(.*?)\n---", rmd)) {
    rmd <-  sub("---\n(.*?)\n---", "", rmd)
    rmd <- sub("\n\n", "", rmd)
  }

  paste0("`r opts_chunk$set(cache = TRUE, autodep = TRUE)` \n\n", rmd, "\n\n")
}


