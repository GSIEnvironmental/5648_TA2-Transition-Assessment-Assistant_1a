## Heterogeneity Modules -----------------------------

## UI -------------------------------------------
HeterogeneityUI <- function(id, label = "07_Heterogeneity"){
  ns <- NS(id)
  
  tabPanel("7. Heterogeneity",
           tags$h1(tags$b("Tool 7. Understand how much geologic heterogeneity there is at a site."))
  )
} # end Heterogeneity UI         


## Server Module -----------------------------------------
HeterogeneityServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Heterogeneity Server 



