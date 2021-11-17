# Expansion Modules -----------------------------

## UI Module -----------------------------------------
ExpansionUI <- function(id, label = "02_Expansion"){
  ns <- NS(id)
  
  tabPanel("2. Expansion",
           tags$h1(tags$b("Tool 2. Is my plume still expanding?"))
  )
} # end Expansion UI         


## Server Module -----------------------------------------
ExpansionServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Expansion Server 
      