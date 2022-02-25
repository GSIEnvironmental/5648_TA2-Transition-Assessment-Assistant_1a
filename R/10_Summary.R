## Summary Modules -----------------------------

## UI -------------------------------------------
SummaryUI <- function(id, label = "010_Summary"){
  ns <- NS(id)
  
  tabPanel("10. Summary",
           HTML("<h1 style='color:red;'><i>Under Construction</i></h1>"), br(),
           tags$h1(tags$b("Tool 10. Summary and Plume Persistence Index.")), 
           br(), br()
  )
} # end Summary UI         


## Server Module -----------------------------------------
SummaryServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Summary Server 



