
#################################################################

#%% ----- FUNCTION TO CALCULATE THE REGRESSION MODEL

#----- INPUT
# df_series: averaged/geomean data frame from the previous function
regression_fitness <- function(df_series){
  
  # reassign the name of each data frame for all period, first period, and second period
  for (var in 1:length(names(df_series))){
    nam<-names(df_series)[var]
    assign(nam, (df_series[[var]]))
  }
  
  # ----- fitting entire time period
  fit<-lm(log10(Concentration) ~ Date, data = df_MW,na.action=na.omit)
  
  #generate linear regression line for the first period
  fit1 <- lm(log10(Concentration) ~ Date, data = df_1, na.action=na.omit)
  
  #generate linear regression line for the second period
  fit2 <- lm(log10(Concentration) ~ Date, data = df_2,na.action=na.omit)
  
  fit_list = list('fit' = fit,
                  'fit1' = fit1,
                  'fit2' = fit2)
  
  return(fit_list)
}

# ----- OUTPUT
# fit: regression model of entire time period
# fit1: regression model of first time period
# fit2: regression model of second time period