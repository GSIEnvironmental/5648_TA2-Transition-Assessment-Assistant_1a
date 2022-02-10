# function for calling Monte Carlo
MC_function_LHC <-function(input){
  set.seed(1111)
  A <- randomLHS(1000,11) 
  
  X <-c(input$X,qtri(A[,1], input$X_LL,input$X_UL,input$X))#distance from source (m)
  i <-c(input$i,qtri(A[,10], input$i_LL,input$i_UL,input$i))#Hydraulic Gradient (-)
  
  chem = input$COC #constituents
  Year_Started = c(input$Year_Started,
                   qtri(A[,2],input$Year_Started_LL,input$Year_Started_UL,input$Year_Started)) 
  Year_Removed = input$Year_Removed 
  
  K = c(input$K,qtri(A[,3], input$K_LL,input$K_UL,input$K)) # cm/s perturb
  
  ne <-c(input$ne,qtri(A[,11], input$ne_LL,input$ne_UL,input$ne)) 
  n <-input$n #<-noperturb
  D <-input$D #<-noperturb
  
  
  tortuosity_LK<-c(input$tortuosity_LK,
                   qtri(A[,4], input$tortuosity_LK_LL,
                      input$tortuosity_LK_UL,
                      input$tortuosity_LK))
  
  Retardation_HK<-c(input$Retardation_HK,
                    qtri(A[,5], input$Retardation_HK_LL,
                       input$Retardation_HK_UL,
                       input$Retardation_HK))
  
  Retardation_LK<-c(input$Retardation_LK,
                    qtri(A[,6], input$Retardation_LK_LL,
                       input$Retardation_LK_UL,
                       input$Retardation_LK))
  
  Concentration = input$Concentration
  Target_Clean_Level = input$Target_Clean_Level
  
  
  BGLG = input$BGLG 
  
  B<-c(input$Thickness, qtri(A[,7], input$Thickness_LL,
          input$Thickness_UL,
          input$Thickness))

  
  if (input$HalfLifeYN==1){
    HalfLife=0
  }else{
    HalfLife <-c(input$HalfLife,
                 qtri(A[,9], input$HalfLife_LL,
                   input$HalfLife_UL,
                   input$HalfLife))           
  }
  TG = input$HighKPorousMedia #HighKPorousMedia  transmissive geology
  LG = input$LowKPorousMedia  #LowKPorousMedia low K geology
  
  #---- Step2: Pick Either Boundary Geometry or Layered Geometry
  if (input$BGLG>1){
    Percent_T <-c(input$Percent_T,
                  qtri(A[,8], input$Percent_T_LL,
                    input$Percent_T_UL,
                    input$Percent_T))
    N = input$N
  }else{
    Percent_T=0
    N = 0
  }
  type = ifelse(input$BGLG==1, 'BG',ifelse(input$BGLG==2,'LG','BGLG'))
  
  LK = LowK_Soil_Type$`Hydraulic Conductivity [cm/s]`[LowK_Soil_Type$Soil_Type==LG]/100*60*60*24 # Hydraulic Conductivity of Low-k Zone convert to meter per day
  
  
  # Retardation Parameters
  FOC_HK<-input$foc_HK
  FOC_LK<-input$foc_LK
  Bulk_Density_HK<-input$Rho_HK
  Bulk_Density_LK<-input$Rho_LK
  KOC<-Constituents$`Partition Coefficient of Constituent Koc [L/kg]`[Constituents$`Constituents Name`==input$COC]
  
  
  OM1 = Concentration*0.1 # A 90% Reduction in Concentration (1 Order of Magnitude)
  OM2 = Concentration*0.01 # A 99% Reduction in Concentration (2 Order of Magnitude)
  OM3 = Concentration*0.001 # A 99.9% Reduction in Concentration (3 Order of Magnitude)
  
  
  Seep_V<-K/100*60*60*24*365*i/ne # seepage velocity of high K zone (m/yr)
  
  Tt = X/Seep_V
  
  remain_index <-which(Tt>=0.4&Tt<=11.94)
  df<-list(X,i,chem, Year_Started,Year_Removed,K,ne,n,D,Seep_V,tortuosity_LK,
           Retardation_HK,Retardation_LK,Concentration,Target_Clean_Level,BGLG,B,
           HalfLife,TG,LG,Percent_T,N,type,LK,FOC_HK,FOC_LK,Bulk_Density_HK,Bulk_Density_LK,
           KOC, OM1, OM2, OM3,remain_index)
  
  names(df)<-c('X','i','chem','Year_Started','Year_Removed','K','ne','n','D','Seep_V','tortuosity_LK',
               'Retardation_HK','Retardation_LK','Concentration','Target_Clean_Level','BGLG','B',
               'HalfLife','TG','LG','Percent_T','N','type','LK','FOC_HK','FOC_LK','Bulk_Density_HK',
               'Bulk_Density_LK','KOC','OM1','OM2','OM3','remain_index') 
  

  return(df)
}
