# USER INTERFACE -------------
## Load packages -------------

library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)
require(shinyWidgets)

require(DT)
# require(dbplyr)
# 
require(leaflet)
require(leaflet.extras)
# 
# require(plotly)

## Define UI ---------------------------------
shinyUI <- navbarPage(theme="styles.css", 
                      collapsible = TRUE, fluid=TRUE, 
                      windowTitle = "SERDP Transition Assessment Assistant",
                      title=div(a(" ",
                                  img(src = "https://www.serdp-estcp.org/design/hgl_user/images/mainLogo-serdp-estcp.png", width = "75%", height = "75%"),
                                  href = 'https://serdp-estcp.org/', target="_blank")),
                      id="nav",
                      # Tab panels 
                      tabPanel("Home",
                               includeHTML("./www/00a_Home-Page/home.html"),
                               tags$script(src = "./plugins/scripts.js"),
                               tags$head(
                                 tags$link(rel = "stylesheet", 
                                           type = "text/css", 
                                           href = "./plugins/font-awesome-4.7.0/css/font-awesome.min.css"),
                                 tags$link(rel = "icon",  
                                           type = "image/png", 
                                           href = "./images/logo_icon.png")
                               )
                   ), #end home tab
                   
                   tabPanel("About",
                            fluidRow(
                              column(9,
                                     includeMarkdown("./www/00b_About/app_info.md"))
                            )# end Fluid Row
                   ), #end About tab
                   
                   Data_Input_UI("Data_Input"),
                   
                   AsymptoteUI("01_Asymptote"),
                   
                   TrendUI("02_Trend"),

                   # ExpansionUI("02_Expansion"),

                   #BordenToolUI("Borden_Tool"),
                   
                   #CleanupGoalsUI("03_CleanupGoals"),
                   CleanupGoals_tabUI("03_CleanupGoals_tab"),
                   
                   # CleanupGoals_MCtabUI("03_CleanupGoals_MCtab"),
                   #CleanupGoals_linearUI("03_CleanupGoals_linear"),

                   PerformanceUI("04_Performance"),

                   MatrixDiffusionUI("05_MatrixDiffusion"),
                   
                   EnhanceMNAUI("06_EnhanceMNA"),
                   
                   # tabPanel("6. Enhanced MNA",
                   #          fluidRow(
                   #            column(9,
                   #                   includeMarkdown("./www/06_MNA/app_info.md"))
                   #          )# end Fluid Row
                   # ), #end MNA tab
                   # 
                   
                   
                   HeterogeneityUI("07_Heterogeneity"), 
                   
                   # tabPanel("8. GW Models",
                   #          fluidRow(
                   #            column(9,
                   #                   includeMarkdown("./www/08_GWModels/app_info.md"))
                   #          )# end Fluid Row
                   # ), #end GW_Models tab
                   
                   PlumeZoneUI("08_PlumeZone"), 
                   
                   SERDPUI("09_OtherProject"), 
                   
                   SummaryUI("10_Summary"), 
                   
                   footer = HTML('<a href="https://www.gsi-net.com/en/" target="_blank">
                   <div style="background-color: #112447; padding: 10px; margin-right: 0;  margin-left: 0;">
                                   <h3 class="featurette-heading" style="color:white;" ><i>Powered by <b>GSI Environmental</b> (2022)</i></h3>
                                   </div></a>')
                   

) # End UI


