ValidateRangeFunction<-function(error,results,input){
  validate(
    need((input$Year_Removed-input$Year_Started)>=10&(input$Year_Removed-input$Year_Started)<=100,
         "Time between Source Started year and Source Removed year outside model range (10-100 years)"),
    need(input$tortuosity_LK>=0.07&input$tortuosity_LK<=0.7,
         "Tortuosity outside model range (0.07-0.7)."),
    need((input$Retardation_HK>=1&input$Retardation_LK>=1)&(input$Retardation_HK<=10&input$Retardation_LK<=10),
         "Low K or/and High K retardation factor outside model range (1-10)."),
    # need(round(log10(input$Concentration/input$Target_Clean_Level),3)<=3|round(log10(input$Concentration/input$Target_Clean_Level),3)>=1,
    #      "OoM outside of range (1-3) model range. Cannot calculate time for cleanup"),
    need(input$ne>=0.15&input$ne<=0.45,
         "Effective porosity outside model range (0.15-0.45)."),
    need(input$n>=0.15&input$n<=0.45,
         "Low K porosity outside model range (0.15-0.45)."),
    need((input$X/(input$K*input$i/input$ne*60*60*24*365/100)>=0.4)&(input$X/(input$K*input$i/input$ne*60*60*24*365/100)<=11.9),
         paste("Travel time is ",toString(round(input$X/(input$K*input$i/input$ne*60*60*24*365/100)),2)," years which is outside model range (0.4-11.9 years).",sep='')),
    need(input$Percent_T>=10&input$Percent_T<=90,
         "Percentage of Transmissive Zone is outside model range (10-90%)."),
    need(input$HalfLife>=1&input$HalfLife<=1000,
         "Half-life outside model range (1-1,000 years)."),
    need(error != "Check Inputs", "Please Check Input Values."),
    need(nrow(results) >= 700, 
         "Too many realizations being outside of the Borden's Tool range \n or choose parameters at the boundary, cannot generate rectagular distribution."),
    need(input$N>=1&input$N<=4,
         "Number of Low-K Layers outside model range (1-4 layers)")
  )
  
  if (input$BGLG=="1"){
    validate(need(input$Thickness>=0.5&input$Thickness<=3,
                  "Aquifer thickness outside model range (0.5-3 meters)."))
  }
  if (input$BGLG!="1"){
    validate(need(input$Thickness>=0.5&input$Thickness<=3,
                  "Aquifer thickness outside model range (0.5-3 meters) for Layered Geometry."))
  }
}

ValidateRangeFunctionSilent<-function(error,results,input){
  validate(need(error != "Check Inputs", FALSE),
           need(nrow(results) >= 700, 
                FALSE),
           need((input$Year_Removed-input$Year_Started)>=10&(input$Year_Removed-input$Year_Started)<=100,
                FALSE),
           need(input$tortuosity_LK>=0.07&input$tortuosity_LK<=0.7,
                FALSE),
           need((input$Retardation_HK>=1&input$Retardation_LK>=1)&(input$Retardation_HK<=10&input$Retardation_LK<=10),
                FALSE),
           # need(round(log10(input$Concentration/input$Target_Clean_Level),3)<=3|round(log10(input$Concentration/input$Target_Clean_Level),3)>=1,
           #      "OoM outside of range (1-3) model range. Cannot calculate time for cleanup"),
           need(input$n>=0.15&input$n<=0.45,
                FALSE),
           need(input$X/(input$K*input$i/input$ne*60*60*24*365/100)>=0.40&input$X/(input$K*input$i/input$ne*60*60*24*365/100)<=11.94,
                FALSE),
           need(input$Percent_T>=10&input$Percent_T<=90,
                FALSE),
           need(input$HalfLife>=1&input$HalfLife<=1000,
                FALSE),
           need(input$N>=1&input$N<=4,
                FALSE)
  )
  if (input$BGLG=="1"){
    validate(need(input$Thickness>=0.5&input$Thickness<=3,
                  FALSE))
  }
  if (input$BGLG!="1"){
    validate(need(input$Thickness>=0.5&input$Thickness<=3,
                  FALSE))
  }
}
