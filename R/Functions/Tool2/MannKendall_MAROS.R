#################################################################

#%% ----- Function for calculating ManKendall Test

##------ INPUT
# one are required here 
# df_MW_compiled: input data frame from df_series_tool2a output


MannKendall_MAROS<-function(df_MW_compiled){
  #------all monitoring wells
  MWs <- unique(df_MW_compiled$WellID)
  
  # function for ManKendall Test
  
  # Calculate MK for each well
  MKeach <- map_dfr(MWs, ~{
    x <- df_MW_compiled %>% filter(WellID %in% .x)%>%
      filter(!is.na(Concentration))
    y <- mk.test(x$Concentration)
    data.frame("Well_ID" = .x,
               "MK.p" = y$p.value,
               "MK.S" = y$estimates[["S"]],
               "MK.CV" = sd(x$Concentration)/mean(x$Concentration))})
  
  # Assigning Trend to Results
  simp <- pal_simpsons("springfield")(12)
  MKeach <- MKeach %>%
    mutate(MK.CF = (1-MK.p),
           Trend = case_when(MK.CF > 0.95 & MK.S > 0 ~ "Increasing",
                             MK.CF >= 0.90 & MK.CF <= 0.95 & MK.S > 0 ~ "Probably Increasing",
                             MK.CF < 0.90 & MK.S > 0 ~ "No Trend",
                             MK.CV >= 1 & MK.S <= 0 & MK.CF < 0.90 ~ "No Trend",
                             MK.CV < 1 & MK.S <= 0 & MK.CF < 0.90 ~ "Stable",
                             MK.CF >= 0.90 & MK.CF <= 0.95 & MK.S < 0 ~ "Probably Decreasing",
                             MK.CF > 0.95 & MK.S < 0 ~ "Decreasing"),
           Color = case_when(Trend == "No Trend" ~ simp[3],
                             Trend == "Increasing" | Trend == "Probably Increasing" ~ simp[8],
                             Trend == "Decreasing" | Trend == "Probably Decreasing" ~ simp[6],
                             Trend == "Stable" ~ simp[1]))
  
  return(MKeach)
}
