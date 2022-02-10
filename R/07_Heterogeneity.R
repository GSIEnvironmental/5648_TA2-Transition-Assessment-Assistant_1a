## Heterogeneity Modules -----------------------------

## UI -------------------------------------------
HeterogeneityUI <- function(id, label = "07_Heterogeneity"){
  ns <- NS(id)
  
  tabPanel("7. Heterogeneity",
           tags$h1(tags$b("Tool 7. Understand how much geologic heterogeneity there is at a site."))
  )
} # end Heterogeneity UI         


## Server Module -----------------------------------------
HeterogeneityServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      #### CHEAT SHEET for the calculation
      
      # # call in functions
      # lapply(paste0("./R/Functions/",
      #               list.files(path = "./R/Functions",
      #                          pattern = "[.]R$",
      #                          recursive = TRUE),
      #               sep=''),
      #        source)
      # 
      # 
      # library(tidyverse)
      # library(readxl)
      # library(gt)
      # # chose option of aquitard contacting plume, choose one
      # 
      # option = c('No Matrix Diffusion',
      #            'Matrix Diffusion in Underlying Low-K Units',
      #            'Matrix Diffusionin Overlying Low-K Units',
      #            'Matrix Diffusion in Under and Overlying Low-K Units')
      # 
      # aquitard = option[2]
      # 
      # # low K layer thickness
      # df <- read_excel("./data/5648_Dummy_Borling.xlsx")
      # 
      # # plug-in the depth to top and bottom of plume in tranmissive area in meters
      # Top = 10
      # Bottom = 21
      # 
      # Result_table<-  heterofunction(df,TOP,Bottom,aquitard)
      # for (var in 1:length(names(Result_table))){
      #   nam<-names(Result_table)[var]
      #   assign(nam, (Result_table[[var]]))
      # }
      # 
      # Table1<- data.frame(Key =html("Number of Aquitard Interfaces"),
      #                     Value = N_aquitard,
      #                     MD = Impact_diffusion)
      # Table1<-gt(Table1)%>%
      #   cols_label(Key = html("Key Matrix Diffusion<br>Variable for Aquitard(s)"),
      #              Value = "Values from Step 2",
      #              MD = html("Impact on<br>Matrix Diffusion"))%>%
      #   tab_style(style = list(cell_borders(sides = "all",
      #                                       style = "solid",
      #                                       weight = px(2),
      #                                       color = "#D3D3D3"),
      #                          cell_text(align = "center",
      #                                    v_align = "middle")),
      #             locations = cells_body()) 
      # 
      # Table2<- data.frame(Key =c('Percent of aquifer thickness (B) that is tranmissive','Numbers of Layer'),
      #                     Value = c(round(Percent_B,2),round(N_layer,1)),
      #                     MD = Impact_diffusion2)
      # Table2<- gt(Table2)%>%
      #   cols_label(Key = html("Key Matrix Diffusion<br>Variable for<br>Layers/Lenses(s)"),
      #              Value = "Values from Step 3",
      #              MD = html("Impact on<br>Matrix Diffusion"))%>%
      #   fmt_number(columns = c(2), rows = c(2), decimals = 0, use_seps=FALSE)%>%
      #   tab_style(style = list(cell_borders(sides = "all",
      #                                       style = "solid",
      #                                       weight = px(2),
      #                                       color = "#D3D3D3"),
      #                          cell_text(align = "center",
      #                                    v_align = "middle")),
      #             locations = cells_body()) 
      
      
    }
  )
} # end Heterogeneity Server 



