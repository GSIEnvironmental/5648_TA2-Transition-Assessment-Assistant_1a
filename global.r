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

# Load Packages ----------------

require(tidyverse)
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
 
 require(plotly)
 library(rsconnect)
 
 library(reticulate)

library(rhandsontable)
library(shinyscreenshot)
library(glue)
library(EnvStats)
library(lhs)
library(Rcpp)

# Plot Parameters -------------
# Colors
# The palette with grey:
plot_col <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# GGPLOT Theme Object
theme <- theme(
  #Panel Border
  panel.border = element_rect(color = "black", fill = NA, linetype = 1, size = 0.5),
  plot.margin = unit(c(0.5,0.5,.5,0.5),"cm"),
  #Background
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

# BordenToolKit-----------------

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
                "10_Halflife.png","11_Halflife - Copy.png","12_PercentB.png",
                "13_LK_numbers.png","14_HK.png","15_ne.png",
                "16_n.png","17_BGLG.png","18_D.png",
                "19_tortuosity.png","20_HK_FOC.png","21_LK_FOC.png",
                "22_HK_bulkD.png","23_LK_bulkD.png","24_HK_retardation.png",
                "25_LK_retardation.png","26_KOC.png","27_TCLevel.png")
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

button_style2 <- "white-space: normal;
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
                        font-size: 18px;"

## Tab Titles ----------------

# Asymptote -----------------

# Etc...


## Loading Modules ------------------------------------

source("./R/01_Asymptote.R")

source("./R/02_Expansion.R")

#source("./R/BordenTool.R")
#ource("./R/03_CleanupGoals.R")
#source("./R/03_CleanupGoals_linear.R")
source("./R/03_CleanupGoals_tab.R")

# source("./R/03_CleanupGoals_MCtab.R")

source("./R/04_Performance.R")

source("./R/05_MatrixDiffusion.R")

source("./R/07_Heterogeneity.R")

source("./R/09_PlumeZone.R")

source("./R/10_Summary.R")

source("./R/Functions/MonteCarlo_LatinHyperCube_Sampling_Function.R")
source("./R/Functions/BordenFunction.R")
source("./R/Functions/HelpButtonFunction.R")

# Shinyio ------------------------------------------
# rsconnect::deployApp(appId = "4413726")

