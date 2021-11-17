## Matrix Diffusion Modules -----------------------------

## UI Module --------------------------------------
MatrixDiffusionUI <- function(id, label = "05_MatrixDiffusion"){
  ns <- NS(id)
  
  tabPanel("5. Matrix Diffusion",
           tags$h1(tags$b("Tool 5. Model a groundwater plume and account for matrix diffusion."))
  )
} # end Matrix Diffusion UI         


## Server Module -----------------------------------------
MatrixDiffusionServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Matrix Diffusion Server 

