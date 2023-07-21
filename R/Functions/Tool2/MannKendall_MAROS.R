#################################################################
library(trend)
library(ggsci)

simp <- pal_simpsons("springfield")(12)
#%% ----- Function for calculating ManKendall Test

##------ INPUT
# d: input data frame from with Group, Date, and Value columns

MannKendall_MAROS<-function(d,p_tb){
  
  # function for ManKendall Test

  # Calculate MK for each well

  MKeach <- map_dfr(unique(d$Group), ~{
    x <- d %>% filter(Group == .x)%>%
      filter(!is.na(Value)) %>%
      arrange(Date)
 
    if(length(na.omit(x %>% pull(Value))) > 40){
      y <- mk.test(x %>% pull(Value))
      z <- sens.slope(x %>% pull(Value), conf.level = 0.95) # sen's slope calculation
      
      data.frame("Group" = .x,
                 "MK.p" = as.character(y$p.value),
                 "MK.S" = y$estimates[["S"]],
                 "MK.CV" = sd(x %>% pull(Value))/mean(x %>% pull(Value)),
                 "S.Slope" =  z$estimates[["Sen's slope"]],
                 "enough_data" = T)
      
    }else if (length(na.omit(x %>% pull(Value))) <= 40){
      y <- mk.test(x %>% pull(Value))
      z <- sens.slope(x %>% pull(Value), conf.level = 0.95) # sen's slope calculation
      get_tb<-p_tb%>%filter(...1==abs(y$estimates[["S"]]))
      ncount = nrow(x)
      data.frame("Group" = .x,
                 "MK.p" = get_tb[[as.character(ncount)]],
                 "MK.S" = y$estimates[["S"]],
                 "MK.CV" = sd(x %>% pull(Value))/mean(x %>% pull(Value)),
                 "S.Slope" =  z$estimates[["Sen's slope"]],
                 "enough_data" = T)
    }else{
      data.frame("Group" = .x,
                 "MK.p" = NA,
                 "MK.S" = NA,
                 "MK.CV" = NA,
                 "S.Slope" =  NA,
                 "enough_data" = F)
    }
  })

  # Assigning Trend to Results
  MKeach <- MKeach %>%
    mutate(MK.CF = ifelse(MK.p=='>99',0.999,(1-as.numeric(MK.p))),
           MK.p = ifelse(MK.p=='>99',0.001,as.numeric(MK.p)),
           Trend = case_when(enough_data == F ~ "Insufficent Data",
                             MK.CF > 0.95 & MK.S > 0 & S.Slope >= 0  ~ "Increasing",
                             MK.CF >= 0.90 & MK.CF <= 0.95 & MK.S > 0 & S.Slope >= 0 ~ "Probably Increasing",
                             MK.CF < 0.90 & MK.S > 0 & S.Slope >= 0 ~ "No Trend",
                             MK.CV >= 1 & MK.S <= 0 & MK.CF < 0.90 & S.Slope <= 0  ~ "No Trend",
                             MK.CV < 1 & MK.S <= 0 & MK.CF < 0.90 & S.Slope <= 0 ~ "Stable",
                             MK.CF >= 0.90 & MK.CF <= 0.95 & MK.S < 0 & S.Slope <= 0 ~ "Probably Decreasing",
                             MK.CF > 0.95 & MK.S < 0 & S.Slope <= 0 ~ "Decreasing"),
           Color = case_when(Trend == "Insufficent Data" ~ "black",
                             Trend == "No Trend" ~ simp[3],
                             Trend == "Increasing" | Trend == "Probably Increasing" ~ simp[8],
                             Trend == "Decreasing" | Trend == "Probably Decreasing" ~ simp[6],
                             Trend == "Stable" ~ simp[1]),
           MapFlag = case_when(Trend == "Insufficent Data" ~ "NA",
                               Trend == "No Trend" ~ "NT",
                               Trend == "Increasing" ~ "I",
                               Trend == "Probably Increasing" ~ "PI",
                               Trend == "Decreasing" ~ "D",
                               Trend == "Probably Decreasing" ~ "PD",
                               Trend == "Stable" ~ "S"))
  
  return(MKeach)
}
