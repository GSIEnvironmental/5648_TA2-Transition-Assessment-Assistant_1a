#################################################################

#%% ----- Function for getting the data frame file to process

##------ INPUT
# three inputs are required here 
# df: input remediation performance database
# COC_flag: STEP1 choose sites with COC
# Con_flag: STEP2 choose sites with pre remediation max concentrations

summary_table<-function(df,COC_flag,Con_flag){
  
  

  # database input and put the flag for remediation and Benzene only
  
  df <- df%>%
    mutate(Rem_flag=ifelse(Technology%in%
                             c("Bioremediation",
                               "Chemical Oxidation",
                               "Chemical Reduction",
                               "Chemical Reduction / Bioremediation",
                               "MNA",
                               "Surfactant",
                               "Thermal Treatment"),1,0),
           Ben_flag=ifelse(Technology%in%
                             c("Air Sparging",
                               "Chemical Oxidation",
                               "LNAPL recovery",
                               "Mobilizing Surfactant",
                               "MNA",
                               "Pump and Treat",
                               "Solubilizing Surfactant"),1,0)
    )
  
  # how about ISCO???  

  
  #filter data with COC and Concentration range
  if (COC_flag!='all'){
    df<-df%>%filter(`Parent CVOC`%in% COC_flag)
  }
  
  if (Con_flag!='all'){
    df<-df%>%filter(between(`Parent Maximum Before, ug/L`,Con_flag[1],Con_flag[2]))
  }
  
  # split between VOC and Benzene
  df_VOC<-df%>%filter(Rem_flag==1)
  df_Benz<-df%>%filter(Ben_flag==1)
  
  
  Num_Proj = nrow(df)
  
  
  Results = list('df_filter' = df,
                 'Num_Proj' = Num_Proj,
                 'df_VOC' = df_VOC,
                 'df_Benz' = df_Benz)
  
  return(Results)
}



