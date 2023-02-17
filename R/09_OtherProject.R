# Asymptote Modules -----------------------------

## UI -----------------------------------------
SERDPUI <- function(id, label = "09_OtherProject"){
  ns <- NS(id)
  
  tabPanel("9. Other Projects",
           tags$h1(tags$b("Tool 9. Learn from other SERDP Transition Assessment Projects.")),
           HTML("<h3><p style='color:red;'>This tool is currently under development.</h3></p>")
  )
} # end Asymptote UI         


## Server Module -----------------------------------------
SERDPServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Asymptote Server     