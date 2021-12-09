## Performance Modules -----------------------------

## UI Module ------------------------------------------
PerformanceUI <- function(id, label = "04_Performance"){
  ns <- NS(id)
  
  tabPanel("4. Performance",
           tags$h1(tags$b("Tool 4. What level of performance can I expect from an in-situ source remediation projects?"))
  )
} # end Performance UI         


## Server Module -----------------------------------------
PerformanceServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      ## FOLLOWING IS THE CHEAT SHEET OF CALLING EACH FUNCTION
      ##CHEAT SHEET
      
      # library(tidyverse)
      # library(readxl)
      # library(ggplot2)
      # library(ggrepel)
      # library(psych)
      # library(scales)
      # 
      # # call in functions
      # lapply(paste0("./R/Functions/",
      #               list.files(path = "./R/Functions",
      #                          pattern = "[.]R$",
      #                          recursive = TRUE),
      #               sep=''),
      #        source)
      # 
      # df <- read_excel("C:/Users/hmori/Desktop/GSI Work Files/5648_SERDP_Borden/TA2 ESTCP Remediation Performance Database.xlsx",
      #                  range = "A2:K308",
      #                  sheet = "Sheet1")
      # 
      # # ---- add linear line for the regression
      # linear_df <- read_excel("C:/Users/hmori/Desktop/GSI Work Files/5648_SERDP_Borden/TA2 ESTCP Remediation Performance Database.xlsx", 
      #                         sheet = "Sheet2")
      # 
      # # ---- these are the user inputs for COC, Concentration range, Concentration at the site, and Concentration goal
      # COC_flag = 'all'
      # Con_flag = 'all'
      # 
      # Conc_site = 1000
      # Conc_goal = 0.1
      # 
      # 
      # #generate filtered table
      # filtered_table <- summary_table(df,COC_flag,Con_flag)
      # 
      # # reassign the name of each data frame for
      # # df_filter: filtered dataframe remediation performance
      # # Num_Proj: number of project
      # # df_VOC: dataframe for VOC
      # # df_Benz dataframe for Benzene
      # 
      # for (var in 1:length(names(filtered_table))){
      #   nam<-names(filtered_table)[var]
      #   assign(nam, (filtered_table[[var]]))
      # }
      # 
      # # generate figure for VOC and Benz
      # Rem_Perf_fig_VOC <- Rem_Perf_fig(df_VOC,linear_df,"Chlorinated Solvents")
      # Rem_Perf_fig_Benz <- Rem_Perf_fig(df_Benz,linear_df,"Benzene")
      # 
      # 
      # #generate the list of data middle range, low range, and high range
      # Result_table <- ForcastResults(df_filter,Conc_goal,Conc_site)
      # 
      # for (var in 1:length(names(Result_table))){
      #   nam<-names(Result_table)[var]
      #   assign(nam, (Result_table[[var]]))
      # }
      # 
      
      
      

      
      
    }
  )
} # end Performance Server 