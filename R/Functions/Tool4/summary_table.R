#################################################################

#%% ----- Function for getting the data frame file to process

##------ INPUT
# three inputs are required here 
# df: input remediation performance database
# COC_flag: STEP1 choose sites with COC
# Con_flag: STEP2 choose sites with pre remediation max concentrations
# Tech_flag: list of technology to plot

summary_table<-function(df,BorC,COC_flag,Con_flag,Tech_flag){
  
  

  # database input and put the flag for remediation and Benzene only
  
  df <- df%>%
    mutate(Rem_flag=ifelse(`Parent CVOC`!='Benzene',1,0),
           Conc_flag = case_when(`Parent Maximum Before, ug/L`> 200000 ~ ">200,000 ug/L",
                                 `Parent Maximum Before, ug/L`> 2000 & `Parent Maximum Before, ug/L`<= 200000 ~ "2,000 to 200,000 ug/L",
                                 `Parent Maximum Before, ug/L`> 20 & `Parent Maximum Before, ug/L`<= 2000 ~ "20 to 2,000 ug/L",
                                 `Parent Maximum Before, ug/L`<=20 ~ "<20 ug/L")
    )
  


  
  #filter data with COC and Concentration range
  if (BorC=='C'){
    df<-df%>%filter(Rem_flag==1)
  }
  

  if(!'All Chlorinated Solvents'%in%COC_flag){
    df<-df%>%filter(`Parent CVOC`%in% COC_flag)
  }
  
  if (!'All Sites'%in%Con_flag){
    df<-df%>%filter(Conc_flag%in%Con_flag)
  }

  if (!'All Technologies'%in%Tech_flag){
    df<-df%>%filter(Technology%in%Tech_flag)
  }  
  
  Num_Proj = nrow(df)
  
  
  Results = list('df_filter' = df,
                 'Num_Proj' = Num_Proj)
  
  return(Results)
}


# output
#df_filte: filtered by concentration, chemical, and technologies


