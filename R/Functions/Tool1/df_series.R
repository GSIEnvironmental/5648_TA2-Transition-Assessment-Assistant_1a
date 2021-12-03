#################################################################

#%% ----- Function for getting the data frame file to process

##------ INPUT
# four inputs are required here 
# df: input database of the daily concentration data of each well
# pickwell: a list of monitoring well name in "string" for the average/geomean
# date_slider1 and date_slider2: is the separation of two data sets to calculcate two linear regression
#                                user needs to define this after the figure is visualize so df_series
#                                needs to be recalculated everytime date_slider1 and date_slider2 are
#                                reassigned. Put dummy date_slider1 and date_slider2 if 


df_series<-function(df,ave_switch,pickwell,
                    date_slider1,date_slider2){
  
  # average or geomean of the selected well
  df_MW<-df%>%
    pivot_longer(!Date,names_to='WellID',
                 values_to='Concentration')%>%
    filter(WellID%in%pickwell)%>%
    mutate(Date = as.Date(Date))
  
  if (ave_switch=='mean'){
    df_MW <-df_MW%>%group_by(Date)%>%
      summarise(Concentration = mean(Concentration,na.rm=TRUE))
  }else{
    df_MW <-df_MW%>%group_by(Date)%>%
      summarise(exp(mean(log(Concentration))))
  }
  
  if (missing(date_slider1)){
    df_1 <- df_MW
  }else{
    df_1<-df_MW%>%filter(Date>=date_slider1)
  }
  
  
  if (missing(date_slider2)){
    df_2 <- df_MW
  }else{
    df_1<-df_MW%>%filter(Date<date_slider2)
    df_2<-df_MW%>%filter(Date>=date_slider2)
  }
  
  data_series = list('df_MW'=df_MW,'df_1'=df_1,'df_2'=df_2)
  print (data_series)
  return(data_series)
  
}

#------ OUTPUT 
# the output would be three dataframe
# df: all the selected monitoring wells averaging/geomean for the entire time period
# df_1: all the selected wells averaging/geomean for the time period between date_slider1 and date_slider2 (include date_slider 1 but not date_slide2)
# df_2: all the selected wells averaging/geomean for the time period after date_slider2 (including date_slider2 date)
