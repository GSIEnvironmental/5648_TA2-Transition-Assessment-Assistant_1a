BG_BordenFunction<-function(df){
  #---- Step6: Calculation in the Background
  
  for (var in 1:length(names(df))){
    nam<-names(df)[var]
    assign(nam, unname(unlist(df[var])))
  }
  
  # print (df)
  X_m = X #meter
  Kave = K/100*60*60*24      # convert from cm/s to m/day when reading from MC_LHC_Sampling function
  
  K_m = Kave*365 #convert from m/day to m/yr
  D_new = D*tortuosity_LK*(365*24*60*60)/10000 #convert to cm2/s to m2/yr
  TL = Year_Removed - Year_Started #loading period # for BG, TL=TD (diffusion time yr)
  Tt = X_m/Seep_V # High K travel time (yr)
  
  LD = (4.73*(TL-0.75*Retardation_HK*Tt)*D_new/Retardation_LK)^0.5 # diffusion length (m)
  TM = Tt*Retardation_HK+(X_m*n*LD*Retardation_LK)/(K_m*B*i) # mass retention time (yr)
  # This function has been reduced from the form in Borden and Cha (2021)
  # to allow for seepage velocity to be included as its own variable.
  gamma =(Retardation_LK*n*LD)/(Retardation_HK*ne*B)
  
  TimeCleanupCalculation(df,Parameters,'BG',TM,gamma,TL,HalfLife)
  
}


LG_BordenFunction<-function(df){
  
  for (var in 1:length(names(df))){
    nam<-names(df)[var]
    assign(nam, unname(unlist(df[var])))
  }
  
  #---- Step6: Calculation in the Background
  X_m = X # meter
  Kave = Percent_T/100*K/100*60*60*24 # convert K from cm/day to m/day
  K_m = Kave*365 #convert from m/day to m/yr
  D_new = D*tortuosity_LK*(365*24*60*60)/10000 #convert to cm2/s to m2/yr
  
  TL = Year_Removed - Year_Started #loading period 
  Tt = X_m/Seep_V # High K travel time (yr)
  TM =Tt*Retardation_HK+X_m*Retardation_LK*n*(1-Percent_T/100)/(K_m*Percent_T/100*i) # mass retention time (yr)
  # This function has been reduced from the form in Borden and Cha (2021)
  # to allow for seepage velocity to be included as its own variable.
  
  LD = B*(1-Percent_T/100)/(2*N)
  TD = (Retardation_LK*LD^2)/(4*D_new) # diffusion time
  
  TimeCleanupCalculation(df,Parameters,'LG',TM,TD,TD,HalfLife)
  
}


TimeCleanupCalculation<-function(df,Parameters,BGorLG,TM,Beta,TD,HalfLife){
  

  
  for (var in 1:length(names(df))){
    nam<-names(df)[var]
    assign(nam, unname(unlist(df[var])))
  }
  #coefficient filter by either BG or LG
  coeff <-Parameters%>%filter(Style==BGorLG)
  lnT1 = exp(coeff$lnT1[1]+coeff$lnT1[2]*log(TM)+coeff$lnT1[3]*log(Beta))
  lnT2 = exp(coeff$lnT2[1]+coeff$lnT2[2]*log(TM)+coeff$lnT2[3]*log(Beta))
  lnT3 = exp(coeff$lnT3[1]+coeff$lnT3[2]*log(TM)+coeff$lnT3[3]*log(Beta))
  
  #---- Step7: Results Calculation
  T1 = lnT1
  T2 = lnT2
  T3 = lnT3
  
  # half life implementation
  if (HalfLife>0){
    CTR1 =  exp(coeff$lnT1[4]+coeff$lnT1[5]*log(0.693/HalfLife*TD))
    CTR2 =  exp(coeff$lnT2[4]+coeff$lnT2[5]*log(0.693/HalfLife*TD))
    CTR3 =  exp(coeff$lnT3[4]+coeff$lnT3[5]*log(0.693/HalfLife*TD))
    T1 = T1*CTR1
    T2 = T2*CTR2
    T3 = T3*CTR3
  }
  
  # calculate results
  OoM = round(log10(Concentration/Target_Clean_Level),3)
#  if (OoM>=1&OoM<=3){
    A = log(T1)
    B = log(T2)
    C = log(T3)
    X1 = c(1,2,3)
    X2 = c(1,4,9)
    
    Y = data.frame(A,B,C)
    Time_Cleanup = c()
    for (k in c(1:nrow(Y))){
      Y_1 <- as.list(as.data.frame(t(Y[k,])))[[1]]
      coef = summary(lm(Y_1~X1+X2))
      C1 = coef$coefficients[1]
      C2 = coef$coefficients[2]
      C3 = coef$coefficients[3]
      Time_Cleanup_1 = exp(C1 + C2*OoM + C3*OoM^2)
      Time_Cleanup = append(Time_Cleanup,Time_Cleanup_1)
   }
 # }else{
 #   Time_Cleanup=NA
 # }
 #  
  results_list1 = data.frame(OM1,OM2,OM3,T1,T2,T3,Target_Clean_Level,Time_Cleanup)
  #print ('results_list1')
  #print (results_list1)
  
  return(results_list1)
}