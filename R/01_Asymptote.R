# Asymptote Modules -----------------------------

## UI -----------------------------------------
AsymptoteUI <- function(id, label = "01_Asymptote"){
  ns <- NS(id)
  
  tabPanel("1. Asymptote",
           tags$h1(tags$b("Tool 1. Has a concentration vs time asymptote been reached at my site?"))
  )
} # end Asymptote UI         


## Server Module -----------------------------------------
AsymptoteServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {

    }
  )
} # end Asymptote Server     