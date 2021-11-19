# Cleanup Goals Modules -----------------------------

## UI -----------------------------------------
CleanupGoals_tabUI <- function(id, label = "03_CleanupGoals_tab"){
  ns <- NS(id)
  
  tabPanel("3. Clean-up Goals",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
             HTML("<h1><b>Tool 3. How long will it take to reach cleanup goals after source remediation at my site?</h1></b>"),
             column(8,
                    HTML("<h3>This is a simple Tool to estimate the number of years it will take to reduce source concentrations by 90%, 99%, 
                    or 99.9%.  The Tool was developed by Dr. Bob Borden (Borden and Cha, 2021) and is based on the REMChlor-MD model.  
                    </h3><br>"))
           ), # end Page Title
           
           ## Input Data ----------
           fluidRow(
             column(5, style='border-right: 5px solid black',
                    HTML("<h2><b>Input Data </b></h2>"), 
                    tabsetPanel(
                      ## 1. Site/Temporal Settings & COC --------
                      tabPanel(HTML("1. Site/Temporal<br>Settings & COC"), 
                               br(),
                               HTML("<h4><b><i>Enter specific parameters below or use buttons to upload data (requires use of template file):</h4></b></i><br>"),
                               fluidRow(column(6,
                                               HTML("Choose Input File"),
                                               fileInput(ns("file"), label = "",
                                                         multiple = F,
                                                         accept = c("text/xlsx",
                                                                    "text/comma-separated-values,text/plain",
                                                                    ".xlsx"), 
                                                         width = "200px")),
                                        column(6, align = "center",
                                               fluidRow(actionButton(ns("update_inputs"), 
                                                              HTML("Update Input Values<br>from Input File"), style = button_style)),
                                               fluidRow(HTML("<i>Will reset all input values.</i>")))),
                               # Parameter Inputs
                               fluidRow(style="display: inline-block;vertical-align:top;", br(),
                                        fluidRow(column(6, align = "right",
                                                        HTML("Distance from Source to Monitoring Well (meters):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("X"), NULL, value=28.8, min = 0, step = 0.01)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help1"), HTML("?"), style = button_style2))), 
                                        br(), 
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Hydraulic Gradient (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("i"), NULL, value=0.001, min = 0, step = 0.00001)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help2"), HTML("?"), style = button_style2))), 
                                        br(), 
                                        fluidRow(column(6, align = "right",
                                                        HTML("Constituent of Concern:")),
                                                 column(4, align = "center",
                                                        selectInput(ns("COC"),label = NULL,
                                                                    choices = c(sort(unique(Constituents$`Constituents Name`))),
                                                                    selected = "TCE", multiple = F, selectize = FALSE)),
                                                 column(2, align = "left", 
                                                        actionButton(ns("help3"), HTML("?"), style = button_style2))), 
                                        br(), 
                                        fluidRow(column(12,align='right',
                                                        conditionalPanel(condition = "input.COC==`***User specified***`", ns = ns,
                                                                         tags$i(h4("Assign values in Diffusion Coefficient and Partition Coefficient under Tab 3"),
                                                                                style = "color: rgb(0,166,90)"),))), # end conditional panel
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Year Source Started:")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Year_Started"), NULL, value = 1978, min = 1500)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help4"), HTML("?"), style = button_style2))),
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Year Source Removed:")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Year_Removed"), NULL, value = 2020, min = 1500)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help5"), HTML("?"), style = button_style2))),
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Concentration of COC Befoure Source Removed (ug/L):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Concentration"), NULL, value = 1000, min = 0, step = 0.01)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help6"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(
                                          HTML('<img style = "padding: 10px 50px 10px 10px;" 
                                               src = "./03_CleanupGoals/BordenToolKit_Pic_2-1.png" 
                                               width = "100%"  
                                               height = "100%">')),
                                        br(),br(),br()
                                        )# end parameter inputs
                      ), # end first tabpanel
                      ## 2. Select Scenario & Hydrologic Setting ---------------
                      tabPanel(HTML("2. Select Scenario &<br>Hydrologic Setting"),
                               br(),
                               fluidRow(column(10,align="center",
                                        HTML("<h4><b><i>Select the hydrogeologic setting that best matches your site.</i></b></h4>")),
                                        column(2, align = "left",
                                               actionButton(ns("help17"), HTML("?"), style = button_style2))
                                        ), 
                               br(),
                                # Hydrogeologic Setting
                               fluidRow(column(6, align="left",
                                               # tags$style(HTML(".radio {margin-top: 50px;margin-bottom: 50px;}")),
                                               radioButtons(ns("BGLG"), NULL,
                                                            choices = list("Setting 1: Aquifer with aquitard (either below, above, or both)" = 1,
                                                                           "Setting 2: Aquifer with no aquitard but layers/lenses" = 2,
                                                                           "Setting 3: Aquifer with both aquitard and layers/lenses" = 3 ),
                                                            selected = 1, inline = FALSE)),
                                        
                                        column(6, align = "center",
                                               fluidRow(HTML("<i>Setting 1</i>")),
                                               fluidRow(img(src = "./03_CleanupGoals/BordenToolKit_BG_Pic_2-2.png",
                                                   width = "225px", height = "150px")),
                                               br(),br(),
                                               fluidRow(HTML("<i>Setting 2</i>")),
                                               fluidRow(img(src = "./03_CleanupGoals/BordenToolKit_LG_Pic_2-3.png",
                                                            width = "225px", height = "150px")),
                                               br(),br(),
                                               fluidRow(HTML("<i>Setting 3</i>")),
                                               fluidRow(img(src = "./03_CleanupGoals/BordenToolKit_BGLG_Pic_2-4.png",
                                                            width = "225px", height = "150px")),
                                               br(),br())),#column end
                               # All Scenarios Parameters
                               fluidRow(
                                 conditionalPanel(
                                   condition = "input.BGLG==1|input.BGLG==2|input.BGLG==3", ns = ns,
                                   HTML("<h4><b><i>For All Scenarios:</i></b></h4>"),
                                   fluidRow(column(6, align = "right", 
                                                   HTML("Aquifer Thickness (meters):")),
                                            column(4, align = "center",
                                                   numericInput(ns("Thickness"), NULL, value = 5, min = 0)),
                                            column(2, align = "left",
                                                   actionButton(ns("help7"), HTML("?"), style = button_style2))), 
                                   br(),
                                   fluidRow(column(6, align = "right",
                                                   HTML("Transmissive Zone Soil Type:")),
                                            column(4, align = "center",
                                                   selectInput(ns("HighKPorousMedia"), label = NULL,
                                                               choices = c(sort(unique(TZ_Soil_Type$Soil_Type))),
                                                               selected = "Sand", multiple = F, selectize = FALSE)),
                                            column(2, align = "left", 
                                                   actionButton(ns("help8"), HTML("?"), style = button_style2))), 
                                   br(), 
                                   fluidRow(column(6, align = "right",
                                                   HTML("Low-k Soil Type:")),
                                            column(4, align = "center",
                                                   selectInput(ns("LowKPorousMedia"), label = NULL,
                                                               choices = c(sort(unique(LowK_Soil_Type$Soil_Type))),
                                                               selected = "Clay", multiple = F, selectize = FALSE)),
                                            column(2, align = "left", 
                                                   actionButton(ns("help9"), HTML("?"), style = button_style2))), 
                                   br(),
                                   fluidRow(column(10, align = "center",
                                                   radioButtons(ns("HalfLifeYN"), label = NULL,
                                                                choices = list("Do Not Include Low-k Degradation" = 1,
                                                                               "Include Low-k Degradation" = 2),
                                                                selected = 1, inline = TRUE)),
                                            column(2, align = "left", 
                                                   actionButton(ns("help10"), HTML("?"), style = button_style2))), 
                                   br()),
                                   conditionalPanel(
                                     condition = "input.HalfLifeYN==2", ns=ns,
                                     fluidRow(column(6, align = "right", 
                                                     HTML("Low-k Degradation Half-Life (years):")),
                                              column(4, align = "center",
                                                     numericInput(ns("HalfLife"), NULL, value = 100, min = 0)),
                                              column(2, align = "left",
                                                     actionButton(ns("help11"), HTML("?"), style = button_style2))), 
                                     br(),
                                   ),# conditional Panel closed
                                 conditionalPanel(
                                   condition = "input.BGLG==2|input.BGLG==3", ns = ns,
                                   HTML("<h4><b><i>For Layer/Lenses Scenarios:</i></b></h4>"), 
                                   fluidRow(column(6, align = "right", 
                                                   HTML("Percent of B that is Transmissive (%):")),
                                            column(4, align = "center",
                                                   numericInput(ns("Percent_T"), NULL, value = 87.5, min = 0)),
                                            column(2, align = "left",
                                                   actionButton(ns("help12"), HTML("?"), style = button_style2))), 
                                   br(),
                                   fluidRow(column(6, align = "right", 
                                                   HTML("Number of Low-k Layers (-):")),
                                            column(4, align = "center",
                                                   numericInput(ns("N"), NULL, value = 2, min = 0)),
                                            column(2, align = "left",
                                                   actionButton(ns("help13"), HTML("?"), style = button_style2))), 
                                   br()
                                   ), # end conditional panel
                                 br(), br()
                               ) # end fluidRow
                      ), # end tab panel 2
                      ## 3. (Optional) Site-Specific Parameters -------------------------------------
                      tabPanel(HTML("3. Site-Specific<br>Parameters (Optional)"),
                               fluidRow(br(),
                                        fluidRow(align = "center", HTML("<h4><b><i>Hydrogeology Parameters</i></b></h4>")),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Hydraulic Conductivity of Transmissive Zone (cm/s):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("K"), NULL, value = 0.032, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help14"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Effective Porosity of Transmissive Zone (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("ne"), NULL, value = 0.25, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help15"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Total Porosity of Low-K Zone (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("n"), NULL, value = 0.43, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help16"), HTML("?"), style = button_style2))),
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Seepage Velocity (m/year):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Seep_V"), NULL, value = 39.8615, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help29"), HTML("?"), style = button_style2))),
                                        br(),
                                        fluidRow(align = "center", HTML("<h4><b><i>Diffusion Parameters</i></b></h4>")),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Diffusion Coefficient of COC at 20°C (cm²/s):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("D"), NULL, value = 9.1*10**(-6), min = 0, step = 0.000001)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help18"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Tortuosity of Low-k Zone (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("tortuosity_LK"), NULL, value = 0.7, min = 0.07, max = 0.71)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help19"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(align = "center", HTML("<h4><b><i>Retardation Parameters</i></b></h4>")),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Fraction Organic Carbon Transmissive Zone (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("foc_HK"), NULL, value = 0.001, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help20"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Fraction Organic Carbon Low-K Zone (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("foc_LK"), NULL, value=0.002, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help21"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Bulk Density of Transmissive Zone (g/mL):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Rho_HK"), NULL, value=1.7, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help22"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Bulk Density of Low-K Zone (g/mL):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Rho_LK"), NULL, value=1.7, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help23"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Retardation Factor of Transmissive Zone (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Retardation_HK"), NULL, value = 1.632, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help24"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Retardation Factor of Low-K Zone (-):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Retardation_LK"), NULL, value = 1.753, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help25"), HTML("?"), style = button_style2))), 
                                        br(),
                                        fluidRow(column(6, align = "right", 
                                                        HTML("Partition Coefficient of COC (mL/g):")),
                                                 column(4, align = "center",
                                                        numericInput(ns("Partition_Coeff"), NULL, value = 93.3, min = 0)),
                                                 column(2, align = "left",
                                                        actionButton(ns("help26"), HTML("?"), style = button_style2))), 
                                        br(),br())
                      ), # end tab panel 3 
                      ## 4. Uncertainty Analysis (Optional) -----------------
                      tabPanel(HTML("4. Uncertainty Analysis<br>(Optional)"),
                               br(),
                               fluidRow(column(10, HTML("<h4><b><i>Enter Upper and Lower Limit Values for the Following Parameters</i></b></h4>")),
                                        column(2, align = "left",
                                               actionButton(ns("help28"), HTML("?"), style = button_style2))),
                               fluidRow(column(6, align = "left", HTML("<h4><b>Parameter:</b></h4>")),
                                        column(3, align = "center", HTML("<h4><b>Lower Limit:</b></h4>")),
                                        column(3, align = "center", HTML("<h4><b>Upper Limit:</b></h4>"))),
                               fluidRow(column(6, align = "left", uiOutput(ns("X_txt"))),
                                        column(3, align = "center", numericInput(ns("X_LL"), NULL, value = NULL, min = 0)),
                                        column(3, align = "center", numericInput(ns("X_UL"), NULL, value = NULL, min = 0))),
                               br(),
                               fluidRow(column(6, align = "left", uiOutput(ns("Year_Started_txt"))),
                                        column(3, align = "center", numericInput(ns("Year_Started_LL"), NULL, value = NULL, min = 0)),
                                        column(3, align = "center", numericInput(ns("Year_Started_UL"), NULL, value = NULL, min = 0))),
                               br(),
                               fluidRow(column(6, align = "left", uiOutput(ns("tortuosity_LK_txt"))),
                                        column(3, align = "center", numericInput(ns("tortuosity_LK_LL"), NULL, value = NULL, min = 0)),
                                        column(3, align = "center", numericInput(ns("tortuosity_LK_UL"), NULL, value = NULL, min = 0))),
                               br(),
                               fluidRow(column(6, align = "left", uiOutput(ns("Retardation_HK_txt"))),
                                        column(3, align = "center", numericInput(ns("Retardation_HK_LL"), NULL, value = NULL, min = 0)),
                                        column(3, align = "center", numericInput(ns("Retardation_HK_UL"), NULL, value = NULL, min = 0))),
                               br(),
                               fluidRow(column(6, align = "left", uiOutput(ns("Retardation_LK_txt"))),
                                        column(3, align = "center", numericInput(ns("Retardation_LK_LL"), NULL, value = NULL, min = 0)),
                                        column(3, align = "center", numericInput(ns("Retardation_LK_UL"), NULL, value = NULL, min = 0))),
                               br(),
                               fluidRow(column(6, align = "left", uiOutput(ns("Thickness_txt"))),
                                        column(3, align = "center", numericInput(ns("Thickness_LL"), NULL, value = NULL, min = 0)),
                                        column(3, align = "center", numericInput(ns("Thickness_UL"), NULL, value = NULL, min = 0))),
                               br(),
                               conditionalPanel(
                                 condition = "input.HalfLifeYN==2", ns=ns,
                                 fluidRow(column(6, align = "left", uiOutput(ns("HalfLife_txt"))),
                                          column(3, align = "center", numericInput(ns("HalfLife_LL"), NULL, value = NULL, min = 0)),
                                          column(3, align = "center", numericInput(ns("HalfLife_UL"), NULL, value = NULL, min = 0))),
                                 br(),
                               ),# conditional Panel closed
                               conditionalPanel(
                                 condition = "input.BGLG==2|input.BGLG==3", ns = ns,
                                 fluidRow(column(6, align = "left", uiOutput(ns("Percent_T_txt"))),
                                          column(3, align = "center", numericInput(ns("Percent_T_LL"), NULL, value = NULL, min = 0)),
                                          column(3, align = "center", numericInput(ns("Percent_T_UL"), NULL, value = NULL, min = 0))),
                                 br()
                               ), # end conditional panel
                               fluidRow(column(6, align = "left", uiOutput(ns("Seep_V_txt"))),
                                        column(3, align = "center", numericInput(ns("Seep_V_LL"), NULL, value = NULL, min = 0)),
                                        column(3, align = "center", numericInput(ns("Seep_V_UL"), NULL, value = NULL, min = 0))),
                               br()
                    ))), # end Input Date tabset panel
             # column(1, align = "center"),
                    # Results -----------------------
             column(6, 
                    # Table of Results
                    fluidRow(align="left", style='padding-left:50px;',
                             HTML("<h2><b>View Results*</b></h2>"),
                             HTML("<h3 style = 'color: #4a746c;'><b><i>1. See Timeframe to Reduce Plume Concentrations by 90%, 99%, and 99.9%</i></b></h4>"),
                             br(),
                             fluidRow(align = "center",
                                      gt_output(ns("calc_output")),
                                      br(),
                                      htmlOutput(ns("selected_TT"))),
                             br(), br(),
                             # Plot of Results
                             HTML("<h3 style = 'color: #4a746c;'><b><i>2. See Approximate Timeframe to a Reach Clean-up Goal (optional) </i></b></h4>"),
                             br(),
                             fluidRow(column(6, align = "right",
                                             HTML("Target Clean-up Level (ug/L):")),
                                      column(4, align = "center",
                                             numericInput(ns("Target_Clean_Level"), NULL, value = 5, min = 0, step = 0.01)),
                                      column(2, align = "left",
                                             actionButton(ns("help27"), HTML("?"), style = button_style2))),
                             fluidRow(align = "center", htmlOutput(ns("selected_TT2")),
                                      conditionalPanel(
                                        condition = "input.HalfLifeYN==1",ns=ns,
                                        plotlyOutput(ns("dygraph_plot1"), height = 500))), 
                             br(),
                             # Save Results
                             fluidRow(align = "left",
                                      HTML("<h3 style = 'color: #4a746c;'><b><i>3. Save and/or Print </i></b></h3>"),
                                      br()),
                             fluidRow(align = "center",
                                      downloadButton(ns("model_results"), HTML("Export Model Results and Input Tables"), style=button_style),
                                      actionButton(ns("go"), HTML("Export Screen Shot"), style=button_style),
                                      br(), br()),
                             HTML("<h4><i>* Because this simple Tool assumes that at 100% of the source mass is removed or isolated, 
                             and because statistics show in-situ remediation is thought to be able to remove about 90% of the source mass, 
                             these remediation timeframe estimates will likely be too short compared to actual timeframes for conventional 
                             in-situ remediation projects.</h4></i><br><br>"),
                    )
             ) # end Results
           ) # end FluidRow
  ) # end tab panel
} # end Cleanup Goals UI  

