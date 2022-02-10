## Matrix Diffusion Modules -----------------------------

## UI Module --------------------------------------
MatrixDiffusionUI <- function(id, label = "05_MatrixDiffusion"){
  ns <- NS(id)
  
  tabPanel("5. Matrix Diffusion",
           #tags$h1(tags$b("Tool 5. Model a groundwater plume and account for matrix diffusion.")),
           tabsetPanel(

             tabPanel(HTML("5c Models for TA"),
                      HTML("<H2>Tool 5c.  Potential computer models for Transition Assessments (TA)</H2>"),
                      br(),
                      bsCollapse(id = "collapseExample", open = "",
                                 bsCollapsePanel("OVERVIEW",
                                                 includeMarkdown('./www/05_Matrix/Tool5c_v1.md'), 
                                                 style = "info"),
                                 bsCollapsePanel("EIGHT WAYS TO SIMULATE MATRIX DIFFUSION AND REMEDIATION",
                                                 includeMarkdown('./www/05_Matrix/Tool5c_v2.md'),
                                                 style = "info"),
                                 bsCollapsePanel("REFERENCES", 
                                                 includeMarkdown('./www/05_Matrix/Tool5c_v3.md'),
                                                 style = "info")
                                 
                      )), 
           tabPanel(HTML("5d REMChlor-MD"),
                    HTML("<H2>Tool 5d.  How can I model a groundwater plume to support a Transition Assessment (TA)?</H2>"),
                    br(),
                    bsCollapse(id = "collapseExample", open = "",
                               bsCollapsePanel("REMCHLOR‑MD MODEL OVERVIEW",
                                               includeMarkdown('./www/05_Matrix/Tool5d_v1.md'),
                                               style = "info"),
                               bsCollapsePanel("HOW TO USE REMChlor-MD FOR TRANSITION ASSESSMENTS",
                                               includeMarkdown('./www/05_Matrix/Tool5d_v2.md'),
                                               style = "info"),
                               bsCollapsePanel("KEY PARAMETERS FOR REMChlor-MD",
                                               includeMarkdown('./www/05_Matrix/Tool5d_v3.md'),
                                               style = "info"),
                               bsCollapsePanel("HOW TO CALIBRATE REMChlor-MD",
                                               includeMarkdown('./www/05_Matrix/Tool5d_v4.md'),
                                               style = "info"),
                               bsCollapsePanel("HOW TO DO MODEL IMPACT OF REMEDIATION PROJECTS",
                                               includeMarkdown('./www/05_Matrix/Tool5d_v5.md'),
                                               style = "info"),
                               bsCollapsePanel("REMCHLOR-MD ASSUMPTIONS AND LIMITATIONS",
                                               includeMarkdown('./www/05_Matrix/Tool5d_v6.md'),
                                               style = "info"),
                               bsCollapsePanel("REFERENCES",
                                               includeMarkdown('./www/05_Matrix/Tool5d_v7.md'),
                                               style = "info")

                    )
                    )
           
  ))
} # end Matrix Diffusion UI         


## Server Module -----------------------------------------
MatrixDiffusionServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Matrix Diffusion Server 

