#INPUT
# df:dataframe dummy file which includes the thickness of non transmissive zone
# TOP: top of the aquifer
# bottom: bottom of the aquifer
# aquitard: choose option from four


heterofunction<-function(df,TOP,Bottom,aquitard){
  
  option = c('No Matrix Diffusion',
             'Matrix Diffusion in Underlying Low-K Units',
             'Matrix Diffusionin Overlying Low-K Units',
             'Matrix Diffusion in Under and Overlying Low-K Units')
  
  
  N_aquitard = case_when(aquitard==option[1] ~ 0,
                         aquitard==option[2] ~ 1,
                         aquitard==option[3] ~ 1,
                         aquitard==option[4] ~ 2)
  
  Impact_diffusion = case_when(aquitard==option[1] ~ 'Low',
                               aquitard==option[2] ~ 'High',
                               aquitard==option[3] ~ 'High',
                               aquitard==option[4] ~ 'Very high')
  
  
  
  Thickness = Bottom - TOP

  ave = mean(rowSums(df[,c(2:5)],na.rm=TRUE))
  
  
  Percent_B = (1-ave/Thickness)*100
  N_layer = round(mean(rowSums(df[,c(2:5)]!="",na.rm=TRUE)))
  rowSums(df != "")
  # clip at two section
  modelB<- read_rds('./R/Functions/Tool7/logfit_60to90transmissive.rds')
  modelC<- read_rds('./R/Functions/Tool7/logfit_40to50transmissive.rds')
  
  if (Percent_B>=60){
    B = data.frame(B = Percent_B, N = N_layer)
    ans = as.numeric(predict(modelB,newdata=B))
    Impact_diffusion2 = case_when(ans>=50 ~ 'High',
                                  ans<50&ans>=10 ~ 'Moderate',
                                  ans <10 ~ 'Low')
  }else if (Percent_B<60&Percent_B>30){
    C = data.frame(C = Percent_B, N = N_layer)
    ans = as.numeric(predict(modelC,newdata=C))
    Impact_diffusion2 = case_when(ans>=50 ~ 'High',
                                  ans<50&ans>=10 ~ 'Moderate',
                                  ans <10 ~ 'Low')
  }else{
    Impact_diffusion2 = 'High'
  }
  
  
  if ('High'%in%c(Impact_diffusion,Impact_diffusion2)){
    Overall = 'High'
  }else if ('Moderate'%in%c(Impact_diffusion,Impact_diffusion2)){
    Overall = 'Moderate'
  }else{
    Overall = 'Low'
  }
  
  
  results_list = list(N_aquitard,Percent_B,N_layer,
                            Impact_diffusion,Impact_diffusion2,Overall)
  
  names(results_list)<-c('N_aquitard','Percent_B','N_layer',
                         'Impact_diffusion','Impact_diffusion2','Overall')
  return(results_list)
}

# output 
#N_aquitard: # of aquitard
#Percent_B: percent transmissive thickness
#N_layer: number of layer
#Impact_diffusion: high/medium/low based on four option
#Impact_diffusion2: high/medium/low based on linear regression
#Overall: choose the highest of the impact diffusion and impact diffusion2