## Server -------------------------------------
CleanupGoals_tabServer <- function(id) {
  beginning <- Sys.time()
  moduleServer(
    id,
    
    function(input, output, session) {
      # Update Input Values based on Calculations ------------------
      # Updates based on Transmissive material inputs
      observeEvent({input$HighKPorousMedia},{
        # Hydraulic Conductivity of Transmissive Zone (cm/s)
        K <- TZ_Soil_Type %>% filter(Soil_Type == input$HighKPorousMedia) %>% 
          pull(`Hydraulic Conductivity [cm/s]`) 
        ##### CHECK UNIT CONVERSION FOR K ######
        updateNumericInput(session, "K", value = signif(K,3))
        
        # Effective Porosity of Transmissive Zone (-)
        ne <- TZ_Soil_Type %>% filter(Soil_Type == input$HighKPorousMedia) %>% 
          pull(`Effective Porosity [-]`) 
        updateNumericInput(session, "ne", value = round(ne,2))
        }) # end updates based on transmissive material
      
      # Updates based on Low-K material input
      observeEvent({input$LowKPorousMedia},{
        # Total Porosity of Low-K Zone (-)
        n <- LowK_Soil_Type %>% filter(Soil_Type == input$LowKPorousMedia) %>% 
          pull(`Porosity [-]`)
        updateNumericInput(session, "n", value = round(n,2))
        
        # Tortuosity of Low-k Zone (-)
        LK <- LowK_Soil_Type %>% filter(Soil_Type == input$LowKPorousMedia) %>% 
          pull(`Hydraulic Conductivity [cm/s]`)
        tortuosity_LK = 0.77*(LK/86400)**0.04
        #### CHECK UNITS #####
        updateNumericInput(session, "tortuosity_LK", value =round(tortuosity_LK,2))
      }) # end updates based on low-k material
      
      # Updates based on Chemical input
      observeEvent({input$COC},{
        # Diffusion Coefficient of COC at 20°C (cm²/s)
        D <- Constituents %>% filter(`Constituents Name` == input$COC) %>% 
          pull(`Diffusion Coefficient[cm2/sec]`)
        updateNumericInput(session, "D", value = round(D,8))
        
        # Partition Coefficient of COC (mL/g)
        KOC <- Constituents %>% filter(`Constituents Name` == input$COC) %>% 
          pull(`Partition Coefficient of Constituent Koc [L/kg]`)
        #### CHECK UNITS ####
        updateNumericInput(session, "Partition_Coeff", value = round(KOC,0))
      }) # end updates based on chemical
      
      # Updates for Retardation Factor of Transmissive Zone (-)
      observeEvent({
        input$Partition_Coeff
        input$foc_HK
        input$Rho_HK
        input$ne
        },{
        Retardation_HK = 1 + input$Partition_Coeff * input$foc_HK * input$Rho_HK/input$ne
        updateNumericInput(session, "Retardation_HK", value = signif(Retardation_HK,3))
      }) # end updates for Retardation_HK
      
      # Updates for Retardation Factor of Low-K Zone (-)
      observeEvent({
        input$Partition_Coeff
        input$foc_HK
        input$Rho_HK
        input$n
      },{
        Retardation_LK = 1 + input$Partition_Coeff * input$foc_LK * input$Rho_LK/input$n
        updateNumericInput(session, "Retardation_LK", value = signif(Retardation_LK,3))
      }) # end updates for Retardation_LK
      
      # Updates for Seepage Velocity
      observeEvent({
        input$K
        input$i
        input$ne
      },{
        vel = input$K*input$i/input$ne/100*60*60*24*365 # seepage velocity of high K zone (m/yr)
        updateNumericInput(session, "Seep_V", value = signif(vel,3))
      }) # end updates for Retardation_LK
      
      
      # Updates Values for Uncertainty Analysis ranges ---------------
      observeEvent({input$X},{
          updateNumericInput(session, "X_LL", value = input$X*0.8)
          updateNumericInput(session, "X_UL", value = input$X*1.2)
      }) # end updates thickness
      
      observeEvent({input$Year_Started},{
        updateNumericInput(session, "Year_Started_LL", value = input$Year_Started-10)
        updateNumericInput(session, "Year_Started_UL", value = input$Year_Started+10)
      }) # end updates year started
      
      observeEvent({input$tortuosity_LK},{
        updateNumericInput(session, "tortuosity_LK_LL", value = input$tortuosity_LK*0.9)
        updateNumericInput(session, "tortuosity_LK_UL", value = input$tortuosity_LK*1.1)
      }) # end updates tortuosity_LK
      
      observeEvent({input$Retardation_HK},{
        updateNumericInput(session, "Retardation_HK_LL", value = input$Retardation_HK*0.8)
        updateNumericInput(session, "Retardation_HK_UL", value = input$Retardation_HK*1.2)
      }) # end updates Retardation_HK
      
      observeEvent({input$Retardation_LK},{
        updateNumericInput(session, "Retardation_LK_LL", value = input$Retardation_LK*0.8)
        updateNumericInput(session, "Retardation_LK_UL", value = input$Retardation_LK*1.2)
      }) # end updates Retardation_LK
      
      observeEvent({input$Thickness},{
        updateNumericInput(session, "Thickness_LL", value = input$Thickness*0.8)
        updateNumericInput(session, "Thickness_UL", value = input$Thickness*1.2)
      }) # end updates Thickness
      
      observeEvent({input$HalfLife},{
        updateNumericInput(session, "HalfLife_LL", value = input$HalfLife*0.5)
        updateNumericInput(session, "HalfLife_UL", value = input$HalfLife*2)
      }) # end updates HalfLife
      
      observeEvent({input$Percent_T},{
        updateNumericInput(session, "Percent_T_LL", value = input$Percent_T*0.8)
        updateNumericInput(session, "Percent_T_UL", value = input$Percent_T*1.2)
      }) # end updates Percent_T
      
      observeEvent({input$Seep_V},{
        updateNumericInput(session, "Seep_V_LL", value = input$Seep_V*0.8)
        updateNumericInput(session, "Seep_V_UL", value = input$Seep_V*1.2)
      }) # end updates Seep_V
      
      ## Reactive Variables -------------------------------
      results <- reactiveVal()
      error <- reactiveVal()
      
      observe({
        # error("Check Inputs")
        req(input$X_LL < input$X & input$X_UL > input$X,
            input$Year_Started_LL < input$Year_Started & input$Year_Started_UL > input$Year_Started,
            input$tortuosity_LK_LL < input$tortuosity_LK & input$tortuosity_LK_UL > input$tortuosity_LK,
            input$Retardation_HK_LL < input$Retardation_HK & input$Retardation_HK_UL > input$Retardation_HK,
            input$Retardation_LK_LL < input$Retardation_LK & input$Retardation_LK_UL > input$Retardation_LK,
            input$Thickness_LL < input$Thickness & input$Thickness_UL > input$Thickness,
            input$HalfLife_LL < input$HalfLife & input$HalfLife_UL > input$HalfLife,
            input$Percent_T_LL < input$Percent_T & input$Percent_T_UL > input$Percent_T,
            input$Seep_V_LL < input$Seep_V & input$Seep_V_UL > input$Seep_V,
            input$i,
            input$COC,
            input$Year_Removed,
            input$K,
            input$ne,
            input$n,
            input$D,
            input$Concentration,
            input$Target_Clean_Level,
            input$BGLG,
            input$HighKPorousMedia,
            input$LowKPorousMedia,
            input$N,
            input$foc_HK,
            input$foc_LK,
            input$Rho_HK,
            input$Rho_LK)

        df<-MC_function_LHC(input)

        if (df$type=='BG'){
          results_list<-BG_BordenFunction(df)
        }else if (df$type =='LG'){
          results_list<-LG_BordenFunction(df)
        }else{
          results_list = pmax(LG_BordenFunction(df),BG_BordenFunction(df))
        }
        results(results_list)
        error("")
      })
      
      # Update Values Based on Input Files, if given ---------------------------
      observeEvent(input$update_inputs,{
        # If no file is loaded nothing happens 
        if(!is.null(input$file)){
          file <- input$file
          
          # Organize Parameters
          par <- read_xlsx(file$datapath, sheet = "Parameters")
          
          #step2
          updateNumericInput(session, "X", value = par$`Distance to Monitoring Well (m)`)
          updateNumericInput(session, "i", value = par$`Hydraulic Gradient (-)`)
          updateSelectInput(session, "COC", selected = par$COC)
          updateNumericInput(session, "Year_Started", value = par$`Year Source Started (year)`)
          updateNumericInput(session, "Year_Removed", value = par$`Year Source Removed (year)`)
          BGLG_input <-ifelse(par$`The option for hydrogeologic setting`=='BG',1,
                              ifelse(par$`The option for hydrogeologic setting`=='LG',2,3))
          updateRadioButtons(session, "BGLG", selected = BGLG_input)
          
          # step 4
          updateNumericInput(session, "Thickness", value = par$`Aquifer Thickness (m)`)
          updateSelectInput(session, "HighKPorousMedia", selected = par$`Transmissive Geology`)
          updateSelectInput(session, "LowKPorousMedia", selected = par$`Low-K Geology`)
          updateSelectInput(session, "HalfLifeYN", selected = par$`Half Life Included`)
          if (par$`Half Life Included`=='yes'){
            updateNumericInput(session, "HalfLife", value = par$`Low-K Degradation Half-Life (year)`)
          }
          updateNumericInput(session, "Year_Removed", value = par$`Year Source Removed (year)`)
          #step 5&6
          updateNumericInput(session, "Concentration", value = par$`Current Concentration at Monitoring Well`)
          #updateNumericInput(session, "Year_now", value = par$`Year now (year)`)
          updateNumericInput(session, "Target_Clean_Level", value = par$`Target Clean-Up Level (ug/L)`)
          # step 8
          updateNumericInput(session, "K", value = par$`Hydraulic Conductivity of Transmissive Zone (cm/s)`)
          updateNumericInput(session, "ne", value = par$`Effective Porosity of Transmissive Zone (-)`)
          updateNumericInput(session, "n", value = par$`Total Porosity of Low-K Zone (-)`)
          updateNumericInput(session, "D", value = par$`Diffusion Coefficient of COC (cm2/s)`)
          updateNumericInput(session, "tortuosity_LK", value = par$`Tortuosity of Low-K Zone (-)`)
          updateNumericInput(session, "Retardation_HK", value = par$`Retardation Factor of Transmissive Layer (-)`)
          updateNumericInput(session, "Retardation_LK", value = par$`Retardation Factor of Low-K Layer (-)`)
          updateNumericInput(session, "foc_HK", value = par$`Fraction Organic Carbon Transmissive Layer (-)`)
          updateNumericInput(session, "foc_LK", value = par$`Fraction Organic Carbon Low-K Layer (-)`)
          updateNumericInput(session, "Rho_HK", value = par$`Bulk Density of Transmissive Layer (kg/L)`)
          updateNumericInput(session, "Rho_LK", value = par$`Bulk Density of Low-K Layer (kg/L)`)
          updateNumericInput(session, "Partition_Coeff", value = par$`Partition Coefficient of COC (L/kg)`)
          
          if (par$`The option for hydrogeologic setting` %in% c("BG","LG")){
            updateNumericInput(session, "Percent_T", value = par$`Percent of thickness that is transmissive (%)`)
            updateNumericInput(session, "N", value = par$`Number of Low-K Layers`)
          }
        }
      }) # end update_inputs button
      

      ## Figure ----------------------------------------------
      plotlyfigureoutput <- reactive({
        results_list_all = results()
        
        results_list<-apply(results_list_all,2,mean)
        P10_list <-apply(results_list_all,2,function(x) quantile(x, probs = .1))
        P90_list <-apply(results_list_all,2,function(x) quantile(x, probs = .9))
        
        min_list <-apply(results_list_all,2,min)
        max_list <-apply(results_list_all,2,max)
        
        cd_1 <- data.frame(time = c(0,round(sort(results_list[c(4:6,8)]),1)),
                           Concentration=c(input$Concentration,
                                           sort(results_list[c(1:3,7)],decreasing=TRUE)))
        cd_1_p10 <- data.frame(time = c(0,round(sort(P10_list[c(4:6,8)]),1)),
                               Concentration=c(input$Concentration,
                                               sort(P10_list[c(1:3,7)],decreasing=TRUE)))
        cd_1_p90 <- data.frame(time = c(0,round(sort(P90_list[c(4:6,8)]),1)),
                               Concentration=c(input$Concentration,
                                               sort(P90_list[c(1:3,7)],decreasing=TRUE)))
        cd_1$p10range <-cd_1_p10$time
        cd_1$p90range <-cd_1_p90$time 
        
        tval <- sort(as.vector(sapply(seq(1,9), function(x) x*10^seq(ceiling(log10(min(cd_1$Concentration))),ceiling(log10(max(cd_1$Concentration))))))) #generates a sequence of numbers in logarithmic divisions
        tval2 = unique(sort(append(tval,as.numeric(results_list[7]))))
        ttxt <- rep(" ",length(tval2))  # no label at most of the ticks
        ind_cl=which(tval2==as.numeric(results_list[7]))
        
        if (length(tval2)==length(tval)){
          ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
          ttxt[ind_cl]<-as.numeric(results_list[7])
        }
        else{
          ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
          ttxt = append(ttxt,as.character(results_list[7]),after=ind_cl-1)
        }
        
        p <-plot_ly()%>%
          add_trace(data = cd_1, x= ~time+input$Year_Removed,
                    y = ~Concentration ,
                    name = ' ',
                    type = "scatter", line = list(shape = "spline",color='rgb(31,150,180)'),
                    mode = 'lines+markers',
                    hovertemplate = paste('<br>Year: %{x:.0f}', '<br>Concentration: %{y} ug/L<br>')
          )%>%
          add_trace(data = cd_1, x= ~p90range+input$Year_Removed,#90%
                    y = ~Concentration , 
                    name = ' ',
                    type = "scatter", line = list(shape = "spline",color='rgba(0,100,80,1)'),
                    mode = 'lines',
                    hovertemplate = paste('<br>Year: %{x:.0f}', '<br>Concentration 90th %: %{y} ug/L<br>')
          )%>%
          add_trace(data = cd_1, x= ~p10range+input$Year_Removed,#10%
                    y = ~Concentration , 
                    name = ' ',
                    type = "scatter", #line = list(shape = "spline",color='rgb(31,119,180)'),
                    mode = 'lines',
                    fill='tonexty',
                    fillcolor = 'rgba(0,100,80,0.2)',
                    line = list(shape = "spline",color='rgba(0,100,80,1)'),
                    hovertemplate = paste('<br>Year: %{x:.0f}', '<br>Concentration 10th %: %{y} ug/L<br>')
          )%>%
          # add_segments(x = input$Year_Removed,
          #              xend = round(as.numeric(results_list[6])+input$Year_Removed,0),
          #              y = as.numeric(results_list[7]), yend = as.numeric(results_list[7]),
          #              name = ' ',
          #              hovertemplate = paste(' '))%>%
          add_annotations(x = (round(as.numeric(results_list[6])+input$Year_Removed,0)-5),
                          y = log10(as.numeric(results_list[7])*1.3),
                          text = paste0("Clean-up Level (",results_list[7]," ug/L)"),
                          xref = "x",
                          yref = "y",
                          showarrow=F)%>%
          #plot_ly(source = "source") #%>%
          #add_trace(data = cd_1, x= ~time, y = ~Concentration , type = "scatter", 
          #          mode = 'lines+markers')  %>%
          #add_trace(data = cd_2, x= ~date, y = ~results, color = ~Analyte_Units, type = "scatter", mode = 'lines+markers',
          #          symbol = ~I(fill), yaxis = "y2") %>%
          layout(legend = list(orientation = 'h'),
                 shapes = list(hline(results_list[7])),
            xaxis = list(title="Year",
                         automargin = T,
                         showline=T,
                         mirror = "ticks",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         #range = c(input$Year_now, input$Year_now+as.numeric(results_list[6])),
                         zeroline=F
            ),
            yaxis = list(title=paste0(input$COC, " Concentration at <br> Monitoring Well (ug/L)"),
                         automargin = T,
                         type ='log',
                         tickvals=tval2,
                         ticktext=ttxt,
                         showline=T,
                         mirror = "ticks",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         #range = c(0, 1000),
                         zeroline=F),
            showlegend = F
          )
        
      })
      
      output$dygraph_plot1 <- renderPlotly({
        validate(need(error() != "Check Inputs", ""))
        plotlyfigureoutput()
      }) #plotly output
      
      observeEvent(input$go,{
        screenshot(filename = "Borden Tool")
      })
      
      ## Results Table -------------------------
      output$calc_output <- render_gt(align = "center", {
        # Get Values
        validate(need(error() != "Check Inputs", "Please Check Input Values"))
        cd <- results()
        results_list<-apply(cd,2,mean)
        #min_list <-apply(cd,2,min)
        max_list <-apply(cd,2,function(x) quantile(x, probs = .9))
        
        
        if (HalfLife()==0){
          cd <- data.frame(A = c('90% (1 OoM)','99% (2 OoMs)','99.9% (3 OoMs)'),
                           B = c(results_list[c(1:3)]),
                           C = c(results_list[c(4:6)]+input$Year_Removed),
                           D = c(ifelse(results_list[c(4)]+input$Year_Removed>as.numeric(format(Sys.Date(),'%Y')),
                                        as.character(round(results_list[c(4)]+input$Year_Removed-as.numeric(format(Sys.Date(),'%Y')),0)),'-'),
                                 ifelse(results_list[c(5)]+input$Year_Removed>as.numeric(format(Sys.Date(),'%Y')),
                                        as.character(round(results_list[c(5)]+input$Year_Removed-as.numeric(format(Sys.Date(),'%Y')),0)),'-'),
                                 ifelse(results_list[c(6)]+input$Year_Removed>as.numeric(format(Sys.Date(),'%Y')),
                                        as.character(round(results_list[c(6)]+input$Year_Removed-as.numeric(format(Sys.Date(),'%Y')),0)),'-')
                           ),
                           E = c(max_list[c(4:6)]-results_list[c(4:6)])
          )
          
          
        }else if (HalfLife()>0&input$BGLG!=1){
          cd <- data.frame(A = c('99% (2 OoMs)','99.9% (3 OoMs)'),
                           B = c(results_list[c(2:3)]),
                           C = c(results_list[c(5:6)])+input$Year_Removed,
                           D = c(ifelse(results_list[c(5)]+input$Year_Removed>as.numeric(format(Sys.Date(),'%Y')),
                                        as.character(round(results_list[c(5)]+input$Year_Started-as.numeric(format(Sys.Date(),'%Y')),0)),'-'),
                                 ifelse(results_list[c(6)]+input$Year_Removed>as.numeric(format(Sys.Date(),'%Y')),
                                        as.character(round(results_list[c(6)]+input$Year_Removed-as.numeric(format(Sys.Date(),'%Y')),0)),'-')
                           ),
                           E = c(max_list[c(5:6)]-results_list[c(5:6)]))
          
        }else{
          cd <- data.frame(A = c('99.9% (3 OoMs)'),
                           B = c(results_list[c(3)]),
                           C = c(results_list[c(6)])+input$Year_Removed,
                           D = c(ifelse(results_list[c(6)]+input$Year_Removed>as.numeric(format(Sys.Date(),'%Y')),
                                        as.character(round(results_list[c(6)]+input$Year_Removed-as.numeric(format(Sys.Date(),'%Y')),0)),'-')
                           ),
                           E = c(max_list[c(6)]-results_list[c(6)]))
          # cd <- data.frame(Parameters = c('A 99.9% Reduction in Concentration to …'),
          #                  ConValues = c(cd[3]),
          #                  text1 = c(' (ug/L) will occur about...'),
          #                  text2 = c('years from now.'))
        }
        
        
        cd$E<- ifelse(cd$E<1,'<1',as.character(round(cd$E)))
        
        # Create Table
        cd %>%gt()%>%
          tab_options(column_labels.hidden = FALSE)%>%
          cols_label(
            A = "Concentration Reduction",
            B = "Concentration (ug/L)",
            C = "Year Achieved",
            D = glue(" Years From Now (",format(Sys.Date(),'%Y'),")"),
            E = "Deviation of Years"
          )%>%
          #tab_header("RESULTS") %>%
          fmt_number(columns = c(2,3), rows = everything(), decimals = 0, use_seps=FALSE) %>%
          #fmt_markdown(columns = vars("Concentration Reduction", "Concentration (ug/L)","Year")) %>%
          #tab_style(style = list(cell_text(style = "italic")),
          #          locations = cells_column_labels(columns = everything())) %>%
          tab_style(style = list(cell_text(align='center')),
                    locations = list(cells_title(group = "title"),
                                     cells_body(rows = everything(), columns = c(1,2,5)))) %>%
          tab_style(style = list(cell_text(weight = "bold",color='red',align='center')),
                    locations = list(cells_title(group = "title"),
                                     cells_body(rows = everything(), columns = c(3,4)))) %>%
          opt_table_outline()
      }) # end calc_output table

      
      ## Export travel time results ---------------------
      output$selected_TT <- renderText({ 
        validate(need(!is.na(input$X) & !is.na(input$i) & !is.na(input$K), ""))
        
        if (round(input$X/input$i/(input$K*60*60*24/100)/365,0)<0.1|round(input$X/input$i/(input$K*60*60*24/100)/365,0)>30){
          paste("<H3>","Travel Time from Source to Well:", "<b>", round(input$X/input$i/(input$K*60*60*24/100)/365,0),"</b></font>"," years",
                "<BR>","Travel time is excessively [long/short] and outside acceptable range of model.","</H3>")
        }else if (round(input$X/input$i/(input$K*60*60*24/100)/365,0)>21&round(input$X/input$i/(input$K*60*60*24/100)/365,0)<30){
          paste("<H3>","Travel Time from Source to Well:", "<b>", round(input$X/input$i/(input$K*60*60*24/100)/365,0),"</b></font>"," years",
                "<BR>","Travel time to monitoring well is unusually long and outside model range.",
                "<BR>","Results may be inaccurate.","</H3>")
        }else{
          paste("<H3>","Travel Time from Source to Well:", "<b>", round(input$X/input$i/(input$K*60*60*24/100)/365,0),"</b></font>"," years","</H3>")
        }
        
      })
      
      ## Export title of plotly ---------------------
      output$selected_TT2 <- renderText({ 
        
        validate(need(error() != "Check Inputs", "Please Check Input Values"))
        results_list <- results()
        
        glue("<H3>","The monitoring well will achieve the clean-up goal of ",unique(results_list$Target_Clean_Level), " ug/L in ",
              "<font color=\"#52077F\"><b>",
              round(as.numeric(mean(results_list$Time_Cleanup))+as.numeric(input$Year_Removed),0),
              "</b></font>",".","</H3>"
              )
      })
      
      # Export Model Results and Input Values  ---------------------------
      output$model_results <- downloadHandler(
        filename = function(){
          paste("Borden_Tool_Results","xlsx",sep=".")
        },
        
        content = function(con){
          # Model Results
          cd <- results()
          # cd <-data.frame(t(cd))
          # # orca(plotlyfigureoutput(),"plot.png")
          # 
          # if (HalfLife()==0){
          #   colnames(cd) <- c('A 90% concentration reduction (ug/L)',
          #                     'A 99% concentration reduction (ug/L)',
          #                     'A 99.9% concentration reduction (ug/L)',
          #                     'Time takes a 90% concentration reduction (year)',
          #                     'Time takes a 99% concentration reduction (year)',
          #                     'Time takes a 99.9% concentration reduction (year)',
          #                     'Target clean level (ug/L)',
          #                     'Time takes to reach target clean level (ug/L)',
          #                     'Persistent_Source_Index')
          # }else if (HalfLife()>0&input$BGLG!=1){
          #   cd <-cd [,c(2,3,5,6)]
          #   colnames(cd) <- c('A 99% concentration reduction (ug/L)',
          #                     'A 99.9% concentration reduction (ug/L)',
          #                     'Time takes a 99% concentration reduction (year)',
          #                     'Time takes a 99.9% concentration reduction (year)')
          # }else{
          #   cd <-cd [,c(3,6)]
          #   colnames(cd) <- c('A 99.9% concentration reduction (ug/L)',
          #                     'Time takes a 99.9% concentration reduction (year)')
          # }

          # Create empty excel file
          wb <- createWorkbook()

          # Add Results Tab
          addWorksheet(wb, "Borden_Tool_Results")
          writeData(wb, sheet = "Borden_Tool_Results", x = cd, startCol = 1, startRow = 1, colNames = T)
          # insertImage(wb, "Borden_Tool_Results", paste0("./plot.png"),
          #             startRow = 9, startCol = 2, heigh = 864, width = 1618, units = "px")


          BGLGname <-ifelse(input$BGLG==1,'BG',ifelse(input$BGLG==2,'LG','both BG and LG'))
          HalfLifeYN_label <-ifelse(input$HalfLifeYN==1,'no','yes')
          
          # Add Parameters Tab
          x <- data.frame(
            c("Distance to Monitoring Well (m)", input$X),
            c("Hydraulic Gradient (-)", input$i),
            c("COC", input$COC),
            c("Year Source Started (year)", input$Year_Started),
            c("Year Source Removed (year)", input$Year_Removed),
            
            # step3
            c("The option for hydrogeologic setting", BGLGname),
            
            # step 4
            c("Aquifer Thickness (m)", input$Thickness),
            c("Transmissive Geology", input$HighKPorousMedia),
            c("Low-K Geology", input$LowKPorousMedia),
            c("Half Life Included", HalfLifeYN_label),
            
            #step 5&6
            c("Current Concentration at Monitoring Well", input$Concentration),
            #c("Year now (year)", input$Year_now),
            c("Target Clean-Up Level (ug/L)", input$Target_Clean_Level),
            
            #step 8
            c("Hydraulic Conductivity of Transmissive Zone (cm/s)", input$K),
            c("Effective Porosity of Transmissive Zone (-)", input$ne),
            c("Total Porosity of Low-K Zone (-)", input$n),
            c("Diffusion Coefficient of COC (cm2/s)", input$D),
            c("Tortuosity of Low-K Zone (-)", input$tortuosity_LK),
            c("Retardation Factor of Transmissive Layer (-)", input$Retardation_HK),
            c("Retardation Factor of Low-K Layer (-)", input$Retardation_LK),
            c("Fraction Organic Carbon Transmissive Layer (-)", input$foc_HK),
            c("Fraction Organic Carbon Low-K Layer (-)", input$foc_LK),
            c("Bulk Density of Transmissive Layer (kg/L)", input$Rho_HK),
            c("Bulk Density of Low-K Layer (kg/L)", input$Rho_LK),
            c("Partition Coefficient of COC (L/kg)",input$Partition_Coeff)
          )
          # print (x)
          if (BGLGname %in% c("LG","BGLG")){
            x$`Percent of thickness that is transmissive (%)` <- c("Percent of thickness that is transmissive (%)",input$Percent_T)
            x$`Number of Low-K Layers` <- c("Number of Low-K Layers",input$N)
          }

          if (input$HalfLifeYN==2){
            x$`Low-K Degradation Half-Life (year)`<- c("Low-K Degradation Half-Life (year)",input$HalfLife)
          }
          
          addWorksheet(wb, "Parameters")
          writeData(wb, sheet = "Parameters", x = x, startCol = 1, startRow = 1, colNames = F)

          saveWorkbook(wb, con)
        }
      )# end model_results
      
      #----- help function 
      lapply(
        X = 1:27,
        FUN = function(i){
          observeEvent(input[[paste0("help", i)]], {
            flname <-as.character(figure_list[i])
            Helpboxfunction(flname)
          })
        }
      )
      
      # warning message-----------
      observeEvent(input$Thickness, {
        if (input$BGLG==1 &(input$Thickness<0.5|input$Thickness>5)){
          showNotification("WARNING!!! Aquifer thickness outside model range",
                           type="warning",
                           duration=NULL)
        }else if((input$BGLG!=1 &(input$Thickness<0.5|input$Thickness>2))){
          showNotification("WARNING!!! Aquifer thickness outside model range for Layered Geometry. Please use Boundary Geometry.",
                           type="warning",
                           duration=NULL)
        }
      })
      
      observeEvent({
        input$Year_Started
        input$Year_Removed
      }, {
        if ((input$Year_Removed-input$Year_Started)<10|(input$Year_Removed-input$Year_Started)>100){
          showNotification("WARNING!!! Time between Source Started year and Source Removed year outside model range.",
                           type="warning",
                           duration=NULL)
        }
      })
      
      observeEvent(input$tortuosity_LK, {
        if (input$tortuosity_LK<0.07|input$tortuosity_LK>0.7){
          showNotification("WARNING!!! Tortuosity outside model range.",
                           type="warning",
                           duration=NULL)
        }
      })
      
      observeEvent({
        input$Retardation_HK
        input$Retardation_LK
      }, {
        if (input$Retardation_HK<1|input$Retardation_LK<1|input$Retardation_HK>10|input$Retardation_LK>10){
          showNotification("WARNING!!! [Low K/High K] retardation factor outside model range.",
                           type="warning",
                           duration=NULL)
        }
      })
      
      observeEvent(input$n, {
        if (input$n<0.15|input$n>0.5){
          showNotification("WARNING!!! Low K porosity outside model range.",
                           type="warning",
                           duration=NULL)
          }
        })
      HalfLife <-reactiveVal()
      observeEvent({
        input$HalfLife
        input$HalfLifeYN}, {
        if (input$HalfLife<0.7|input$HalfLifeYN>7000){
          showNotification("WARNING!!! Half-life outside model range.",
                           type="warning",
                           duration=NULL)
        }
        if (input$HalfLifeYN==1){
          HalfLife(0)
        }
      })
      
      ## Render Text ------------------------
      output$X_txt <- renderUI({
        req(input$X)
        HTML(paste0("<h4>Distance from Source to Monitoring Well<br>(Current Value: <b>", input$X, "</b> meters)</h4>"))
      })
      
      output$Year_Started_txt <- renderUI({
        req(input$Year_Started)
        HTML(paste0("<h4>Year Source Started <br>(Current Value: <b>", input$Year_Started, "</b>)</h4>"))
      })
      
      output$tortuosity_LK_txt <- renderUI({
        req(input$tortuosity_LK)
        HTML(paste0("<h4>Tortuosity of Low-k Zone <br>(Current Value: <b>", input$tortuosity_LK, "</b>)</h4>"))
      })
      
      output$Retardation_HK_txt <- renderUI({
        req(input$Retardation_HK)
        HTML(paste0("<h4>Retardation Factor of Transmissive Zone <br>(Current Value: <b>", input$Retardation_HK, "</b>)</h4>"))
      })
      
      output$Retardation_LK_txt <- renderUI({
        req(input$Retardation_LK)
        HTML(paste0("<h4>Retardation Factor of Low-K Zone <br>(Current Value: <b>", input$Retardation_LK, "</b>)</h4>"))
      })
      
      output$Thickness_txt <- renderUI({
        req(input$Thickness)
        HTML(paste0("<h4>Aquifer Thickness <br>(Current Value: <b>", input$Thickness, "</b> meters)</h4>"))
      })
      
      output$HalfLife_txt <- renderUI({
        req(input$HalfLife)
        HTML(paste0("<h4>Low-k Degradation Half-Life <br>(Current Value: <b>", input$HalfLife, " years</b>)</h4>"))
      })
      
      output$Percent_T_txt <- renderUI({
        req(input$Percent_T)
        HTML(paste0("<h4>Percent of Aquifer that is Transmissive <br>(Current Value: <b>", input$Percent_T, "</b> %)</h4>"))
      })
      
      output$Seep_V_txt <- renderUI({
        req(input$Seep_V)
        HTML(paste0("<h4>Seepage Velocity <br>(Current Value: <b>", input$Seep_V, "</b> m/year)</h4>"))
      })
    
    }
  )
  end.time <- Sys.time()
  print(end.time-beginning)
} # end Cleanup Goals Server 
