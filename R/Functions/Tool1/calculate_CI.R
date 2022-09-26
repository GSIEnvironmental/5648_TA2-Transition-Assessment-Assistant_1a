calculate_CI<-function(fit,CI){
  
  # calculate the confidence interval of slope
  x <- fit$model$Date
  y <- fit$model$Concentration
  y.ok <- is.finite(y)
  ok <- is.finite(x) & is.finite(y)
  x <- x[y.ok]
  y <- y[y.ok]
  x <- x[ok]
  y <- y[ok]
  KTT <- kendallTrendTest(y ~ x,conf.level = CI)
  limits.slope = KTT$interval$limits
  
  return(limits.slope)
}
