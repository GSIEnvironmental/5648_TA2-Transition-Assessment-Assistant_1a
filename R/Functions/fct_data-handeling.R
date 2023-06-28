# data_long: pivots concentration dataframe from wide into long form
# inputs
# d = data frame with columns,
#   Event
#   Date
#   Chemical Name
#   Units
#   All other columns are considered well-ids


data_long <- function(d,con_name = "Concentration"){
    if("Date (Month/Day/Year)"%in%colnames(d)){
      cd <- d %>% rename(Date = `Date (Month/Day/Year)`)
    }else{
      cd <- d
    }
    if ("State"%in%colnames(d)){
      cd <- cd %>%
        select(where(~!all(is.na(.x)))) %>% # removing columns with no data
        filter(!if_all(c(-"Event", -"Date", -"COC", -"Units",-"State"), ~is.na(.))) %>% #removing events with no concentration data
        pivot_longer(cols = c(-"Event", -"Date", -"COC", -"Units",-"State"),
                     names_to = "WellID", values_to = con_name) %>%
        filter(!is.na(eval(parse(text=con_name))))
    }else{
      cd <- cd %>%
        select(where(~!all(is.na(.x)))) %>% # removing columns with no data
        filter(!if_all(c(-"Event", -"Date", -"COC", -"Units"), ~is.na(.))) %>% #removing events with no concentration data
        pivot_longer(cols = c(-"Event", -"Date", -"COC", -"Units"),
                     names_to = "WellID", values_to = con_name) %>%
        filter(!is.na(eval(parse(text=con_name))))
    }

  
  return(cd)
} # end data_long

# data_mw_clean: cleans up MW Info table

data_mw_clean <- function(d){
  cd <- d %>%
    filter(!if_all(everything(), ~is.na(.)))
  
  return(cd)
} # end data_long


# data_merge: merge concentration and well information
# d = concentration data (long version)
# d_mw = monitoring well information

data_merge <- function(d, d_mw,conc_name="Concentration"){
  cd <- left_join(d, d_mw, by = c("WellID" = "Monitoring Wells")) %>%
    filter(!is.na(Date),
           !is.na(eval(parse(text=conc_name))),
           !is.na(WellID))
  
  return(cd)
}

