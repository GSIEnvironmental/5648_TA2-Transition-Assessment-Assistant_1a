## Summary Modules -----------------------------

## UI -------------------------------------------
SummaryUI <- function(id, label = "010_Summary"){
  ns <- NS(id)
  
  tabPanel("10. Summary",
           tabsetPanel(
             
             tabPanel(HTML("10a Step-by-Step Guide"),
                      fluidRow(style='border-bottom: 5px solid black; text-align:justify;text-justify: inter-word;',
                               HTML("<H1> Tool 10a.  Step-by-Step Guide for an MNA Transition Assessment</H1>"),
                               includeCSS("./www/style/style_flip.css"),
                               column(5,
                                      HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4>This tool walks through the key steps that should be followed when conducting a site-specific transition assessment.  
                                           In this case, the primary objective is to determine if transitioning to MNA is appropriate based on site 
                                           conditions and/or the performance of on-going or prospective remedial measures.  It integrates information 
                                           from the other tools in this app, including a “Persistence Index” (Tool 10b) that reflects the relative 
                                           persistence of contamination at the site due to matrix diffusion effects. </h4>")),
                               column(5,
                                      HTML("<h3><b>How Does it Work?</b></h3>
                           <h4><ol>
                           <li> Go through Steps 1 - 3 in order to perform a comprehensive site transition assessment <i>(click on buttons below or use menu to navigate to each tool)</i>.</li> 
                           <li> Copy or transcribe the supporting information for each step so that it can be included in a site transition assessment report.</li>
                                </ol></h4>"))
                               ),
                      br(),
                      fluidRow(includeHTML('./www/10_Summary/Tool10a_v1.html'))
                               
             ), 
             tabPanel(HTML("10b Persistence Index"),
                      HTML("<H1>Tool 10b.  Persistence Index</H1>"),
                      br(),
                      #fluidRow(includeMarkdown('./www/06_Matrix/Tool6b_v1.md'))
             ), 
             tabPanel(HTML("10c Checklists"),
                      fluidRow(style='border-bottom: 5px solid black; text-align:justify;text-justify: inter-word;',
                               HTML("<H1>Tool 10c.  Checklists</H1>"),
                               includeCSS("./www/style/style_flip.css"),
                      column(5,
                             HTML("
                           <h4>The National Research Council (2012) describes the various elements that should be 
                                  considered during a Transition Assessment.  The NRC approach focused on an evaluation of alternative 
                                  remedies or long-term management options after demonstrating that asymptotic conditions have occurred for the 
                                  current remedy. For the purposes of this tool, we have included the initial steps of documenting site conditions 
                                  and complexities, as well the quantitative assessment of asymptotic trends and plume stability, in the 
                                  Transition Assessment. This tool provides checklists for each of these key elements to ensure 
                                  that the user has gathered the necessary information to support a technically rigorous 
                                  site-specific transition assessment.  It also maps out how each of the other tools in 
                                  this app can be used to assist in the overall assessment </h4>")),
                      column(7,HTML("<img src = '10_Summary/Tool10a.png' width='100%' >")
                             )),
                      
                      br(),
                      fluidRow(responsive=FALSE,
                               column(10,includeHTML('./www/10_Summary/Tool10c_v1.html')),
                               tags$style("input[type=checkbox] {
                               transform: scale(2.5);
                                          }"),
                               tags$style(".shiny-input-container {margin-bottom: 0;margin-top:0;outline:0px}"),
                               tags$style(".checkbox {margin-bottom: 0px;margin-top:4px;outline:0px}"),
                               includeCSS("./www/style/style_flip.css"),
                               checkseries(ns,button_style2),
                               helpseries(ns,button_style2)
                               ),
                      br(),
                      fluidRow(align = "center",
                               downloadButton(ns("save_data"),
                                              HTML("Save Check Box"), style = button_style))
             ),
                     
                                 
                      
             
           )
           #tags$h1(tags$b("Tool 10. Summary and Plume Persistence Index.")),
           #("<h3><p style='color:red;'>This tool is currently under development.</h3></p>")
  )
} # end Summary UI         


## Server Module -----------------------------------------
SummaryServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
    }
  )
} # end Summary Server 



