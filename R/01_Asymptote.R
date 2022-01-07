# Asymptote Modules -----------------------------

## UI -----------------------------------------
AsymptoteUI <- function(id, label = "01_Asymptote"){
  ns <- NS(id)
  
  tabPanel("1. Asymptote",
           tags$h1(tags$b("Tool 1. Has a concentration vs time asymptote been reached at my site?"))
  )
} # end Asymptote UI         


## Server Module -----------------------------------------
AsymptoteServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      ## FOLLOWING IS THE CHEAT SHEET OF CALLING EACH FUNCTION
      ##CHEAT SHEET

      # library(tidyverse)
      # library(readxl)
      # library(plotly)
      # library(stringr)
      # library(lubridate)
      # 
      # lapply(paste0("./R/Functions/",
      #               list.files(path = "./R/Functions",
      #                          pattern = "[.]R$",
      #                          recursive = TRUE),
      #               sep=''),
      #        source)
      # # -----read in files
      # location <- read_excel("C:/Users/hmori/Desktop/GSI Work Files/5648_SERDP_Borden/TA2 Module 1 2 Data File v3.xlsx",
      #                        sheet = "Data File Template", skip = 2,
      #                        n_max = 2)
      # 
      # 
      # df <- read_excel("C:/Users/hmori/Desktop/GSI Work Files/5648_SERDP_Borden/TA2 Module 1 2 Data File v3.xlsx",
      #                  sheet = "Data File Template", range = "B6:K26",
      #                  col_types = c("date", "numeric", "numeric",
      #                                "numeric", "numeric", "numeric",
      #                                "numeric", "numeric", "numeric","numeric"))
      # 
      # cname <-c('Date',colnames(location)[2:10])
      # 
      # colnames(df)<-cname
      # 
      # # ----- Step 3 monitoring well group to be averaged user input
      # pickwell<-c('MW-1','MW-2')
      # 
      # 
      # 
      # # ----- Step 4 choose whether mean or geomean user input
      # ave_switch = 'mean' #or 'geomean
      # 
      # 
      # # ----- Step 5 concentration goal user input
      # C_goal <-0.5
      # 
      # # user input
      # date_slider1 = '2012-03-02'
      # date_slider2 = '2013-08-31'
      # 
      # #################################################################
      # #  project # 5648 TA2 - Transition Assessment
      # # function for Tool 1
      # # Asymptote Analysis
      # 
      # 
      # #--- export the averaged monitoring well concentration for all period, period1, and period2
      # test<-df_series(df,ave_switch,pickwell,
      #                 date_slider1,date_slider2)
      # 
      # #--- export the fitness of the models range 1 and range 2
      # fit_test <- regression_fitness(test)
      # 
      # #--- export figure
      # p <- logscale_figure(test,fit_test,date_slider1,date_slider2)
      # 
      # # To Hannah,
      # # make sliders for choosing the date_slider1 and date_slider2
      # # --- Results return all the necessary information to fill in the cell in storyboard
      # Results <- Asymptote_Analysis(C_goal,test,fit_test)
    }
  )
} # end Asymptote Server  
