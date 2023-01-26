# This is the server logic of this Shiny web application. 

library(shiny)

# Define server logic 
shinyServer(function(input, output, session) {
  nav <- reactive(input$nav)
  
  data_input <- Data_Input_Server("Data_Input")
  
  LOE_asymp <- AsymptoteServer("01_Asymptote", data_input = data_input, nav = nav)

  MKresult <- TrendServer("02_Trend", data_input = data_input, nav = nav)

  Cleantime <- CleanupGoals_tabServer("03_CleanupGoals_tab", nav = nav)
 
  Presult <- PerformanceServer("04_Performance")
  
   PlumeZoneServer("05_PlumeZone", data_input = data_input, nav = nav)
  
   MatrixDiffusionServer("06_MatrixDiffusion")
   
  RTAI_EA<- EnhanceMNAServer("07_EnhanceMNA", data_input = data_input, nav = nav)
   
   HeterogeneityServer("08_Heterogeneity")

  SummaryServer("10_Summary",LOE_asymp = LOE_asymp, MKresult=MKresult, 
                Cleantime = Cleantime, Presult = Presult, RTAI_EA = RTAI_EA)

})
