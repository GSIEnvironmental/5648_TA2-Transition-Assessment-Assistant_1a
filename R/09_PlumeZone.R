# Asymptote Modules -----------------------------

## UI -----------------------------------------
PlumeZoneUI <- function(id, label = "09_PlumeZone"){
  ns <- NS(id)
  
  tabPanel("9. Plume Zone",
           tags$h1(tags$b("Tool 9. Plume Assimilative Capacity Zone Calculator."))
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