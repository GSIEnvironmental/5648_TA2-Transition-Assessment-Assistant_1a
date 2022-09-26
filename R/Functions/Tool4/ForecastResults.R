#################################################################

#%% ----- Function for generating forecast table

##------ INPUT
# three inputs are required here 
# df: this dataframe is the result from summary_table.R
# Conc_goal: concentration goal for remediation (user need to input)
# Conc_site: concentration at the site (user need to input)


# --- calculate after remediation values

ForecastResults<-function(df,Conc_goal=NULL,Conc_site){
  
  
  # export summary table
  summary_df = as.data.frame(describe(df))
  
  ##---- empirical Remediation Performance Stats
  
  # % reduction
  Rem_median = ifelse(summary_df$median[8]<0,'Increasing',summary_df$median[8]*100)
  Rem_min = ifelse(summary_df$min[8]<0,'Increasing',summary_df$min[8]*100)
  Rem_max = ifelse(summary_df$max[8]<0,'Increasing',summary_df$max[8]*100)
  
  # for calculation
  Rem_median2 = summary_df$median[8]*100
  Rem_min2 = summary_df$min[8]*100
  Rem_max2 = summary_df$max[8]*100
  
  # order of OoM reduction needed
  OoM_median = summary_df$median[11]
  OoM_min = summary_df$min[11]
  OoM_max = summary_df$max[11]
  
  
  ##---- If In-Situ Remediation if Performed How much closer to the 
  ##---- cleanup goal will you get?
  
  
  # generate calculation for forecast, after remediation OoM and Percent reach

  Result_list<-function(Rem_median,Rem_median2,OoM_median,Conc_goal=NULL,Conc_site){

    if(!is.null(Conc_goal)){
      # after remediation, forecasted % reduction still needed
      Forcast = ifelse(Rem_median=='Increasing','Increasing',
                       ifelse(1-(Conc_goal/(Conc_site*(1-Rem_median/100)))<0,'Goal Achieved',
                              signif((1-(Conc_goal/(Conc_site*(1-Rem_median/100))))*100,2)))
      
      # after remediation, OoM reduction needed
      
      OoM_need = ifelse(Conc_site*(1-Rem_median2/100)/Conc_goal<1,"Goal Achieved",signif(log10(Conc_site*(1-Rem_median2/100)/Conc_goal),2))
      OoM_need2 = signif(log10(Conc_site*(1-Rem_median2/100)/Conc_goal),2)
      
      # after remediation, Percent way to reach criteria
      Percent_reach = ifelse(1-(1-10^(-OoM_need2))>1,"Goal Achieved",signif((1-(1-10^(-OoM_need)))*100,2))
      #browser()
      Results = c(as.character(ifelse(Rem_median=='Increasing','Increasing',signif(Rem_median,2))),
                  as.character(signif(OoM_median,2)),
                  as.character(Forcast),
                  as.character(OoM_need),
                  as.character(Percent_reach))
    }else{
      Results = c(as.character(ifelse(Rem_median=='Increasing','Increasing',signif(Rem_median,2))),
                  as.character(signif(OoM_median,2)))

    }
    
    
    return(Results) 
  }
  
  
  Median_list = Result_list(Rem_median,Rem_median2,OoM_median,Conc_goal,Conc_site)
  Low_list = Result_list(Rem_min,Rem_min2,OoM_min,Conc_goal,Conc_site)
  High_list = Result_list(Rem_max,Rem_max2,OoM_max,Conc_goal,Conc_site)
  
  
  
  Result_table = list('Median_list' = Median_list,
                      'Low_list' = Low_list,
                      'High_list' = High_list)
  return(Result_table)
}


# exported result_table contains
#median_list: first column %reduction, OoM, forcast% reduction, after rem OoM, after rem %
#Low_list: second column Low Range
#High_list : third column High range

