# GSI Environmental -------------
##
## Script name: 5648_Transition_Assessment_Assistant
##
## Purpose of script: Version 1.0 of the SERDP Transition Assessment Assistant
##
## Author: B. Strasert
##         H. Hort
##
## Date Created: 2021-07-09
##
## Job Name: SERDP Transition Assessments 
## Job Number: 5648
## 
## Notes:  

options(stringsAsFactors = FALSE)
#options(shiny.error=browser)
# Load Packages ----------------

require(tidyverse)
require(lubridate)
require(readxl)
require(leaflet)
require(leaflet.extras)
 require(scales)
 require(gridExtra)
require(gt)
 require(openxlsx)
 require(ggforce)
 library(gstat)
 library(sp)
 library(rgdal)
 library(raster)
library(shinycssloaders)
 library(dismo)
 library(leafem)
 library(deldir)
 library(rgeos)
 library(RColorBrewer)
 require(plotly)
 library(rsconnect)
 
library(reticulate)

library(rhandsontable)
library(shinyscreenshot)
library(glue)
library(EnvStats)
library(lhs)
library(Rcpp)
library(psych)

library(ggplot2)
library(ggrepel)
library(scales)
library(changepoint)
library(htmlwidgets)
library(webshot2)
library(DT)
library(shiny)
library(shinydashboard)
library(htmltools)


# Plot Parameters -------------
# Colors
# The palette with grey:
col <- c(dark_blue = "#053356", green = "#11691d", light_purple = "#b990db", blue = "#053356", purple = "#330349")

# GGPLOT Theme Object
theme <- theme(
  #Panel Border
  panel.border = element_rect(color = "black", fill = NA, linetype = 1, size = 0.5),
  plot.margin = unit(c(0.5,0.5,.5,0.5),"cm"),
  #Background950
  panel.background = element_rect(fill = NA),
  strip.background =element_rect(fill = NA),
  #Grid Lines
  panel.grid.major.x = element_blank(),
  panel.grid.minor.x = element_blank(),
  panel.grid.major.y =  element_line(color = "grey", linetype = 1, size = 0.5),
  panel.grid.minor.y = element_blank(),
  #Text
  text = element_text(family = "sans"),
  axis.text.x = element_text(color="black", size=14, vjust=0.5,hjust = 0.5, angle=0),
  axis.text.y = element_text(color="black", size=14, vjust=0.5), 
  axis.title.x=element_text(color="black", size=22, face="bold"),
  axis.title.y=element_text(color="black", size=22, vjust=2, face="bold"),
  plot.title = element_text(size = 25, hjust = 0.5, face="bold"),
  strip.text = element_text(size = 10, hjust = 0, face="bold"),
  #Legend
  legend.title = element_blank(), 
  legend.position = "none",
  legend.text = element_text(color = "black", size = 14, family = "sans"),
  legend.key = element_rect(fill = NA, color = NA),
  legend.spacing.x = unit(0.25,"cm")
) 

hline <- function(y = 0, color = "black") {
  list(
    type = "line",
    x0 = 0,
    x1 = 1,
    xref = "paper",
    y0 = y,
    y1 = y,
    line = list(color = color)
  )
}

# Data Input ---------------------

temp_data <- read.xlsx("./data/data_template.xlsx", sheet = "Concentration_Time_Data", startRow = 2,
                       check.names = F) %>%
  mutate(Event = as.integer(Event),
         Date = as.Date(Date, origin="1899-12-30",tryFormats = c("%Y-%m-%d", "%Y/%m/%d","%m/%d/%Y","%m-%d-%Y")))

temp_mw_info <- read.xlsx("./data/data_template.xlsx", sheet = "Monitoring_Well_Information", startRow = 1,
                       check.names = F, sep.names = " ")

temp_boring <- read_excel("./data/5648_Dummy_Borling.xlsx")


Table7_EA <- read_excel("./data/Table7_EA.xlsx")

Table10 <- read_excel("./data/Table10_summary.xlsx")

# Map -----------------------------
site_map <- leaflet() %>%
  addTiles(urlTemplate = 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
           attribution = '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> &copy; <a href="http://cartodb.com/attributions">CartoDB</a>',
           group='Grey Base', options = providerTileOptions(maxNativeZoom=19,maxZoom=100)) %>%
  addProviderTiles(providers$Esri.WorldImagery, group="Satellite (ESRI)", 
                   options = providerTileOptions(maxNativeZoom=19,maxZoom=100)) %>%
  addTiles(urlTemplate = "https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G", group="Satellite (Google)",
           options = providerTileOptions(maxNativeZoom=19,maxZoom=100)) %>%
  addMapPane("markers", zIndex = 420) %>%
  addMapPane("markers_selected", zIndex = 430) %>%
  addScaleBar("bottomleft")

# Borden Tool Kit ----------------

Constituents <- read_excel("./data/BordenTool_Data_Template.xlsx", 
                           sheet = "Constituents")

LowK_Soil_Type <- read_excel("./data/BordenTool_Data_Template.xlsx", 
                             sheet = "LowK_Soil_Type")

