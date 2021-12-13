#################################################################

#%% ----- Function for getting the data frame file to process

##------ INPUT
# three inputs are required here 
# df: input database of the daily concentration data of each well
# pickwelldown: a list of monitoring well name which is located downgradient. Needs to be in "string" list format
# ave_switch: either mean or geomean string input for averaging the time series concentration data

df_series_tool2a<-function(df,pickwelldown,ave_switch,C_goal){
  
  # average or geomean of the selected well and entire well lists
  df_MW<-df%>%
    pivot_longer(!Date,names_to='WellID',
                 values_to='Concentration')%>%
    mutate(Date = as.Date(Date))
  
  # pick only the wells that are downgradient list
  df_MW_downgradient<-df_MW%>%
    filter(WellID%in%pickwelldown)
  
  # pick only the wells that has the most recent measurement above the concentration goal
  
  abovegoal <- df_MW%>%
    filter(!is.na(Concentration))%>%
    group_by(WellID) %>%
    slice(which.max(as.Date(Date, '%Y%M%d')))%>%
    filter(Concentration>=C_goal)%>%
    select(WellID)
  
  df_above_goal <-df_MW%>%
    filter(WellID%in%abovegoal$WellID)
  
  if (ave_switch=='mean'){
    df_MW_downgradient <-df_MW_downgradient%>%group_by(Date)%>%
      summarise(Concentration = mean(Concentration,na.rm=TRUE))
    df_MW_all <-df_MW%>%group_by(Date)%>%
      summarise(Concentration = mean(Concentration,na.rm=TRUE))
    df_above_goal <-df_above_goal%>%group_by(Date)%>%
      summarise(Concentration = mean(Concentration,na.rm=TRUE))
  }else{ #geomean
    df_MW_downgradient <-df_MW_downgradient%>%group_by(Date)%>%
      summarise(exp(mean(log(Concentration),na.rm=TRUE)))
    df_MW_all <-df_MW%>%group_by(Date)%>%
      summarise(exp(mean(log(Concentration),na.rm=TRUE)))
    df_above_goal <-df_above_goal%>%group_by(Date)%>%
      summarise(exp(mean(log(Concentration),na.rm=TRUE)))
  }
  
  # create new name for averaged or geomean datasets
  # either all, downgradient, or abovegoal
  df_MW_all <- df_MW_all%>%
    mutate(WellID = 'all')%>%
    select(Date,WellID,Concentration)
  
  df_MW_downgradient <- df_MW_downgradient%>%
    mutate(WellID = 'downgradient')%>%
    select(Date,WellID,Concentration)
  
  df_above_goal <- df_above_goal%>%
    mutate(WellID = 'abovegoal')%>%
    select(Date,WellID,Concentration)
  
  # stack all the files by MW name, all, and downgradient
  df_MW_compiled<-rbind(df_MW, df_MW_all, df_MW_downgradient,df_above_goal)
  
  return(df_MW_compiled)
}


