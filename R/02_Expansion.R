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
      # library(stringr)
      # library(sp)
      # library(dismo)
      # library(tripack)
      # library(sf)
      # 
      # # call in functions
      # lapply(paste0("./R/Functions/",
      #               list.files(path = "./R/Functions",
      #                          pattern = "[.]R$",
      #                          recursive = TRUE),
      #               sep=''),
      #        source)
      # 
      # #-----read in files
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
      # # Calculate MK test and Sen's slope and export table
      # #------all monitoring wells
      # MWs <- unique(df_MW_compiled$WellID)
      # Trend_MK <- MannKendall_MAROS(df_MW_compiled,MWs,'WellID','Concentration')
      # 
      # 
      # 
      # # check whether all, downgradient, and abovegoal is downgradient or stable?
      # check <- tail(Trend_MK,3)%>%
      #   mutate(count = ifelse(Trend%in%c('Decreasing','Probably Decreasing','Stable'),1,0))
      # Plume_expand = ifelse(sum(check$count)>=2,'NO','YES')
      # 
      # 
      # 
      # #visualize the results
      # name = 'all' # or 'downgradient'
      # log_flag = 'linear' #or 'log'
      # 
      # p<-graph_vis(df_MW_compiled,name,log_flag,'Concentration')
      # 
      # 
      # # calculate mass of plume, mass_df exports the table OVERALL 
      # # total_mass_kg is the dissolved plume mass (kg)
      # porosityHK = 0.35
      # porosityLK = 0.3
      # thicknessHK = 50
      # thicknessLK = 20
      # mass_df<-sp_interpolation(df_MW_compiled,Location,
      #                            porosityHK,porosityLK,
      #                            thicknessHK,thicknessLK)
      # # low K, high K, and total should be the end date of the mass_df
      # 
      # approx_percent_mass_in_LowK = tail(mass_df$lowK_mass_kg/mass_df$total_mass_kg,1)
      # 
      # 
      # # specific date to filter
      # specificdate<-unique(mass_df$Date)
      # 
      # #dummy column to make it run with MannKendall_Maros
      # mass_df$WellID = 'M'
      # 
      # # export MK and Sens results
      # mass_MK <- MannKendall_MAROS(mass_df,'M','WellID','total_mass_kg')
      # 
      # # generate graph for dissolved mass
      # log_flag2 = 'log' #or 'linear'
      # p2<-graph_vis(mass_df,'M',log_flag2,'total_mass_kg')
      
    }
  )
} # end Expansion Server 
      