TZ_Soil_Type <- read_excel("./data/BordenTool_Data_Template.xlsx", 
                           sheet = "TZ_Soil_Type")

Parameters <- read_excel("./data/BordenTool_Data_Template.xlsx", 
                         sheet = "Parameters")

# name of Constituents order
Constituents_order <-c("***User specified***",
                       "PCE","TCE","cis-DCE","1,1-DCE","Vinyl chloride",
                       "1,1,1-TCA", "1,1-DCA","1,2-DCA",
                       "Benzene","Ethylbenzene","Toluene","Xylene","MTBE")
TZ_soil_order <- c("Gravel","Coarse Sand", "Medium Sand", "Fine Sand")

figure_list <-c("01_X.png","02_i.png","03_COC.png",
                "04_Year_Started.png","05_Year_Removed.png","06_Concentration.png",                
                "07_Thickness.png","08_HK_soil.png","09_LK_soil.png",
                "10_Halflifev2.png","11_Halflifev2.png","12_PercentB.png",
                "13_LK_numbers.png","14_HK.png","15_ne.png",
                "16_n.png","17_BGLG.png","18_D.png",
                "19_tortuosity.png","20_HK_FOC.png","21_LK_FOC.png",
                "22_HK_bulkD.png","23_LK_bulkD.png","24_HK_retardation.png",
                "25_LK_retardation.png","26_KOC.png","27_TCLevel.png",
                "28_MC.png","29_Seepage.png")

figure_list_1<-c("Help Box Tool1_Page_1.png","Help Box Tool1_Page_2.png","Help Box Tool1_Page_3.png")
figure_list_2<-c("Help Box Tool2_Page_1.png")
figure_list_4<-c("Help Box Tool4_Page_1.png","Help Box Tool4_Page_2.png")
figure_list_5<-c("Help Box Tool5_Page_1.png","Help Box Tool5_Page_2.png","Help Box Tool5_Page_3.png","Help Box Tool5_Page_4.png")


# tool 4 default database
df_tool4 = read_excel("./data/TA2 ESTCP Remediation Performance Database.xlsx",
                                      range = "A2:K308",
                                      sheet = "Sheet1")
linear_df <- read_excel("./data/TA2 ESTCP Remediation Performance Database.xlsx",
                                                 sheet = "Sheet2")
linear_df_Benzene <- read_excel("./data/TA2 ESTCP Remediation Performance Database.xlsx",
                        sheet = "Sheet3")

MCL <- read_excel("./data/TA2 ESTCP Remediation Performance Database.xlsx",
                                sheet = "Sheet4")

site_max = c('All Sites','>200,000 ug/L','2,000 to 200,000 ug/L',
             '20 to 2,000 ug/L', '<20 ug/L')

BRemlist<- c(df_tool4%>%filter(`Parent CVOC`=='Benzene')%>%
  select(Technology)%>%
  distinct())$Technology

CRemlist<- c(df_tool4%>%filter(`Parent CVOC`!='Benzene')%>%
           select(Technology)%>%
           distinct())$Technology


RemPotential <- read_excel("data/Table4_Rem_Potential.xlsx")
RemPotential$High = FALSE
RemPotential$Moderate = FALSE
RemPotential$Low = FALSE
RemPotential$Help = c(
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites that have physical or administrative barriers to access have a lower likelihood of achieving remediation objectives.  This could include the presence of buildings or other infrastructure that limit access and/or the ability to deliver remedial amendments, as well as property rights and other administrative factors.  See Section 3.3.1 of ITRC 2017 for more information.",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  ),
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites where drilling has the potential to be slow and/or resource intensive have a lower likelihood of achieving remediation objectives because these limitations may hinder the use of many common remediation techniques.  Sites with shallow contamination in unconsolidated formations have a greater flexibility in terms of drilling or excavation options.  See Section 3.3.2 of ITRC 2017 for more information.",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  ),
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites where the size of the source zone and the size of the plume are large have a lower likelihood of achieving remediation objectives because it may be impractical to use standard remediation methods.  See Section 3.3.2 of ITRC 2017 for more information. ",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  ),
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites that require concentrations to be reduced by two or more orders of magnitude in order to meet closure criteria have a lower likelihood of achieving remediation objectives.  This is because currently available remediation technologies can typically achieve an order of magnitude concentration reduction but infrequently achieve a concentration reduction of two or more orders of magnitude.  See the 'Results' tab of Tool 4 for more information, as well as Section 3.3.4 of ITRC 2017.",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  ),
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites where the contaminants do not readily attenuate relative to the travel time to downgradient receptors have a lower likelihood of achieving remediation objectives.  This may because degradation rates are limited by geochemical conditions, a lack of carbon or other substrates, and other factors that contribute to low concentrations of key microorganisms or reactive minerals.  It may also occur when groundwater velocity is fast or the source concentration is high, such that rates are insufficient to reduce concentrations to the cleanup goal by the time contaminants reach the downgradient receptor.  See Tool 5 for more help in estimating attenuation rate constants and projecting concentrations vs distance from a source.  See also Section 3.3.5 of ITRC 217 for more information.",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  ),
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites where a significant portion of the mass is associated with NAPL or is present in lower-permeability zones have a lower likelihood of achieving remediation objectives.  The release of contaminant mass into aquifers at these sites may occur slowly and serve as a long-term persistent source, which can increase the remediation timeframe.  In addition, it may be difficult for most technologies to treat mass that is present in low-permeability zones or as NAPL.  See Tool 6 for more information on how the process of matrix diffusion influences contaminant behavior and Tool 7 for more information on geological heterogeneity.  See also Section 3.3.6 of ITRC 2017.",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  ),
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites where remediation has already been implemented (or evaluated through treatability or pilot testing) but was unable to achieve the necessary concentration reductions have a lower likelihood of achieving remediation objectives.  The actual performance of a remediation technology can be coupled with an understanding of the potential performance of other technologies under consideration (see the 'Results' tab of Tool 4) to get a more complete picture.  See Section 3.3.7 of ITRC 2017 for more information.",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  ),
  as.character(
    span(
      `data-toggle` = "tooltip", `data-placement` = "right",
      title = "Sites with a long projected remediation timeframe have a have a lower likelihood of achieving remediation objectives.  Determining what constitutes a reasonable timeframe is a site-specific decision, and it may rely on establishing interim objectives over a timeframe of 20 years or less (ITRC 2017).  The remediation timeframe can be estimated in a number of ways, typically using a combination of field data, statistical projections, and modeling.  This includes the approaches described in Tool 1, Tool 3, and Tool 6 of the TA2 Tool.  See Section 3.3.8 of ITRC 2017 for more information.",
      icon("fa-solid fa-circle-question fa-2xl")
    )
  )
)

