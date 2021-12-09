#################################################################

#%% ----- Function for getting the data frame file to process

##------ INPUT
# three inputs are required here 
# df: input database of the daily concentration data of each well
# pickwelldown: a list of monitoring well name which is located downgradient. Needs to be in "string" list format
# ave_switch: either mean or geomean string input for averaging the time series concentration data

df_series_tool2a<-function(df,pickwelldown,ave_switch){
  
  # average or geomean of the selected well and entire well lists
  df_MW<-df%>%
    pivot_longer(!Date,names_to='WellID',
                 values_to='Concentration')%>%
    mutate(Date = as.Date(Date))
  
  
  df_MW_downgradient<-df_MW%>%
    filter(WellID%in%pickwelldown)
  
  if (ave_switch=='mean'){
    df_MW_downgradient <-df_MW_downgradient%>%group_by(Date)%>%
      summarise(Concentration = mean(Concentration,na.rm=TRUE))
    df_MW_all <-df_MW%>%group_by(Date)%>%
      summarise(Concentration = mean(Concentration,na.rm=TRUE))
  }else{ #geomean
    df_MW_downgradient <-df_MW_downgradient%>%group_by(Date)%>%
      summarise(exp(mean(log(Concentration))))
    df_MW_all <-df_MW%>%group_by(Date)%>%
      summarise(exp(mean(log(Concentration))))
  }
  
  # separate the total table list and donwgradient datafile
  df_MW_all <- df_MW_all%>%
    mutate(WellID = 'all')%>%
    select(Date,WellID,Concentration)
  
  df_MW_downgradient <- df_MW_downgradient%>%
    mutate(WellID = 'downgradient')%>%
    select(Date,WellID,Concentration)
  
  # stack all the files by MW name, all, and downgradient
  df_MW_compiled<-rbind(df_MW, df_MW_all, df_MW_downgradient)
  
  return(df_MW_compiled)
}


