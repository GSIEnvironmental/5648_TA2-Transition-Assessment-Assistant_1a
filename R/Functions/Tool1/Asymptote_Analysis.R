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
  sen_lm <- mblm(Concentration ~ Date,repeated = FALSE)

  return(sen_lm)
} # end sen_trend

#----- INPUT
# df_series: averaged/geomean data frame with columns 'Concentration' and 'Date'
# Notes: Need at least 2 samples to run (more are recommended)
sen_trend_distance <- function(df_series){
  # Convert Date to numeric
  Distance <- df_series$Distance
  Concentration <- log10(df_series$Concentration)
  
  # Median based Linear Model
  sen_lm <- mblm(Concentration ~ Distance)
  
  return(sen_lm)
} # end sen_trend_distance

#################################################################

#%% ----- SUBFUNCTIONS for ASYMPTOTIC ANALYSIS
#%% ----- NO NEED TO CALL IN


# -----sub-function calculate the forecast time to clean (based on 95% CI)
forecasted_clean <-function(fit, C_goal,CI){
  # Slope/Intercept from model
  cor_result = cor.test(fit$model$Concentration,fit$fitted.values)
  est <- data.frame(intercept = as.numeric(fit$coefficients[1]),
                    slope = as.numeric(fit$coefficients[2]),
                    type = "model")
  
  Y_end <- fit$fitted.values[length(fit$fitted.values)]
  X_end <- fit$model$Date[length(fit$model$Date)]
  
  # Slope/Intercept from 95% Confidence Interval
  
  conf.level = CI#0.95
  
  # calculate the confidence interval of slope
  x <- fit$model$Date
  y <- fit$model$Concentration
  y.ok <- is.finite(y)
  ok <- is.finite(x) & is.finite(y)
  x <- x[y.ok]
  y <- y[y.ok]
  x <- x[ok]
  y <- y[ok]
  KTT <- kendallTrendTest(y ~ x,conf.level = conf.level)
  
  limits.slope = KTT$interval$limits
  limits.intercept = Y_end-limits.slope*X_end
  # #calculate the confidence interval of intercept
  # index <- 2:length(x)
  # 
  # slopes <- unlist(lapply(index, function(i, x, y) 
  #   (y[i] - y[1:(i - 1)])/(x[i] - x[1:(i - 1)]), x, y))
  # slopes <- sort(slopes[is.finite(slopes)])
  # intercepts <- y - slopes * x
  # intercepts <- sort(intercepts[is.finite(intercepts)])
  # 
  # 
  # alpha <- 1 - conf.level
  # Z <- qnorm(1 - alpha/2)
  # C.alpha <- Z * sqrt(KTT$var.S)
  # N.prime = length(intercepts)
  # limits.intercept <-approx(1:N.prime, 
  #        intercepts, xout = c((N.prime - C.alpha)/2, (N.prime + C.alpha)/2 + 1))$y

  # combine data
  type = c(as.character(1-conf.level),as.character(conf.level))
  CI <- data.frame(intercept = limits.intercept,slope = limits.slope,type = type)#c('0.1','0.9'))

  # CI <- as.data.frame(t(confint.mblm(fit, 'Date', 0.90))) %>%
  #   rownames_to_column("type") %>%
  #   select(intercept = `(Intercept)`, slope = Date, type)

  est <- bind_rows(est, CI)
  
  
  # Calculate year concentration goal is met

  est$intercept = fit$fitted.values[1]-fit$model$Date[1]*est$slope
  est <- est %>% 
    mutate(result = (log10(C_goal) - est$intercept)/est$slope,
           year = year(as.Date(result, '1970-01-01')),
           rate = abs(slope)*365,
           pearson = as.numeric(cor_result$estimate),
           pvalue = as.numeric(cor_result$p.value),
           type = c('model','LCL','UCL')) %>%
    pivot_wider(names_from = type, values_from = c("intercept", "slope", "rate", "result", "year","pearson","pvalue"))
  
  return(est)
}

############################################################################## 


#%% ----- FUNCTION FOR CALCULATING ASYMPTOTE RESULTS

#----- INPUT
# C_goal : concentration goal for the remediation, user needs to input
# df_series: averaged/geomean data frame from the previous function
# regression_fitness: output results from regression_fitness function


Asymptote_Analysis <- function(df_series, sen,CI){
  
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
  sens_list_1 <-sens.slope(c(df_series%>%filter(period=='Period 1')%>%select(Concentration))$Concentration,
                           conf.level = CI)
  sens_list_2 <-sens.slope(c(df_series%>%filter(period=='Period 2')%>%select(Concentration))$Concentration,
                           conf.level = CI)
  
  
  Asymptotic_1 <- ifelse(sens_list_2$conf.int[1]>sens_list_2$conf.int[1]&
                           sens_list_2$conf.int[1]<sens_list_2$conf.int[2],'NO',
                         ifelse(sens_list_2$conf.int[2]>sens_list_2$conf.int[1]&
                           sens_list_2$conf.int[2]<sens_list_2$conf.int[2],'NO','YES')
                         ) # need to decide on test
  
  # 2. Is the slope of period 2 0? 
  CI <- as.data.frame(t(confint.mblm(sen[["Period 2"]], 'Date', level=0.9)))

  Asymptotic_2 <- ifelse((CI["0.1", "Date"] <= 0 & 
                            CI["0.9", "Date"] >= 0 & 
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



