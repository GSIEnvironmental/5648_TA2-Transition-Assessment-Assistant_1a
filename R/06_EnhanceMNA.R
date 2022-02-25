## Matrix Diffusion Modules -----------------------------

## UI Module --------------------------------------
EnhanceMNAUI <- function(id, label = "06_EnhanceMNA"){
  ns <- NS(id)
  
  tabPanel("6. EA",
           #tags$h1(tags$b("Tool 5. Model a groundwater plume and account for matrix diffusion.")),
           tabsetPanel(
             
             tabPanel(HTML("6a Introduction"),
                      HTML("<H2>Tool 6a. How to enhance Monitored Natural Attenuation processes</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/06_MNA/Tool6a.md'))
             ), 
             tabPanel(HTML("6b EA for Sources"),
                      HTML("<H2>Tool 6b. Source Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/06_MNA/Tool6b.md'))
             ), 
             tabPanel(HTML("6c EA for Plumes"),
                      HTML("<H2>Tool 6c. Plume Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/06_MNA/Tool6c.md'))
                      ), 
             tabPanel(HTML("6d EA for Discharges"),
                      HTML("<H2>Tool 6d. Discharge Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/06_MNA/Tool6d.md'))
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

