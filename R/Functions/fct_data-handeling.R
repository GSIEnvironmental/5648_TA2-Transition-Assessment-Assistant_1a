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
      browser()
    }else{
      cd <- d
      browser()
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
# d = concentration data (long version)http://127.0.0.1:3676/#tab-1968-3
# d_mw = monitoring well information

data_merge <- function(d, d_mw,conc_name="Concentration"){
  cd <- left_join(d, d_mw, by = c("WellID" = "Monitoring Wells")) %>%
    filter(!is.na(Date),
           !is.na(eval(parse(text=conc_name))),
           !is.na(WellID))
  return(cd)
}


# handling the well information
data_wellinfo<-function(temp_mw_info,USorSI=NULL,sourcewell=NULL,welllist=NULL){

  if("Distance from Source (ft)"%in%colnames(temp_mw_info)){
    temp_mw_info <- temp_mw_info%>%
      rename(`Distance from Source (m)` = "Distance from Source (ft)")%>%
      mutate(`Distance from Source (m)` = `Distance from Source (m)`*0.3078)
  }
  
   
  # if user is missing with lat/long, populate values
  for (j in 1:nrow(temp_mw_info)){
    if (is.na(temp_mw_info$Latitude[j])||is.na(temp_mw_info$Longitude[j])){
      clip_mw_info <- temp_mw_info[,c("Easting","Northing")][j,1:2]
      coordinates(clip_mw_info) <- ~ Easting  + Northing
      proj4string(clip_mw_info) <- CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j]))
      clip_mw_info <- spTransform(clip_mw_info, CRS("+init=epsg:4326"))
      temp_mw_info$Latitude[j] = clip_mw_info@coords[2]
      temp_mw_info$Longitude[j] = clip_mw_info@coords[1]
    }
    if (is.na(temp_mw_info$Easting[j])||is.na(temp_mw_info$Northing[j])){
      clip_mw_info <- temp_mw_info[,c("Longitude","Latitude")][j,1:2]
      coordinates(clip_mw_info) <- ~ Longitude  + Latitude
      proj4string(clip_mw_info) <- CRS("+init=epsg:4326")
      clip_mw_info <- spTransform(clip_mw_info, CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j])))
      temp_mw_info$Northing[j] = clip_mw_info@coords[2]
      temp_mw_info$Easting[j] = clip_mw_info@coords[1]
    }
    
  }
  # calculate the distance
  if (!is.null(sourcewell)){
    temp_mw_info <- temp_mw_info%>%
      mutate(`Well Grouping` = ifelse(`Well Grouping`=='Source Well','',`Well Grouping`)
      )
    temp_mw_info <- temp_mw_info%>%
      mutate(`Well Grouping` = ifelse(`Monitoring Wells`==sourcewell,'Source Well',`Well Grouping`))
  }
  source_coord = temp_mw_info%>%filter(`Well Grouping`=='Source Well')
  
  if (is.null(welllist)){
    temp_mw_info <- temp_mw_info%>%
      mutate(`Distance from Source (m)` = sqrt((Easting-source_coord$Easting)^(2)+(Northing-source_coord$Northing)^(2)))
                                          #ifelse(`Monitoring Wells`%in%c(colnames(temp_data_tool5)[6:ncol(temp_data_tool5)],"Point of Compliance"),
                                          #       sqrt((Easting-source_coord$Easting)^(2)+
                                          #              (Northing-source_coord$Northing)^(2)),NA))
  }else{
    temp_mw_info <- temp_mw_info%>%
      mutate(`Distance from Source (m)` =  sqrt((Easting-source_coord$Easting)^(2)+(Northing-source_coord$Northing)^(2)))
                                            #ifelse(`Monitoring Wells`%in%c(welllist,"Point of Compliance"),
                                            #     sqrt((Easting-source_coord$Easting)^(2)+
                                            #            (Northing-source_coord$Northing)^(2)),NA))
  }

  # convert from ft to meter
  for (k in 1:nrow(temp_mw_info)){
    projtext = CRS(paste0("+init=epsg:",temp_mw_info$EPSG[k]))
    temp_mw_info$`Distance from Source (m)`[k] = ifelse(str_contains(projtext@projargs,"+units=m"),
                                                        temp_mw_info$`Distance from Source (m)`[k],
                                                        temp_mw_info$`Distance from Source (m)`[k]*0.3078)
  }
  
  if (!is.null(sourcewell)){
    if (USorSI=='US Unit'){
      temp_mw_info<-temp_mw_info%>%
        rename(`Distance from Source (ft)` = "Distance from Source (m)")%>%
        mutate(`Distance from Source (ft)` = `Distance from Source (ft)`/0.3078)
    }
  }
  temp_mw_info = temp_mw_info%>%mutate(`Well Grouping`=ifelse(`Well Grouping`=='','Plume Boundary',`Well Grouping`))
  
  return(temp_mw_info)
}

