#################################################################

#%% ----- Function for calculating Sen's Slope Test

##------ INPUT
# one are required here 
# df_MW_compiled: input data frame from df_series_tool2a output

SENS_MAROS<-function(df_MW_compiled){
  #------all monitoring wells
  MWs <- unique(df_MW_compiled$WellID)
  
  # function for ManKendall Test
  
  # Calculate MK for each well
  SENSeach <- map_dfr(MWs, ~{
    x <- df_MW_compiled %>% filter(WellID %in% .x)%>%
      filter(!is.na(Concentration))
    y <- sens.slope(x$Concentration,conf.level = 0.95)
    y2 <- sens.slope(x$Concentration,conf.level = 0.90)
    data.frame("Well_ID" = .x,
               "S.p" = y$p.value,
               "S.Slope" = y$estimates[["Sen's slope"]],
               "S.CV" = sd(x$Concentration)/mean(x$Concentration))})
  
  # Assigning Trend to Results
  simp <- pal_simpsons("springfield")(12)
  SENSeach <- SENSeach %>%
    mutate(S.CF = (1-S.p),
           Trend = case_when(S.CF > 0.95 & S.Slope > 0 ~ "Increasing",
                             S.CF >= 0.90 & S.CF <= 0.95 & S.Slope > 0 ~ "Probably Increasing",
                             S.CF < 0.90 & S.Slope > 0 ~ "No Trend",
                             S.CV >= 1 & S.Slope <= 0 & S.CF < 0.90 ~ "No Trend",
                             S.CV < 1 & S.Slope <= 0 & S.CF < 0.90 ~ "Stable",
                             S.CF >= 0.90 & S.CF <= 0.95 & S.Slope < 0 ~ "Probably Decreasing",
                             S.CF > 0.95 & S.Slope < 0 ~ "Decreasing"),
           Color = case_when(Trend == "No Trend" ~ simp[3],
                             Trend == "Increasing" | Trend == "Probably Increasing" ~ simp[8],
                             Trend == "Decreasing" | Trend == "Probably Decreasing" ~ simp[6],
                             Trend == "Stable" ~ simp[1]))
  
  return(SENSeach)
}
