#################################################################

#%% ----- SUBFUNCTIONS for ASYMPTOTIC ANALYSIS
#%% ----- NO NEED TO CALL IN


# ----- sub-function to calculate period required
period_calculator <- function(fit){
  timeperYear = ifelse(as.numeric(fit$coefficients[2])*365<0, 
                       -as.numeric(fit$coefficients[2])*365,
                       as.numeric(fit$coefficients[2])*365)
}


# -----sub-function calculate the forecast time to clean
forecasted_clean <-function(C_goal,fit,condition){
  if (condition=='most likely'){
    intercept = fit$coefficients[1]
    coeff = fit$coefficients[2]
  }else if (condition=='lower bound'){
    intercept = fit$coefficients[1] - summary(fit)$coefficients[1,2]
    coeff = fit$coefficients[2] - summary(fit)$coefficients[2,2]
  }else{
    intercept = fit$coefficients[1] + summary(fit)$coefficients[1,2]
    coeff = fit$coefficients[2] + summary(fit)$coefficients[2,2]
  }
  result = (log(C_goal) - as.numeric(intercept))/as.numeric(coeff)
  ML = as.Date(result, '1970-01-01')
  return (ML)
}


##----- sub-function to generate table to list the results

#-----INPUT
tabulated_forecast <- function(C_goal,fit){
  ML = forecasted_clean(C_goal,fit,'most likely')
  ML1 = forecasted_clean(C_goal,fit,'lower bound')
  ML2 = forecasted_clean(C_goal,fit,'upper bound')
  AtteRate <- period_calculator(fit)
  Result_Entire = c(AtteRate,ML,ML1,ML2)
  return(Result_Entire)
}



############################################################################## 


#%% ----- FUNCTION FOR CALCULATING ASYMPTOTE RESULTS

#----- INPUT
# C_goal : concentration goal for the remediation, user needs to input
# df_series: averaged/geomean data frame from the previous function
# regression_fitness: output results from regression_fitness function


Asymptote_Analysis <- function(C_goal,df_series,regression_fitness){
  
  # reassign the name of each data frame for all period, first period, and second period
  for (var in 1:length(names(df_series))){
    nam<-names(df_series)[var]
    assign(nam, (df_series[[var]]))
  }
  
  # reassign the name of each fitted regression line for all period, first period, and second period
  for (var in 1:length(names(regression_fitness))){
    nam<-names(regression_fitness)[var]
    assign(nam, (regression_fitness[[var]]))
    
  }
  
  # ------ OVERALL RESULTS
  # populate the results of first 12 cells
  # it export the results in order of 
  # first order source attenuation rates
  # most likely year
  # lower bound
  
  Entire_Time <- tabulated_forecast(C_goal,fit) # the first four line
  Period1 <- tabulated_forecast(C_goal,fit1) # the second four line
  Period2 <- tabulated_forecast(C_goal,fit2) # the third four line
  
  # ----- LINE OF EVIDENCE
  # populate the results of Asymptote Analysis
  # check whether statistically significant
  
  # p-value First Cell
  pvalue_fit2 <- as.numeric(format(summary(fit2)$coefficients[2,4],digits = 3))
  
  # Ratio of Rate1 to Rate2 Second Cell
  Ratio_fit1_fit2 <- round(summary(fit1)$coefficients[2]/summary(fit2)$coefficients[2]*100,0)
  
  # Confidence Interval of Slope of fit2
  CI_fit2 <-c(confint(fit2)[2,1],confint(fit2)[2,2])
  
  # First Question of Aymptotic?
  Asymptotic_1 <- ifelse(round(as.numeric(summary(fit2)$coefficients[2,4]),3)<0.05&Ratio_fit1_fit2>100&
                           sign(confint(fit2)[2,1])==sign(confint(fit2)[2,2]),
                         'YES',
                         'NO')
  # Second Question of Aymptotic?
  Asymptotic_2 <- ifelse(Ratio_fit1_fit2>200,
                         'YES',
                         'NO')
  
  # Third Question of Aymptotic?
  df_1_tail <- tail(df_1$Concentration[!is.na(df_1$Concentration)],1)
  df_2_tail <- tail(df_2$Concentration[!is.na(df_2$Concentration)],1)
  Asymptotic_3 <- ifelse((df_1_tail - df_2_tail)>10,
                         'YES',
                         'NO')
  # Fourth Question of Aymptotic?
  Asymptotic_4 <- ifelse(Period2[1]<0.0693,
                         'YES',
                         'NO')
  list_Asymptotic <-c(Asymptotic_1,Asymptotic_2,Asymptotic_3,Asymptotic_4)
  
  #The last statement of Asymptotic Call
  Asymptotic_result <- ifelse(  sum(
    as.numeric(
      unlist(
        list_Asymptotic%>%str_replace_all(c("YES" = "1", "NO" = "0"))
      )
    )
  )>=3,"YES","NO"
  )
  
  Results = list('Entire_Time' = Entire_Time,
                 'Period1' = Period1,
                 'Period2' = Period2,
                 'pvalue_fit2' = pvalue_fit2,
                 'CI_fit2' = CI_fit2,
                 'Ratio_fit1_fit2' = Ratio_fit1_fit2,
                 'list_Asymptotic' = list_Asymptotic,
                 'Asymptotic_result' = Asymptotic_result)
  
  return(Results)
  
}

#----- OUTPUT
# Entire_Time: Entire Record of OoM1, Most likely year, lower bound, and upper bound
# Period1: Period1 of OoM1, Most likely year, lower bound, and upper bound
# Period2: Period2 of OoM1, Most likely year, lower bound, and upper bound
# pvalue_fit2: asymptote analysis: pvalue
# CI_fit2: Confidence interval of slope at fit2 line
# Ratio_fit1_fit2: asymptote analysis:ratio of rate 1 and rate 2
# list_Asymptotic: line of evidence of asymptotic1, 2, 3, and 4 results, respectively
# Asymptotic_result: final result of asymptotic results, YES or NO