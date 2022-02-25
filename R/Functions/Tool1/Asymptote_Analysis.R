library("mblm")
#################################################################

#%% ----- FUNCTION TO CALCULATE TREND LINES (SEN SLOPE)

#----- INPUT
# df_series: averaged/geomean data frame with columns 'Concentration' and 'Date'
# Notes: Need at least 2 samples to run (more are recommended)
sen_trend <- function(df_series){
  # Convert Date to numeric
  Date <- as.numeric(df_series$Date)
  Concentration <- log10(df_series$Concentration)
  
  # Median based Linear Model
  sen_lm <- mblm(Concentration ~ Date)

  return(sen_lm)
} # end sen_trend

#################################################################

#%% ----- SUBFUNCTIONS for ASYMPTOTIC ANALYSIS
#%% ----- NO NEED TO CALL IN


# -----sub-function calculate the forecast time to clean (based on 90% CI)
forecasted_clean <-function(fit, C_goal){
  # Slope/Intercept from model
  est <- data.frame(intercept = as.numeric(fit$coefficients[1]),
                    slope = as.numeric(fit$coefficients[2]),
                    type = "model")
  
  
  # Slope/Intercept from 90% Confidence Interval
  CI <- as.data.frame(t(confint.mblm(fit, 'Date', 0.9))) %>%
    rownames_to_column("type") %>%
    select(intercept = `(Intercept)`, slope = Date, type)
  
  est <- bind_rows(est, CI)
  
  # Calculate year concentration goal is met
  est <- est %>% 
    mutate(result = (log(C_goal) - est$intercept)/est$slope,
           year = year(as.Date(result, '1970-01-01')),
           rate = abs(slope)*365) %>%
    pivot_wider(names_from = type, values_from = c("intercept", "slope", "rate", "result", "year"))
  
  return(est)
}

############################################################################## 


#%% ----- FUNCTION FOR CALCULATING ASYMPTOTE RESULTS

#----- INPUT
# C_goal : concentration goal for the remediation, user needs to input
# df_series: averaged/geomean data frame from the previous function
# regression_fitness: output results from regression_fitness function


Asymptote_Analysis <- function(df_series, sen){
  
  cd <- data.frame(LOE = 1:5,
                   Met = NA)
  
  # ----- LINE OF EVIDENCE
  # populate the results of Asymptote Analysis
  # check whether statistically significant
  
  # p-values
  pvalue_fit1 <- summary.mblm(sen[["Period 1"]])$coefficients[2,4]
  pvalue_fit2 <- summary.mblm(sen[["Period 2"]])$coefficients[2,4]
  
  # Ratio of Rate1 to Rate2 Second Cell
  Ratio_fit1_fit2 <- sen[["Period 1"]]$coefficients[2]/sen[["Period 2"]]$coefficients[2]*100
  
  # 1. Are the slopes significantly different
  Asymptotic_1 <- "Unknown" # need to decide on test
  
  # 2. Is the slope of period 2 0? 
  CI <- as.data.frame(t(confint.mblm(sen[["Period 2"]], 'Date', 0.9)))
  Asymptotic_2 <- ifelse((CI["0.05", "Date"] <= 0 & 
                            CI["0.95", "Date"] >= 0 & 
                            pvalue_fit2 < 0.05), "YES", "NO")
  
  # 3. Is the rate of the first period you selected more than two times the second rate?
  Asymptotic_3 <- ifelse(Ratio_fit1_fit2 > 200, "YES", "NO")
  
  # 4. Is the Concentration Difference of the last points on the regression lines shown in the graph greater than 1 Order of Magnitude?
  df_summary <- df_series %>% group_by(period) %>%
    arrange(desc(Date)) %>%
    slice_head()
  
  df_2_tail <- df_summary %>% filter(period == "Period 2") %>% pull(Concentration)
  df_1_tail <- df_summary %>% filter(period == "Period 1") %>% pull(Concentration)
  
  Asymptotic_4 <- ifelse(abs(df_2_tail - df_1_tail) > 10, 'YES', 'NO')
  
  # 5. Is the Period 2 rate from less than 0.0693 per year (10 year half-life)?
  Asymptotic_5 <- ifelse(abs(sen[["Period 2"]]$coefficients[2]) * 365 < 0.0693 &
                           pvalue_fit2 <= 0.05, 'YES', 'NO')
  
  
  results = data.frame(Condition = 1:5,
                       Met = map_chr(paste0("Asymptotic_", 1:5), ~eval(parse(text = .x))))
  
  return(results)
  
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



