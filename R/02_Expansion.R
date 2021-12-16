# Expansion Modules -----------------------------

## UI Module -----------------------------------------
ExpansionUI <- function(id, label = "02_Expansion"){
  ns <- NS(id)
  
  tabPanel("2. Expansion",
           tags$h1(tags$b("Tool 2. Is my plume still expanding?"))
  )
} # end Expansion UI         


## Server Module -----------------------------------------
ExpansionServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
     
      ## FOLLOWING IS THE CHEAT SHEET OF CALLING EACH FUNCTION
      ##CHEAT SHEET
      # library(tidyverse)
      # library(readxl)
      # library(plotly)
      # library(EnvStats)
      # library(trend)
      # library(ggsci)
      # -----read in files
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
      # 
      # # ----- monitoring well group which are downgradient well
      # pickwelldown<-c('MW-7','MW-8','MW-9')
      # 
      # 
      # # ----- STEP 3: choose Mann-Kendall Test or Sens's Test
      # Trend_switch = 'MK' #or Sen
      # 
      # # ----- STEP 4: choose whether mean or geomean
      # ave_switch = 'mean' #or geomean
      # 
      # 
      # # ----- STEP 5: concentration goal
      # C_goal <-0.5
      # 
      # 
      # # compile the data for mean or geomean (each monitoring well, each group)
      # df_MW_compiled <- df_series_tool2a(df,pickwelldown,ave_switch,C_goal)
      # 
      # # choose which trend test to analyze
      # if (Trend_switch=='MK'){
      #   Trend_df <- MannKendall_MAROS(df_MW_compiled)
      # }else{
      #   Trend_df <- SENS_MAROS(df_MW_compiled)
      # }
      # 
      # #visualize the results
      # name = 'all' # or 'downgradient'
      # log_flag = 'linear' #or 'log'
      #
      # graph_vis(df_MW_compiled,name,log_flag)    
      
      
      
      
      
    }
  )
} # end Expansion Server 
      