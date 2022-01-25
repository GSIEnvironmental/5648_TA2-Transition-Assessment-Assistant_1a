# Variable Definition
# X_m: Distance (meters) from source to monitoring well (user input)
# HK: Hydraulic Conductivity (cm/s) of Transmissive Zone (user input, optional)
# B: Aquifer Thickness (meters) (user input)
# i: Hydraulic Gradient (-) (user input)
# tortuosity_LK: Tortuosity of Low-k Zone (-) (user input, optional)
# D: Diffusion Coefficient of COC at 20°C (cm²/s) (user input, optional)
# Year_Removed: Year (YYYY) Source Removed (user input)
# Year_Started: Year (YYYY) Source Started (user input)
# ne: Effective Porosity of Transmissive Zone (-) (user input, optional)
# n: Total Porosity of Low-K Zone (-) (user input, optional)
# Retardation_LK: Retardation Factor of Low-K Zone (-) (user input, optional)
# Retardation_HK: Retardation Factor of Transmissive Zone (-) (user input, optional)
# Concentration
# Target_Clean_Level

# Borden_Tool <- function(X_m, HK, B, i, tortuosity_LK, D, Year_Removed, Year_Started, ne, n,
#                         Retardation_LK, Retardation_HK){
#   ## Unit Conversions -----------------
#   Kave = HK/100*60*60*24 # convert from cm/s to m/day 
#   K_m = Kave*365 # convert from m/day to m/yr
#   
#   ## Calculation in the Background -------------------
#   Q = Kave*i*B*365 #convert to m2/day to m2/yr
#   
#   D_new = D*tortuosity_LK*(365*24*60*60)/10000 # convert to cm2/s to m2
#   
#   TL = Year_Removed -Year_Started
#   
#   
#   Tt = (X_m*ne)/(K_m*i)
#   TH = X_m*(ne*B+n*(4.52*TL*D_new/Retardation_LK)^0.5)/(B*K_m*i)
#   TM =X_m*(Retardation_HK*ne*B+n*(4.52*TL*D_new*Retardation_LK)^0.5)/(B*K_m*i)
#   PVH = X_m*ne*B
#   PVL =X_m*n*(4.52*TL*D_new/Retardation_LK)^0.5
#   
#   Alpha =((4.52*TL*D_new/Retardation_LK)^0.5)/(B)
#   Beta = (n*(4.52*TL*D_new/Retardation_LK)^0.5)/(ne*B)
#   ceta =(n*(4.52*TL*D_new*Retardation_LK)^0.5)/(Retardation_HK*ne*B)
#   
#   #coefficient filter by either BG or LG
#   coeff <-Parameters%>%filter(Style=='BG')
#   lnT1 = exp(coeff$lnT1[1]+coeff$lnT1[2]*log(TM)+coeff$lnT1[3]*log(Beta))
#   lnT2 = exp(coeff$lnT2[1]+coeff$lnT2[2]*log(TM)+coeff$lnT2[3]*log(Beta))
#   lnT3 = exp(coeff$lnT3[1]+coeff$lnT3[2]*log(TM)+coeff$lnT3[3]*log(Beta))
#   
#   ## Results Calculation -------------------------------
#   T1 = lnT1 - (Year_Removed -Year_Removed)
#   T2 = lnT2 - (Year_Removed -Year_Removed)
#   T3 = lnT3 - (Year_Removed -Year_Removed)
#   
#   # half life implementation
#   if (HalfLife>0){
#     CTR1 =  exp(coeff$lnT1[4]+coeff$lnT1[5]*log(0.693/HalfLife*TL))
#     CTR2 =  exp(coeff$lnT2[4]+coeff$lnT2[5]*log(0.693/HalfLife*TL))
#     CTR3 =  exp(coeff$lnT3[4]+coeff$lnT3[5]*log(0.693/HalfLife*TL))
#     print (CTR1,CTR2,CTR3)
#     T1 = T1*CTR1
#     T2 = T2*CTR2
#     T3 = T3*CTR3
#   }
#   
#   OoM = round(log10(1-((1-Concentration/Target_Clean_Level)*100)/100),3)
#   if (OoM>=1&OoM<=3){
#     A = log(T1+(Year_Removed -Year_Removed))
#     B = log(T2+(Year_Removed -Year_Removed))
#     C = log(T3+(Year_Removed -Year_Removed))
#     X1 = c(1,2,3)
#     X2 = c(1,4,9)
#     Y = c(A,B,C)
#     coef = summary(lm(Y~X1+X2))
#     C1 = coef$coefficients[1]
#     C2 = coef$coefficients[2]
#     C3 = coef$coefficients[3]
#     Time_Cleanup = - (Year_Removed -Year_Removed) + exp(C1 + C2*OoM+ C3*OoM**2)
#   }else{
#     Time_Cleanup=NA
#   }
#   results_list1 = c(OM1,OM2,OM3,T1,T2,T3,Target_Clean_Level,Time_Cleanup)
#   
# }
# 
# if (type %in% c("LG",'BGLG')){
#   
#   # Layered Geometry
#   B =Thickness #9.84 #thickness of total layer
#   #Percent_T = Parcent_T #% Percent of B that is Transmissive
#   #N = input$N #N umber of Low-k Layers (N)
#   TG = HighKPorousMedia # transmissive geology
#   LG = LowKPorousMedia # low K geology
#   HalfLife = HalfLife()#input$HalfLife# years
#   
#   #---- Step 4: Input Values (Edit/Enter Values)
#   
#   # Hydrogeology Parameters  %%% need to check HK, ne, and n
#   HK = HK()#TZ_Soil_Type$`Hydraulic Conductivity [ft/d]`[TZ_Soil_Type$Soil_Type==TG] # Hydraulic Conductivity of Transmissive Zone 850.393700787401#0.0920044444444444/12/2.54*86400#
#   LK = LowK_Soil_Type$`Hydraulic Conductivity [cm/s]`[LowK_Soil_Type$Soil_Type==LG]/100*60*60*24 # Hydraulic Conductivity of Low-k Zone conver to meter per day
#   ne = ne()#TZ_Soil_Type$`Effective Porosity [-]`[TZ_Soil_Type$Soil_Type==TG] # Effective Porosity of Transmissive Zone 0.225#
#   n = n()#LowK_Soil_Type$`Porosity [-]`[LowK_Soil_Type$Soil_Type==LG] # Total Porosity of Low-k Zone 0.4#
#   
#   # Diffusion parameter  %%% need to check D and tortuosity
#   D = D()#Constituents$`Diffusion Coefficient[cm2/sec]`[Constituents$`Constituents Name`==chem]*100*100*1000/365/24/60/60# 0.00000285#Diffusion Coefficient cm2/s
#   tortuosity_LK = 0.77*(LK/86400)**0.04#Tortuosity of Low-k zone 1
#   
#   # Retardation Parameters
#   FOC_HK = input$foc_HK #0 # Fraction Organic Carbon Transmissive Zone
#   FOC_LK = input$foc_LK #0 # Fraction Organic Carbon Low-k Zone
#   Bulk_Density_HK = input$Rho_HK #1.7 # Bulk Density of Transmissive Zone
#   Bulk_Density_LK = input$Rho_LK #1.7 # Bulk Density of Low-k Zone
#   # FOC_HK = 0 # Fraction Organic Carbon Transmissive Zone
#   # FOC_LK = 0 # Fraction Organic Carbon Low-k Zone
#   # Bulk_Density_HK = 1.7 # Bulk Density of Transmissive Zone
#   # Bulk_Density_LK = 1.7 # Bulk Density of Low-k Zone
#   #Retardation_HK =1.6 # Retardation Factor of Transmissive Zone
#   #Retardation_LK =3.9 # Retardation Factor of Low-k Zone
#   KOC = KOC()#Constituents$`Partition Coefficient of Constituent Koc [L/kg]`[Constituents$`Constituents Name`==chem] # partition coefficient of constituent
#   
#   
#   #---- Step 5: RESULTS.  See Timeframe to Reduce Plume Concentrations by 90%, 99%, and 99.9%.
#   
#   #Concentration = 1000 # Enter the Concentration of the COC at the Monitoring Well Now (ug/L)
#   #Target_Clean_Level = 5 # Target Clean-up Level
#   #Year_now = 2020
#   
#   OM1 = Concentration*0.1 # A 90% Reduction in Concentration (1 Order of Magnitude) to …
#   OM2 = Concentration*0.01 # A 99% Reduction in Concentration (2 Order of Magnitude) to …
#   OM3 = Concentration*0.001 # A 99.9% Reduction in Concentration (3 Order of Magnitude) to …
#   
#   
#   
#   #---- Step6: Calculation in the Background
#   X_m = X #convert from ft to meter
#   Kave = Percent_T/100*HK
#   Q = Kave*i*B*365 #convert to m2/day to ft2/yr
#   K_m = HK*365 #convert from m/day to m/yr
#   D_new = D*tortuosity_LK*(365*24*60*60)/10000 #convert to cm2/s to m2
#   
#   TL = Year_Removed -Year_Started
#   Tt = (X_m*ne)/(K_m*i)
#   TH = X_m*(ne*Percent_T/100+n*(1-Percent_T/100))/(K_m*Percent_T/100*i)
#   TM =X_m*(Retardation_HK*ne*Percent_T/100+Retardation_LK*n*(1-Percent_T/100))/(K_m*Percent_T/100*i)
#   PVH = X_m*ne*B*Percent_T/100
#   PVL =X_m*n*B*(1-Percent_T/100)
#   
#   Alpha =(1-Percent_T/100)/(Percent_T/100)
#   Beta =(1-Percent_T/100)*n/((Percent_T/100)*ne)
#   ceta =Retardation_LK*(1-Percent_T/100)*n/(Retardation_HK*Percent_T/100*ne)
#   
#   LD = B*(1-Percent_T/100)/N/2
#   TD = (Retardation_LK*LD**2)/(4*D_new)
#   
#   #coefficient filter by either BG or LG
#   coeff <-Parameters%>%filter(Style=='LG')
#   lnT1 = exp(coeff$lnT1[1]+coeff$lnT1[2]*log(TM)+coeff$lnT1[3]*log(TD))
#   lnT2 = exp(coeff$lnT2[1]+coeff$lnT2[2]*log(TM)+coeff$lnT2[3]*log(TD))
#   lnT3 = exp(coeff$lnT3[1]+coeff$lnT3[2]*log(TM)+coeff$lnT3[3]*log(TD))
#   #---- Step7: Results Calculation
#   T1 = lnT1 - (Year_Removed -Year_Removed)
#   T2 = lnT2 - (Year_Removed -Year_Removed)
#   T3 = lnT3 - (Year_Removed -Year_Removed)
#   
#   # half life implementation
#   if (HalfLife>0){
#     CTR1 =  exp(coeff$lnT1[4]+coeff$lnT1[5]*log(0.693/HalfLife*TD))
#     CTR2 =  exp(coeff$lnT2[4]+coeff$lnT2[5]*log(0.693/HalfLife*TD))
#     CTR3 =  exp(coeff$lnT3[4]+coeff$lnT3[5]*log(0.693/HalfLife*TD))
#     print (CTR1,CTR2,CTR3)
#     T1 = T1*CTR1
#     T2 = T2*CTR2
#     T3 = T3*CTR3
#   }
#   
#   OoM = round(log10(1-((1-Concentration/Target_Clean_Level)*100)/100),3)
#   if (OoM>=1&OoM<=3){
#     A = log(T1+(Year_Removed -Year_Removed))
#     B = log(T2+(Year_Removed -Year_Removed))
#     C = log(T3+(Year_Removed -Year_Removed))
#     X1 = c(1,2,3)
#     X2 = c(1,4,9)
#     Y = c(A,B,C)
#     coef = summary(lm(Y~X1+X2))
#     C1 = coef$coefficients[1]
#     C2 = coef$coefficients[2]
#     C3 = coef$coefficients[3]
#     Time_Cleanup = - (Year_Removed -Year_Removed) + exp(C1 + C2*OoM+ C3*OoM**2)
#   }else{
#     Time_Cleanup=NA
#   }
#   results_list2 = c(OM1,OM2,OM3,T1,T2,T3,Target_Clean_Level,Time_Cleanup)
# }
# 
# Persistent_Source_Index = ifelse(is.na(Time_Cleanup),"N/A",
#                                  ifelse(Time_Cleanup<=20,1,
#                                         ifelse(Time_Cleanup<=30,2,
#                                                ifelse(Time_Cleanup<=40,3,
#                                                       ifelse(Time_Cleanup<=50,4,
#                                                              ifelse(Time_Cleanup<=60,5,
#                                                                     ifelse(Time_Cleanup<=70,6,
#                                                                            ifelse(Time_Cleanup<=80,7,
#                                                                                   ifelse(Time_Cleanup<=90,8,
#                                                                                          ifelse(Time_Cleanup<=100,9,10))))))))))
# 
# if (type=='BG'){
#   results_list = results_list1
# }else if(type=='BGLG'){
#   results_list = pmax(results_list1,results_list2)
# }else{
#   results_list = results_list2
# }
# 
# results_list = append(results_list,Persistent_Source_Index)
# results_list
# }