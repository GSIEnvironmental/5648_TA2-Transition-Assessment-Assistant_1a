# Asymptote Modules -----------------------------

## UI -----------------------------------------
PlumeZoneUI <- function(id, label = "09_PlumeZone"){
  ns <- NS(id)
  
  tabPanel("8. Plume Zone",
           HTML("<h1 style='color:red;'><i>Under Construction</i></h1>"), br(),
           tags$h1(tags$b("Tool 9. Plume Assimilative Capacity Zone Calculator.")), 
           br(), br()
  )
} # end Asymptote UI         


## Server Module -----------------------------------------
PlumeZoneServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Asymptote Server     