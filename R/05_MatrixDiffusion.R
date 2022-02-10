## Matrix Diffusion Modules -----------------------------

## UI Module --------------------------------------
MatrixDiffusionUI <- function(id, label = "05_MatrixDiffusion"){
  ns <- NS(id)
  
  tabPanel("5. Matrix Diffusion",
           tags$h1(tags$b("Tool 5. Model a groundwater plume and account for matrix diffusion.")),
           
           bsCollapse(id = "collapseExample", open = "Panel 2",
                      bsCollapsePanel("Panel 1", "This is a panel with just text ",
                                      "and has the default style. You can change the style in ",
                                      "the sidebar.", style = "info"),
                      bsCollapsePanel("Panel 2", "This panel has a generic plot. ",
                                      "and a 'success' style.", style = "info")
           )
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

