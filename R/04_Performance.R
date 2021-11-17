## Performance Modules -----------------------------

## UI Module ------------------------------------------
PerformanceUI <- function(id, label = "04_Performance"){
  ns <- NS(id)
  
  tabPanel("4. Performance",
           tags$h1(tags$b("Tool 4. What level of performance can I expect from an in-situ source remediation projects?"))
  )
} # end Performance UI         


## Server Module -----------------------------------------
PerformanceServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Performance Server 