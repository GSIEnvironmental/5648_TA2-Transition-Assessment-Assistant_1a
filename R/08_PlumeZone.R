# Asymptote Modules -----------------------------

## UI -----------------------------------------
PlumeZoneUI <- function(id, label = "08_PlumeZone"){
  ns <- NS(id)
  
  tabPanel("8. Plume Zone",
           tags$h1(tags$b("Tool 8. Plume Assimilative Capacity Zone Calculator.")),
           HTML("<h3><p style='color:red;'>This tool is currently under development.</h3></p>")
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