# # Functions -----------------
# #Convert lat/long
# convert_coords <- function(x,y) {
#   
#   library(rgdal)
#   
#   loc.points <- data.frame(x_coords=x, y_coords=y)
#   
#   sputm <- SpatialPoints(loc.points, proj4string=CRS("+init=epsg:3582"))  
#   spgeo <- spTransform(sputm, CRS("+init=epsg:4326"))
#   
#   loc.points <- spgeo@coords
#   
#   x_coords = loc.points[,1]
#   y_coords = loc.points[,2]
#   
#   coords <- data.frame(x=x_coords, y=y_coords)
#   
#   return(coords)
#   
# }
# 
# # Format axis numbers 
# fmt_dcimals <- function(decimals=5, format = "G"){ 
#   function(x) formatC(x, digits = decimals, big.mark = ",", format = format)
# }

# Formatting --------------------------
##Set styles for buttons --------------


button_style <- "white-space: normal;
                        background-color:#eee;
                        text-align:center;
                        height:60px;
                        width:200px;
                        font-size: 14px;
                        padding: 10px 0;
                        margin:5px;"

button_style_v8_3 <- "white-space: normal;
                        background-color:#eee;
                        text-align:center;
                        height:865px;
                        width:1423px;
                        font-size: 20px;
                        padding: 0px 0;
                        margin:0px;"

button_style2 <- "white-space: normal;
                        background-color:#eee;
                        text-align:center;
                        height:34px;
                        width:34px;
                        font-size: 14px;
                        padding: 0px 0;
                        margin:0px;"


button_style3 <- "white-space: normal;
                        background-color:#eee;
                        text-align:center;
                        height:34px;
                        width:34px;
                        font-size: 14px;
                        padding: 0px 0;
                        margin:0px;"


button_style_big <- "white-space: normal;
                        text-align:center;
                        height:100px;
                        width:300px;
                        font-size: 18px;
                        background-color:#FFDF00"

button_style4 <- "white-space: normal;
                        background-color:#eee;
                        text-align:center;
                        height:60px;
                        width:100px;
                        font-size: 14px;
                        padding: 10px 0;
                        margin:5px;"


## Tab Titles ----------------

# Asymptote -----------------

# Etc...


## Loading Modules ------------------------------------
source("./R/00_Data_Input.R")
source("./R/01_Asymptote.R")
#source("./R/02_Expansion.R")

#source("./R/BordenTool.R")
#ource("./R/03_CleanupGoals.R")
#source("./R/03_CleanupGoals_linear.R")
source("./R/03_CleanupGoals_tab.R")

# # source("./R/03_CleanupGoals_MCtab.R")
#
source("./R/04_Performance.R")
#
source("./R/05_PlumeZone.R")

source("./R/06_MatrixDiffusion.R")
source("./R/07_EnhanceMNA.R")
#
#source("./R/08_Heterogeneity.R")
#

#
source("./R/10_Summary.R")

## Loading Functions ------------------------------------------------
lapply(paste0("./R/Functions/",
              list.files(path = "./R/Functions",
                         pattern = "[.]R$",
                         recursive = TRUE),
              sep=''),
       source)
# source("./R/Functions/MonteCarlo_LatinHyperCube_Sampling_Function.R")
# source("./R/Functions/BordenFunction.R")
# source("./R/Functions/HelpButtonFunction.R")

# Shinyio ------------------------------------------
## rsconnect::deployApp(appId = "4413726")
#rsconnect::deployApp(appName = "5648_SERDP_DEV")
