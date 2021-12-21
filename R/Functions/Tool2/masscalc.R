# spatial interpolation function

# ---- input
#df_MW_cpmpiled: df_series_tool2a output
#Location: monitoring well location
#porosityHk and LK: porosity values of high K and low K zone
#thicknessHK and LK: thickness of aquifer in feet of high K and low K zone

sp_interpolation<-function(df_MW_compiled,Location,
                           porosityHK,porosityLK,
                           thicknessHK,thicknessLK){
  
  # transpose location information
  Location <-location%>%pivot_longer(cols = starts_with('MW-'))%>%
    pivot_wider(names_from = `Monitoring Well`, values_from = value)%>%
    filter(!is.na(Latitude))
  
  # attach location information to averaged/geomean data
  df_MW_compiled <- df_MW_compiled%>%
    left_join(Location,by=c('WellID'='name'))%>%
    arrange(Date)%>%
    filter(!WellID%in%c("all","downgradient","abovegoal"),
           !is.na(Concentration))
  
  # generate file to attach mass calculation
  overall_tbl <-df_MW_compiled%>%group_by(Date)%>%
    summarise(MW_count =n())
  HKmass = c()
  LKmass = c()
  
  
  # loop to calculate mass for each day
  for (i in unique(df_MW_compiled$Date)){
    
    # filter data with date
    df <-df_MW_compiled%>%filter(Date==as.Date(i,'1970-01-01'))
    
    # generate Dalaunay triangulation for each MW
    dsp <- SpatialPoints(df[,c("Longitude", "Latitude")], proj4string=CRS("+proj=longlat +datum=NAD83"))
    dsp <- SpatialPointsDataFrame(dsp, df)
    
    v <- voronoi(dsp)
    
    # calculate area
    df$area = st_area(st_as_sf(v,'SpatialPolygonsDataFrame'))  #unit is in meters
    
    # convert mass to be kg, separate calculation for high and low K
    df$massHK = df$area*(df$Concentration/0.001)*porosityHK*(thicknessHK *0.3048)*10^(-9)
    df$massLK = df$area*(df$Concentration/0.001)*porosityLK*(thicknessLK *0.3048)*10^(-9)
      # concentration is ug/L
      # porosity of transmissive zone (-)
      # thickness of transmissive zone (ft)
    
    # append for high K zone and low K zone
    HKmass<-append(HKmass,as.numeric(sum(df$massHK)))
    LKmass<-append(LKmass,as.numeric(sum(df$massLK)))
  }
  
  # tabulate database by date, MW counts, lowK mass, highKmass, and totalmass
  overall_tbl$lowK_mass_kg<-LKmass
  overall_tbl$highK_mass_kg<-HKmass
  overall_tbl$total_mass_kg<-overall_tbl$highK_mass_kg+overall_tbl$lowK_mass_kg
  
  return(overall_tbl)
  
  }

# output 
# data table only
# tabulates date, MW counts, lowK mass, highKmass, and totalmass in kg

