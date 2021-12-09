#################################################################

#%% ----- Function for generating forecast table

##------ INPUT
# three inputs are required here 
# df: this dataframe is the result from summary_table.R
# Conc_goal: concentration goal for remediation (user need to input)
# Conc_site: concentration at the site (user need to input)


# --- calculate after remediation values

ForcastResults<-function(df,Conc_goal,Conc_site){
  
  
  # export summary table
  summary_df = as.data.frame(describe(df,fast=TRUE))
  
  ##---- empirical Remediation Performance Stats
  
  # % reduction
  Rem_mean = ifelse(summary_df$mean[8]<0,'increasing',summary_df$mean[8]*100)
  Rem_min = ifelse(summary_df$min[8]<0,'increasing',summary_df$min[8]*100)
  Rem_max = ifelse(summary_df$max[8]<0,'increasing',summary_df$max[8]*100)
  
  # order of OoM reduction needed
  OoM_mean = summary_df$mean[11]
  OoM_min = summary_df$min[11]
  OoM_max = summary_df$max[11]
  
  
  ##---- If In-Situ Remediation if Performed How much closer to the 
  ##---- cleanup goal will you get?
  
  
  # generate calculation for forecast, after remediation OoM and Percent reach
  Result_list<-function(Rem_mean,OoM_mean,Conc_goal,Conc_site){
    
    # after remediation, forecasted % reduction still needed
    Forcast = ifelse(Rem_mean=='increasing','increasing',
                     ifelse(1-(Conc_goal/(Conc_site*(1-Rem_mean/100)))<0,'Goal Achieved',
                            1-(Conc_goal/(Conc_site*(1-Rem_mean/100)))*100))
    
    # after remediation, OoM reduction needed
    OoM_need = log10(Conc_site*(1-summary_df$mean[8])/Conc_goal)
    
    # after remediation, Percent way to reach criteria
    Percent_reach = ifelse(1-(1-10^(-OoM_need))>1,'Goal Achieved',1-(1-10^(-OoM_need)))
    
    Results = c(Rem_mean,OoM_mean,Forcast,OoM_need,Percent_reach)
    
    return(Results) 
  }
  
  Mean_list = Result_list(Rem_mean,OoM_mean,Conc_goal,Conc_site)
  Low_list = Result_list(Rem_min,OoM_min,Conc_goal,Conc_site)
  High_list = Result_list(Rem_max,OoM_max,Conc_goal,Conc_site)
  
  
  
  Result_table = list('Mean_list' = Mean_list,
                      'Low_list' = Low_list,
                      'High_list' = High_list)
  
  return(Result_table)
}
