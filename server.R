# This is the server logic of this Shiny web application. 

library(shiny)

# Define server logic 
shinyServer(function(input, output, session) {
  nav <- reactive(input$nav)
  
  data_input <- Data_Input_Server("Data_Input")
  
  AsymptoteServer("01_Asymptote", data_input = data_input, nav = nav)

  TrendServer("02_Trend", data_input = data_input, nav = nav)

   CleanupGoals_tabServer("03_CleanupGoals_tab", nav = nav)
 
   PerformanceServer("04_Performance")
  
   PlumeZoneServer("05_PlumeZone", data_input = data_input, nav = nav)
  
   MatrixDiffusionServer("06_MatrixDiffusion")
  
   HeterogeneityServer("08_Heterogeneity")

  SummaryServer("10_Summary")

})