update_distance <- function(temp_mw_info,temp_data_tool5){
  # populate lat/long if data is missing

  for (j in 1:nrow(temp_mw_info)){
    if(is.na(temp_mw_info$Latitude[j])&is.na(temp_mw_info$Northing[j])||
       is.na(temp_mw_info$Longitude[j])&is.na(temp_mw_info$Easting[j])){
      temp_mw_info = temp_mw_info
    }else{
      if (is.na(temp_mw_info$Latitude[j])||is.na(temp_mw_info$Longitude[j])){
        clip_mw_info <- temp_mw_info[,c("Easting","Northing")][j,1:2]
        coordinates(clip_mw_info) <- ~ Easting  + Northing
        proj4string(clip_mw_info) <- CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j]))
        clip_mw_info <- spTransform(clip_mw_info, CRS("+init=epsg:4326"))
        temp_mw_info$Latitude[j] = clip_mw_info@coords[2]
        temp_mw_info$Longitude[j] = clip_mw_info@coords[1]
      }
      if (is.na(temp_mw_info$Easting[j])||is.na(temp_mw_info$Northing[j])){
        clip_mw_info <- temp_mw_info[,c("Longitude","Latitude")][j,1:2]
        coordinates(clip_mw_info) <- ~ Longitude  + Latitude
        proj4string(clip_mw_info) <- CRS("+init=epsg:4326")
        clip_mw_info <- spTransform(clip_mw_info, CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j])))
        temp_mw_info$Northing[j] = clip_mw_info@coords[2]
        temp_mw_info$Easting[j] = clip_mw_info@coords[1]
      }
      source_coord = temp_mw_info%>%filter(`Well Grouping`=='Source Well')
      
      projcheck = proj4string(CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j])))
      
      temp_mw_info <- temp_mw_info %>% select(-contains("Distance"))
      
      ifelse(grepl('us-ft',projcheck),
             temp_mw_info <- temp_mw_info%>%
               mutate(`Distance from Source (ft)` =  sqrt((Easting-source_coord$Easting)^(2)+(Northing-source_coord$Northing)^(2))
                      #ifelse(`Monitoring Wells`%in%c(colnames(temp_data_tool5)[6:ncol(temp_data_tool5)],'Point of Compliance'),
                      #                                   sqrt((Easting-source_coord$Easting)^(2)+
                      #                                          (Northing-source_coord$Northing)^(2)),NA)
               ),
             temp_mw_info <- temp_mw_info%>%
               mutate(`Distance from Source (m)` =  sqrt((Easting-source_coord$Easting)^(2)+(Northing-source_coord$Northing)^(2))
                      #ifelse(`Monitoring Wells`%in%c(colnames(temp_data_tool5)[6:ncol(temp_data_tool5)],'Point of Compliance'),
                      #        sqrt((Easting-source_coord$Easting)^(2)+
                      #               (Northing-source_coord$Northing)^(2)),NA)
               ) 
      )
    }
    

    }
    
  return(temp_mw_info)
}