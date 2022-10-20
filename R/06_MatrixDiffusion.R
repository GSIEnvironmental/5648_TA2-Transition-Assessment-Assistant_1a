## Matrix Diffusion Modules -----------------------------

## UI Module --------------------------------------
MatrixDiffusionUI <- function(id, label = "06_MatrixDiffusion"){
  ns <- NS(id)
  
  tabPanel("6. Matrix Diffusion",
           #tags$h1(tags$b("Tool 6. Model a groundwater plume and account for matrix diffusion.")),
           tabsetPanel(
             
             tabPanel(HTML("6a History of TA"),
                      HTML("<H2>Tool 6a.  History of Transition Assessments (TA)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/06_Matrix/Tool6a_v1.md'))
                      ), 
             tabPanel(HTML("6b MD Case Study"),
                      HTML("<H2>Tool 6b.  Matrix Diffusion Case Study: Pump and Treat Site</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/06_Matrix/Tool6b_v1.md'))
             ), 
             tabPanel(HTML("6c Models for TA"),
                      HTML("<H2>Tool 6c.  Potential computer models for Transition Assessments (TA)</H2>"),
                      br(),
                      bsCollapse(id = "collapseExample", open = "",
                                 bsCollapsePanel("OVERVIEW",
                                                 includeMarkdown('./www/06_Matrix/Tool6c_v1.md'), 
                                                 style = "info"),
                                 bsCollapsePanel("EIGHT WAYS TO SIMULATE MATRIX DIFFUSION AND REMEDIATION",
                                                 includeMarkdown('./www/06_Matrix/Tool6c_v2.md'),
                                                 style = "info"),
                                 bsCollapsePanel("REFERENCES", 
                                                 includeMarkdown('./www/06_Matrix/Tool6c_v3.md'),
                                                 style = "info")
                                 
                      )), 
           tabPanel(HTML("6d REMChlor-MD"),
                    HTML("<H2>Tool 6d.  How can I model a groundwater plume to support a Transition Assessment (TA)?</H2>"),
                    br(),
                    bsCollapse(id = "collapseExample", open = "",
                               bsCollapsePanel("REMCHLOR‑MD MODEL OVERVIEW",
                                               includeMarkdown('./www/06_Matrix/Tool6d_v1.md'),
                                               style = "info"),
                               bsCollapsePanel("HOW TO USE REMChlor-MD FOR TRANSITION ASSESSMENTS",
                                               includeMarkdown('./www/06_Matrix/Tool6d_v2.md'),
                                               style = "info"),
                               bsCollapsePanel("KEY PARAMETERS FOR REMChlor-MD",
                                               includeMarkdown('./www/06_Matrix/Tool6d_v3.md'),
                                               style = "info"),
                               bsCollapsePanel("HOW TO CALIBRATE REMChlor-MD",
                                               includeMarkdown('./www/06_Matrix/Tool6d_v4.md'),
                                               style = "info"),
                               bsCollapsePanel("REMCHLOR-MD ASSUMPTIONS AND LIMITATIONS",
                                               includeMarkdown('./www/06_Matrix/Tool6d_v6.md'),
                                               style = "info"),
                               bsCollapsePanel("REFERENCES",
                                               includeMarkdown('./www/06_Matrix/Tool6d_v7.md'),
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

