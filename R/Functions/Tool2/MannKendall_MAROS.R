#################################################################
library(trend)
library(ggsci)
#%% ----- Function for calculating ManKendall Test

##------ INPUT
# d: input data frame from with Group, Date, and Concentration columns

MannKendall_MAROS<-function(d){
  
  # function for ManKendall Test
  
  # Calculate MK for each well
  MKeach <- map_dfr(unique(d$Group), ~{
    x <- d %>% filter(Group == .x)%>%
      filter(!is.na(Concentration)) %>%
      arrange(Date)
    
    y <- mk.test(x %>% pull(Concentration))
    z <- sens.slope(x %>% pull(Concentration), conf.level = 0.95) # sen's slope calculation
    
    data.frame("Group" = .x,
               "MK.p" = y$p.value,
               "MK.S" = y$estimates[["S"]],
               "MK.CV" = sd(x %>% pull(Concentration))/mean(x %>% pull(Concentration)),
               "S.Slope" =  z$estimates[["Sen's slope"]])
    })
  
  # Assigning Trend to Results
  simp <- pal_simpsons("springfield")(12)
  MKeach <- MKeach %>%
    mutate(MK.CF = (1-MK.p),
           Trend = case_when(MK.CF > 0.95 & MK.S > 0 & S.Slope > 0  ~ "Increasing",
                             MK.CF >= 0.90 & MK.CF <= 0.95 & MK.S > 0 & S.Slope > 0 ~ "Probably Increasing",
                             MK.CF < 0.90 & MK.S > 0 & S.Slope > 0 ~ "No Trend",
                             MK.CV >= 1 & MK.S <= 0 & MK.CF < 0.90 & S.Slope <= 0  ~ "No Trend",
                             MK.CV < 1 & MK.S <= 0 & MK.CF < 0.90 & S.Slope <= 0 ~ "Stable",
                             MK.CF >= 0.90 & MK.CF <= 0.95 & MK.S < 0 & S.Slope < 0 ~ "Probably Decreasing",
                             MK.CF > 0.95 & MK.S < 0 & S.Slope < 0 ~ "Decreasing"),
           Color = case_when(Trend == "No Trend" ~ simp[3],
                             Trend == "Increasing" | Trend == "Probably Increasing" ~ simp[8],
                             Trend == "Decreasing" | Trend == "Probably Decreasing" ~ simp[6],
                             Trend == "Stable" ~ simp[1]),
           MapFlag = case_when(Trend == "No Trend" ~ "NT",
                             Trend == "Increasing" ~ "I",
                             Trend == "Probably Increasing" ~ "PI",
                             Trend == "Decreasing" ~ "D",
                             Trend == "Probably Decreasing" ~ "PD",
                             Trend == "Stable" ~ "S"))
  
  return(MKeach)
}
