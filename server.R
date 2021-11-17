# This is the server logic of this Shiny web application. 

library(shiny)

# Define server logic 
shinyServer(function(input, output, session) {
  
  AsymptoteServer("01_Asymptote")
  
  ExpansionServer("02_Expansion")
  
  #BordenToolServer("Borden_Tool")
  #CleanupGoalsServer("03_CleanupGoals")
  #CleanupGoals_linearServer("03_CleanupGoals_linear")
  
  CleanupGoals_tabServer("03_CleanupGoals_tab")
  
  # CleanupGoals_MCtabServer("03_CleanupGoals_MCtab")
  
  PerformanceServer("04_Performance")
  
  MatrixDiffusionServer("05_MatrixDiffusion")
  
  HeterogeneityServer("07_Heterogeneity")
  
  PlumeZoneServer("09_PlumeZone")
  
  SummaryServer("10_Summary")


})
