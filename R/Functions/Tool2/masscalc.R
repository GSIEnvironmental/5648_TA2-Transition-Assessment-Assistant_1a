# spatial interpolation function
library(sf)

# ---- input
#df_MW_cpmpiled: df_series_tool2a output
#Location: monitoring well location
#porosityHk and LK: porosity values of high K and low K zone
#thicknessHK and LK: thickness of aquifer in feet of high K and low K zone

sp_interpolation<-function(df_MW_compiled,
                           porosityHK = 0.2,
                           porosityLK = 0.1,
                           thicknessHK = 8,
                           thicknessLK = 2,unit){
  
  inter_list <- list()
  
  overall_tbl_full <- c()
  
  for(j in unique(df_MW_compiled$Group)){
    # generate file to attach mass calculation
    overall_tbl <- df_MW_compiled %>% filter(Group == j) %>% 
      group_by(Group, Date) %>%
      summarise(MW_count =n()) %>% ungroup()
    
    HKmass = c()
    LKmass = c() 
    
    # loop to calculate mass for each day
    for (i in as.character(unique(overall_tbl$Date))){
      # filter data with date
      df <- df_MW_compiled %>% filter(as.character(Date) == i)
      
      if(dim(df)[1] > 3){
      
      # generate Voronoi triangulation for each MW
      dsp <- SpatialPoints(df[,c("Longitude", "Latitude")], proj4string=CRS("+proj=longlat +datum=NAD83"))
      dsp <- SpatialPointsDataFrame(dsp, df)
      
      v <- voronoi(dsp)
      
      convert_unit = case_when(tolower(unit)=='g/l',10^-3,
                               tolower(unit)=='mg/l',10^-6,
                               tolower(unit)=='ug/l',10^-9,
                               tolower(unit)=='ng/l',10^-12
                            )
      
      v@data <- v@data %>% 
        # calculate area
        mutate(area = st_area(st_as_sf(v,'SpatialPolygonsDataFrame')), #unit is in meters
               # convert mass to be kg, separate calculation for high and low K
               massHK = as.numeric(area)*(Concentration/0.001)*porosityHK*(thicknessHK *0.3048)*convert_unit,
               massLK = as.numeric(area)*(Concentration/0.001)*porosityLK*(thicknessLK *0.3048)*convert_unit,
               total_mass = massLK + massHK)

      # concentration is ug/L
      # porosity of transmissive zone (-)
      # thickness of transmissive zone (ft)
      
      inter_list[[j]][[as.character(i)]][["df"]] <- v@data
      inter_list[[j]][[as.character(i)]][["shape"]] <- v
      
      # append for high K zone and low K zone
      HKmass<-append(HKmass,as.numeric(sum(v@data$massHK)))
      LKmass<-append(LKmass,as.numeric(sum(v@data$massLK)))
      }else{
        HKmass<-append(HKmass, NA)
        LKmass<-append(LKmass, NA)
      }
      
    }
    
    # tabulate database by date, MW counts, lowK mass, highKmass, and totalmass
    overall_tbl$lowK_mass_kg<-LKmass
    overall_tbl$highK_mass_kg<-HKmass
    overall_tbl$total_mass_kg<-overall_tbl$highK_mass_kg+overall_tbl$lowK_mass_kg
    
    overall_tbl_full <- bind_rows(overall_tbl_full, overall_tbl)

  }
  
  inter_list[["overall_tbl"]] <- overall_tbl_full

  return(inter_list)
  
  }

# output 
# data table only
# tabulates date, MW counts, lowK mass, highKmass, and totalmass in kg

