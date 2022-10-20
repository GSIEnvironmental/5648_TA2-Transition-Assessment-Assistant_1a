## Matrix Diffusion Modules -----------------------------

## UI Module --------------------------------------
EnhanceMNAUI <- function(id, label = "07_EnhanceMNA"){
  ns <- NS(id)
  
  tabPanel("7. EA",
           #tags$h1(tags$b("Tool 5. Model a groundwater plume and account for matrix diffusion.")),
           tabsetPanel(
             
             tabPanel(HTML("7a Introduction"),
                      HTML("<H2>Tool 7a. How to enhance Monitored Natural Attenuation processes</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7a.md'))
             ), 
             tabPanel(HTML("7b EA for Sources"),
                      HTML("<H2>Tool 7b. Source Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7b.md'))
             ), 
             tabPanel(HTML("7c EA for Plumes"),
                      HTML("<H2>Tool 7c. Plume Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7c.md'))
                      ), 
             tabPanel(HTML("7d EA for Discharges"),
                      HTML("<H2>Tool 7d. Discharge Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7d.md'))
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

