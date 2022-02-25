## Summary Modules -----------------------------

## UI -------------------------------------------
SummaryUI <- function(id, label = "010_Summary"){
  ns <- NS(id)
  
  tabPanel("10. Summary",
           tags$h1(tags$b("Tool 10. Summary and Plume Persistence Index.")),
           HTML("<h3><p style='color:red;'>This tool is currently under development.</h3></p>")
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



