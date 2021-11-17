


# Cleanup Goals Modules -----------------------------

## UI -----------------------------------------
CleanupGoals_MCtabUI <- function(id, label = "03_CleanupGoals_MCtab"){
  ns <- NS(id)
  
  tabPanel("3. Clean-up Goals Monte Calro",tags$h1(tags$b("Tool 3. How long will it take to reach cleanup goals after source remediation at my site?")),
           #first fluid row
           
           fluidRow(
             tags$h4(column(12,"This is a simple Tool to estimate the number of years it will take to reduce source concentrations by 90%, 99%, 
                            or 99.9%.  The Tool was developed by Dr. Bob Borden (Broden and Cha, 2021) and is based on the REMChlor-MD model.  
                            Because this simple Tool assumes that at 100% of the source mass is removed or isolated, 
                            and because statistics show in-situ remediation is thought to be able to remove about 90% of the source mass, 
                            these remediation timeframe estimates will likely be too short compared to actual timeframes for conventional 
                            in-situ remediation projects. ")
             )),#first fluid row
           
           #second fluid row
           fluidRow( #first fluid row
             column(6,#style='border-right: 5px solid black',
                    align="left",
                    tags$head(
                      tags$style(type="text/css", "label{ display: table-cell; text-align: center; vertical-align: middle; margin-bottom:30px; text-align:left !important;} .form-group { display: table-row;} .rightAlign {float:right;}","#COC {background-color:blue;}")
                    ),
                    HTML("<h3><b>Input Data </b></h3>"),
             )# close column
           ),#step 1
           
           tabsetPanel(
             tabPanel("1. Site/Temporal Settings & COC",
                      fluidRow(style='border-top: 5px solid black', #second row
                               column(12,
                                      tags$i(h4("Enter specific parameters below or use buttons to upload data (requires use of template file):")),
                                      fluidRow(column(3,HTML("Choose Input File"),
                                                      fileInput(ns("file"), label = "",
                                                                multiple = F,
                                                                accept = c("text/xlsx",
                                                                           "text/comma-separated-values,text/plain",
                                                                           ".xlsx"), 
                                                                width = "200px")),
                                               column(3,actionButton(ns("update_inputs"), HTML("Update Input Values<br>from Input File"), style=button_style),
                                                      HTML("<i>Will reset all input values.</i>"),)),
                                      #("data_template", "Download Data Template File"),
                                      #actionButton("upload_data", "Upload Data"),
                               )),
                      fluidRow(style='text-align: right',
                               column(6, align = "center", 
                                      #HTML("<h5><b>Input Data</b></h3>"),
                                      
                                      # tags$i(h4("Enter specific parameters below or use buttons to upload data (requires use of template file):")),
                                      # 
                                      # fluidRow(
                                      # column(3, actionButton("model_results", "Download Data Template File")),
                                      # column(3, actionButton("model_results", "Upload Data")),
                                      # ),
                                      
                                      br(),
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("X"),"Distance from Source to Monitoring Well (meters):  ", 
                                                                   value=28.8, min = 0, step = 0.01, width = "400px")),
                                               column(5,align = "left",
                                                      actionButton(ns("help1"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("i"),"Hydraulic Gradient (-):  ", 
                                                                   value=0.001, min = 0, step = 0.00001, width = "400px")),
                                               column(5,align = "left",
                                                      actionButton(ns("help2"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      fluidRow(column(7,align = "right",
                                                      
                                                      selectInput(ns("COC"),label = "Constituent of Concern:  ",
                                                                  choices = c(sort(unique(Constituents$`Constituents Name`))),
                                                                  selected = "TCE",multiple = F, selectize =FALSE, width = "400px")
                                      ),
                                      column(5,align = "left",
                                             actionButton(ns("help3"), HTML("?"), style=button_style2),
                                             br(),br())
                                      ), #fluidrow
                                      fluidRow(column(12,align='right',
                                                      conditionalPanel(condition = "input.COC==`***User specified***`",ns = ns,
                                                                       tags$i(h4("Assign values in Diffusion Coefficient and Partition Coefficient under Tab 3"),
                                                                              style = "color: rgb(0,166,90)")
                                                      )# end conditional panel
                                      )
                                      ),
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Year_Started"),"Year Source Started:  ", 
                                                                   value=1978, min = 1500, width = "400px")),
                                               column(5,align = "left",
                                                      actionButton(ns("help4"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow 
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Year_Removed"),"Year Source Removed:  ", 
                                                                   value=2020, min = 1500, width = "400px")),
                                               column(5,align = "left",
                                                      actionButton(ns("help5"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Concentration"),"Concentration of COC Befoure Source Removed (ug/L):  ",
                                                                   value=1000, min = 0, step = 0.01, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help6"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      br()
                               ),#end column
                               column(6, align = "center",
                                      #HTML("<h3><b>Input Data</b></h3>"),
                                      img(src = "./03_CleanupGoals/BordenToolKit_Pic_2-1.png",
                                          width = "500px", height = "300px"),
                                      br(),br(),br()
                               ))#end column
                      #), #end of step 2 fluid row
             ), #first tabpanel
             
             tabPanel("2. Select Scenario & Hydrologic Setting",
                      fluidRow( style='border-top: 5px solid black',#third row      
                                column(12, align="center",
                                       HTML("<h3><b>Select the hydrogeologic setting that best matches your site: </b></h3>"),
                                       tags$style(HTML(".radio {margin-top: 75px;margin-bottom: 75px;}"))
                                ) # end of columns
                      ),#end of first fluid row
                      
                      
                      fluidRow(style="text-align: right",# second fluid row
                               column(3,
                               ),# column end
                               column(1,align="right",
                                      radioButtons(ns("BGLG"), h3(" "),
                                                   choices = list("Setting 1 Aquifer with aquitard (either below, above, or both)" = 1, 
                                                                  "Setting 2 Aquifer with no aquitard but layers/lenses" = 2,
                                                                  "Setting 3 Aquifer with both aquitard and layers/lenses" = 3
                                                   ),selected = 1, inline = FALSE)
                               ),# column end
                               column(2,
                                      fluidRow(
                                        column(12,align="left",
                                               #conditionalPanel(
                                               # condition = "input.BGLG==1",ns = ns,
                                               img(src = "./03_CleanupGoals/BordenToolKit_BG_Pic_2-2.png",
                                                   width = "250px", height = "150px"),
                                               br(),br()
                                               #)# conditional Panel closed
                                        )# column
                                      ),#fluidrow
                                      #("<h3><b>--------------------- OR --------------------</b></h3>"),
                                      fluidRow( column(12,align="left",
                                                       #conditionalPanel(
                                                       #  condition = "input.BGLG==2",ns=ns,
                                                       img(src = "./03_CleanupGoals/BordenToolKit_LG_Pic_2-3.png",
                                                           width = "250px", height = "150px"),
                                                       br(),br()
                                                       #)# conditional Panel closed
                                      )#column
                                      ),#fluidrow
                                      #HTML("<h3><b>--------------------- OR --------------------</b></h3>"),
                                      fluidRow( column(12,align="left",
                                                       #conditionalPanel(
                                                       #  condition = "input.BGLG==3",ns=ns,
                                                       img(src = "./03_CleanupGoals/BordenToolKit_BGLG_Pic_2-4.png",
                                                           width = "250px", height = "150px"),
                                                       br()
                                                       #)# conditional Panel closed
                                      )#column
                                      )#fluidrow
                               ),#column end
                               column(6,align="center",
                                      #HTML("<h3><b>Step 4. Enter Dataset 2 </b></h3>"),
                                      fluidRow(
                                        column(12,align="center",
                                               conditionalPanel(
                                                 condition = "input.BGLG==1|input.BGLG==2|input.BGLG==3",ns = ns,
                                                 HTML("<h3><b> For All Scenarios </b></h3>"),
                                                 fluidRow(column(7,align = "right",
                                                                 numericInput(ns("Thickness"),"Aquifer Thickness (meters):  ", value=5, min = 0, width = "400px")),
                                                          column(5,align = "left",
                                                                 actionButton(ns("help7"), HTML("?"), style=button_style2),
                                                                 br(),br())
                                                 ), #fluidrow
                                                 
                                                 fluidRow(column(7,align = "right",
                                                                 selectInput(ns("HighKPorousMedia"),label = "Transmissive Zone Soil Type:  ",
                                                                             choices = c(sort(unique(TZ_Soil_Type$Soil_Type))),
                                                                             selected = "Sand",multiple = F, selectize =FALSE, width = "400px")),
                                                          column(5,align = "left",
                                                                 actionButton(ns("help8"), HTML("?"), style=button_style2),
                                                                 br(),br())
                                                 ), #fluidrow
                                                 
                                                 fluidRow(column(7,align = "right",
                                                                 selectInput(ns("LowKPorousMedia"),label = "Low-k Soil Type:  ",
                                                                             choices = c(sort(unique(LowK_Soil_Type$Soil_Type))),
                                                                             selected = "Clay",multiple = F, selectize =FALSE, width = "400px")),
                                                          column(5,align = "left",
                                                                 actionButton(ns("help9"), HTML("?"), style=button_style2),
                                                                 br(),br())
                                                 ), #fluidrow
                                                 
                                                 fluidRow(column(7,align = "right",
                                                                 radioButtons(ns("HalfLifeYN"), h3(" "),
                                                                              choices = list("Do Not Include Low-k Degradation" = 1, 
                                                                                             "Include Low-k Degradation" = 2
                                                                              ),selected = 1, inline = TRUE)),
                                                          column(5,align = "left",
                                                                 actionButton(ns("help10"), HTML("?"), style=button_style2),
                                                                 br(),br())
                                                 ), #fluidrow
                                                 
                                                 conditionalPanel(
                                                   condition = "input.HalfLifeYN==2",ns=ns,
                                                   fluidRow(column(7,align = "right",
                                                                   numericInput(ns("HalfLife"),"Low-k Degradation Half-Life (years):  ", 
                                                                                value=100, min = 0, width = '100px')),
                                                            column(5,align = "left",
                                                                   actionButton(ns("help11"), HTML("?"), style=button_style2),
                                                                   br(),br())
                                                   ), #fluidrow
                                                   br(),br())
                                               )# conditional Panel closed
                                        )#column end
                                      ),#fluidrow
                                      fluidRow(
                                        column(12,align="center",
                                               conditionalPanel(
                                                 condition = "input.BGLG==2|input.BGLG==3",ns=ns,
                                                 HTML("<h3><b> For Layer/Lenses Scenarios </b></h3>"),
                                                 #numericInput(ns("Thickness2"),"Thickness (meter):  ", value=4.92, min = 0, width = '100px'),
                                                 #selectInput(ns("HighKPorousMedia2"),label = "Transmissive Geology:  ",choices = c(sort(unique(TZ_Soil_Type$Soil_Type))),
                                                 #            selected = "Sand",multiple = F),
                                                 #selectInput(ns("LowKPorousMedia2"),label = "Low K Geology:  ",choices = c(sort(unique(LowK_Soil_Type$Soil_Type))),
                                                 #            selected = "Clay",multiple = F),
                                                 #numericInput(ns("HalfLife2"),"Low-k Degradation Half-Life (years):  ", value=0, min = 0, width = '100px'),
                                                 fluidRow(column(7,align = "right",
                                                                 numericInput(ns("Percent_T"),"Percent of B that is Transmissive (%):  ", 
                                                                              value=87.5, min = 0, width = '100px')),
                                                          column(5,align = "left",
                                                                 actionButton(ns("help12"), HTML("?"), style=button_style2),
                                                                 br(),br())
                                                 ), #fluidrow
                                                 
                                                 fluidRow(column(7,align = "right",
                                                                 numericInput(ns("N"),"Number of Low-k Layers (-):  ", 
                                                                              value=2, min = 0, width = '100px')),
                                                          column(5,align = "left",
                                                                 actionButton(ns("help13"), HTML("?"), style=button_style2),
                                                                 br(),br())
                                                 ), #fluidrow
                                                 br(),br()
                                               )# conditional Panel closed
                                        )#column
                                      )#fluid row
                               )#third column end )
                      ),# second column end 
                      
                      #)), # end of second fluid row
             ), #hydrologic tab panel
             
             
             
             tabPanel("3. (Optional) Site-Specific Parameters",
                      fluidRow(style='border-top: 5px solid black',# fifth fluid row
                               column(7,align="center",
                                      #HTML("<h3><b>Step 8. (Optional) Fine-Tune Parameters if Site-Specific Data are available </b></h3>"),
                                      #br(),
                                      br(),
                                      HTML("<h4><b><i>Hydrogeology Parameters</i></b></h4>"),
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("K"),"Hydraulic Conductivity of Transmissive Zone (cm/s):  ", value=0.032, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help14"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("ne"),"Effective Porosity of Transmissive Zone (-):  ", value=0.25, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help15"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("n"),"Total Porosity of Low-k Zone (-):  ", value=0.43, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help16"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      br(),
                                      HTML("<h4><b><i>Diffusion Parameters</i></b></h4>"),
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("D"),"Diffusion Coefficient of COC at 20°C (cm²/s):  ", value=9.1*10**(-6), min = 0, step = 0.000001,width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help18"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("tortuosity_LK"),"Tortuosity of Low-k Zone (-):  ", value=0.7, min = 0.07,max=0.7, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help19"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      br(),
                               ),
                               column(5,align="center",
                                      br(),
                                      HTML("<h4><b><i>Retardation Parameters</i></b></h4>"),
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("foc_HK"),"Fraction Organic Carbon Transmissive Zone (-):  ", value=0.001, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help20"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("foc_LK"),"Fraction Organic Carbon Low-K Zone (-):  ", value=0.002, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help21"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Rho_HK"),"Bulk Density of Transmissive Zone kg/mL):  ", value=1.7, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help22"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Rho_LK"),"Bulk Density of Low-K Zone (g/mL):  ", value=1.7, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help23"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Retardation_HK"),"Retardation Factor of Transmissive Zone (-):  ", value=1.632, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help24"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Retardation_LK"),"Retardation Factor of Low-k Zone (-):  ", value=1.753, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help25"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      
                                      fluidRow(column(7,align = "right",
                                                      numericInput(ns("Partition_Coeff"),"Partition Coefficient of COC (mL/g):  ", value=93.3, min = 0, width = '100px')),
                                               column(5,align = "left",
                                                      actionButton(ns("help26"), HTML("?"), style=button_style2),
                                                      br(),br())
                                      ), #fluidrow
                                      br()) #column
                      )# end of fifth fluidrow
                      
             )
             
             
           ), #tabset panel
           
           #fourth fluid row
           fluidRow(style='border-top: 5px solid black',
                    #style='border-right: 5px solid black',
                    column(6, align="left",
                           HTML("<h3><b>Results</b></h3>"),
                           HTML("<h4><b>1. See Timeframe to Reduce Plume Concentrations by 90%, 99%, and 99.9%</b></h4>"),
                           
                           # fluidRow(column(7,align = "right",
                           #                 numericInput(ns("Year_now"),"Year now: ",
                           #                              value=2020, min = 1500, step = 1, width = '100px')),
                           #          column(5,align = "left",
                           #                 actionButton(ns("help1"), HTML("?"), style=button_style2),
                           #                 br(),br())
                           # ), #fluidrow
                           #br(),
                           #HTML("<p>Then: </p>"),
                           br(),
                           gt_output(ns("calc_output")),
                           br(),
                           htmlOutput(ns("selected_TT")),
                           HTML("<h3><b> Save and/or Print </b></h3>"),
                           downloadButton(ns("model_results"), HTML("Export Model Results and Input Tables"), style=button_style),
                           actionButton(ns("go"), HTML("Export Screen Shot"), style=button_style)
                           #actionButton("save_results", "Save Numerical Results")
                           
                    ), #column
                    column(6, 
                           br(), br(),
                           HTML("<h4><b>2. See Approximate Timeframe to a Reach Clean-up Goal (optional) </b></h4>"),
                           fluidRow(column(7,align = "right",
                                           numericInput(ns("Target_Clean_Level"),"Target Clean-up Level (ug/L):  ",
                                                        value=5, min = 0, step = 0.01, width = '100px')),
                                    column(5,align = "left",
                                           actionButton(ns("help27"), HTML("?"), style=button_style2))
                           ), #fluidrow
                           br(),
                           # gt_output(ns("selected_var")),
                           # br(),
                           #htmlOutput(ns("selected_TT2")),
                           conditionalPanel(
                             condition = "input.HalfLifeYN==1",ns=ns,
                             plotlyOutput(ns("dygraph_plot1"), height = 500)
                           )# conditional panel
                    ) # end of columns
           ) #fluid row step 6
           
  ) #tabpanel
  
} # end Cleanup Goals UI  







## Server -------------------------------------
CleanupGoals_MCtabServer <- function(id) {
  beginning <- Sys.time()
  moduleServer(
    id,
    
    function(input, output, session) {
      
      
      ## Function to Filter data -------------
      cd_get <- reactive({
        #---- Step1: Enter Data Set 1
        
        set.seed(1111)
        A <- randomLHS(1000,5) 
        
        X <-rtri(A[,1], input$X*0.5,input$X*1.5,input$X)#distance from souce (m)
        i <-rtri(A[,2], input$i*0.5,input$i*1.5,input$i)#Hydraulic Gradient (-)
        chem = input$COC #constituents
        Year_Started =input$Year_Started
        Year_Removed = input$Year_Removed
        
        K = input$K/100*60*60*24  # cm/s to meter/day
        
        ne <-rtri(A[,3], input$ne*0.5,input$ne*1.5,input$ne)
        n <-rtri(A[,4], input$n*0.5,input$n*1.5,input$n)
        D <-rtri(A[,5], input$D*0.5,input$D*1.5,input$D)
        # ne = input$ne
        # n = input$n
        # D = input$D
        tortuosity_LK = input$tortuosity_LK
        Retardation_HK = input$Retardation_HK
        Retardation_LK = input$Retardation_LK
        Concentration = input$Concentration
        Target_Clean_Level = input$Target_Clean_Level
        #Year_now = input$Year_now
        BGLG = input$BGLG 
        
        print (Year_Removed)
        
        # output$HalfLife1 <- renderUI({
        #   val <- Year_Removed - Year_Started
        #   ns <- session$ns
        #   numericInput(ns("HalfLife"),"Low-k Degradation Half-Life (years):  ", value=0, min = 0, max = val, width = '100px')
        # })
        if (input$HalfLifeYN==1){
          HalfLife=0
        }else{
          HalfLife =input$HalfLife          
        }
        
        #---- Step2: Pick Either Boundary Geometry or Layered Geometry
        if (input$BGLG==1){
          type = 'BG'
          Thickness = input$Thickness
          HighKPorousMedia = input$HighKPorousMedia
          LowKPorousMedia = input$LowKPorousMedia
          HalfLife =0
        }else if(input$BGLG==2){
          type='LG'
          Thickness = input$Thickness
          HighKPorousMedia = input$HighKPorousMedia
          LowKPorousMedia = input$LowKPorousMedia
          HalfLife =HalfLife()
          Percent_T = input$Percent_T
          N = input$N
        }else{
          type='BGLG'
          # for BG
          Thickness = input$Thickness
          HighKPorousMedia = input$HighKPorousMedia
          LowKPorousMedia = input$LowKPorousMedia
          HalfLife =HalfLife()
          Percent_T = input$Percent_T
          N = input$N
        }
        
        #---- Step3: Enter Geology Data
        
        # calculation of BG
        if (type %in% c("BG",'BGLG')){
          
          B = Thickness #1.5*3.28  #ft depth to low permeability zone
          
          #HalfLife = 0# years
          
          #---- Step 4: Input Values (Edit/Enter Values)
          
          # Hydrogeology Parameters  %%% need to check HK, ne, and n
          TG = HighKPorousMedia # transmissive geology
          LG = LowKPorousMedia # low K geology
          
          HK = HK()#HK = TZ_Soil_Type$`Hydraulic Conductivity [ft/d]`[TZ_Soil_Type$Soil_Type==TG] # Hydraulic Conductivity of Transmissive Zone#850.393700787401#0.0920044444444444/12/2.54*86400#
          LK = LowK_Soil_Type$`Hydraulic Conductivity [cm/s]`[LowK_Soil_Type$Soil_Type==LG]/100*60*60*24 # Hydraulic Conductivity of Low-k Zone convert to meter per day
          
          ne = ne() #TZ_Soil_Type$`Effective Porosity [-]`[TZ_Soil_Type$Soil_Type==TG] # Effective Porosity of Transmissive Zone 0.225
          n = n() #LowK_Soil_Type$`Porosity [-]`[LowK_Soil_Type$Soil_Type==LG] # Total Porosity of Low-k Zone 0.4#
          
          # Diffusion parameter  %%% need to check D and tortuosity
          D = D()# Constituents$`Diffusion Coefficient[cm2/sec]`[Constituents$`Constituents Name`==chem]*100*100*1000/365/24/60/60#Diffusion Coefficient cm2/s 0.00000285#
          tortuosity_LK = tortuosity_LK#0.77*(LK/3.28084/86400)**0.04#Tortuosity of Low-k zone 1
          
          # Retardation Parameters
          FOC_HK = input$foc_HK #0 # Fraction Organic Carbon Transmissive Zone
          FOC_LK = input$foc_LK #0 # Fraction Organic Carbon Low-k Zone
          Bulk_Density_HK = input$Rho_HK #1.7 # Bulk Density of Transmissive Zone
          Bulk_Density_LK = input$Rho_LK #1.7 # Bulk Density of Low-k Zone
          #Retardation_HK = 1.6 # Retardation Factor of Transmissive Zone
          #Retardation_LK =3.9 # Retardation Factor of Low-k Zone
          KOC = KOC()#constituents$`Partition Coefficient of Constituent Koc [L/kg]`[Constituents$`Constituents Name`==chem] # partition coefficient of constituent
          
          
          #---- Step 5: RESULTS.  See Timeframe to Reduce Plume Concentrations by 90%, 99%, and 99.9%.
          
          #Concentration = 1000 # Enter the Concentration of the COC at the Monitoring Well Now (ug/L)
          #Target_Clean_Level = 5 # Target Clean-up Level
          #Year_now = 2020
          
          OM1 = Concentration*0.1 # A 90% Reduction in Concentration (1 Order of Magnitude) to …
          OM2 = Concentration*0.01 # A 99% Reduction in Concentration (2 Order of Magnitude) to …
          OM3 = Concentration*0.001 # A 99.9% Reduction in Concentration (3 Order of Magnitude) to …
          
          
          
          #---- Step6: Calculation in the Background
          X_m = X #meter
          Kave = HK      # convert from cm/s to m/day 
          Q = Kave*i*B*365 #convert to m2/day to m2/yr
          K_m = HK*365 #convert from m/day to m/yr
          D_new = D*tortuosity_LK*(365*24*60*60)/10000 #convert to cm2/s to m2
          
          TL = Year_Removed -Year_Started
          
          
          Tt = (X_m*ne)/(K_m*i)
          TH = X_m*(ne*B+n*(4.52*TL*D_new/Retardation_LK)^0.5)/(B*K_m*i)
          TM =X_m*(Retardation_HK*ne*B+n*(4.52*TL*D_new*Retardation_LK)^0.5)/(B*K_m*i)
          PVH = X_m*ne*B
          PVL =X_m*n*(4.52*TL*D_new/Retardation_LK)^0.5
          
          Alpha =((4.52*TL*D_new/Retardation_LK)^0.5)/(B)
          Beta = (n*(4.52*TL*D_new/Retardation_LK)^0.5)/(ne*B)
          ceta =(n*(4.52*TL*D_new*Retardation_LK)^0.5)/(Retardation_HK*ne*B)
          
          #LD =(4.52*TL*D_new/Retardation_LK)^0.5
          #TD =(Retardation_LK*LD^2)/(4*D_new)
          
          #coefficient filter by either BG or LG
          coeff <-Parameters%>%filter(Style=='BG')
          lnT1 = exp(coeff$lnT1[1]+coeff$lnT1[2]*log(TM)+coeff$lnT1[3]*log(Beta))
          lnT2 = exp(coeff$lnT2[1]+coeff$lnT2[2]*log(TM)+coeff$lnT2[3]*log(Beta))
          lnT3 = exp(coeff$lnT3[1]+coeff$lnT3[2]*log(TM)+coeff$lnT3[3]*log(Beta))
          
          #---- Step7: Results Calculation
          T1 = lnT1 - (Year_Removed -Year_Removed)
          T2 = lnT2 - (Year_Removed -Year_Removed)
          T3 = lnT3 - (Year_Removed -Year_Removed)
          
          # half life implementation
          if (HalfLife>0){
            CTR1 =  exp(coeff$lnT1[4]+coeff$lnT1[5]*log(0.693/HalfLife*TL))
            CTR2 =  exp(coeff$lnT2[4]+coeff$lnT2[5]*log(0.693/HalfLife*TL))
            CTR3 =  exp(coeff$lnT3[4]+coeff$lnT3[5]*log(0.693/HalfLife*TL))
            print (CTR1,CTR2,CTR3)
            T1 = T1*CTR1
            T2 = T2*CTR2
            T3 = T3*CTR3
          }
          
          OoM = round(log10(1-((1-Concentration/Target_Clean_Level)*100)/100),3)
          if (OoM>=1&OoM<=3){
            A = log(T1+(Year_Removed -Year_Removed))
            B = log(T2+(Year_Removed -Year_Removed))
            C = log(T3+(Year_Removed -Year_Removed))
            X1 = c(1,2,3)
            X2 = c(1,4,9)
            
            Y = data.frame(A,B,C)
            Time_Cleanup = c()
            for (k in c(1:nrow(Y))){
              Y_1 <- as.list(as.data.frame(t(Y[k,])))[[1]]
              coef = summary(lm(Y_1~X1+X2))
              C1 = coef$coefficients[1]
              C2 = coef$coefficients[2]
              C3 = coef$coefficients[3]
              Time_Cleanup_1 = - (Year_Removed -Year_Removed) + exp(C1 + C2*OoM+ C3*OoM**2)
              Time_Cleanup = append(Time_Cleanup,Time_Cleanup_1)
            }
            # Y = c(A,B,C)
            # coef = summary(lm(Y~X1+X2))
            # C1 = coef$coefficients[1]
            # C2 = coef$coefficients[2]
            # C3 = coef$coefficients[3]
            # Time_Cleanup = - (Year_Removed -Year_Removed) + exp(C1 + C2*OoM+ C3*OoM**2)
          }else{
            Time_Cleanup=NA
          }
          results_list1 = data.frame(OM1,OM2,OM3,T1,T2,T3,Target_Clean_Level,Time_Cleanup)
          
        }
        
        if (type %in% c("LG",'BGLG')){
          
          # Layered Geometry
          B =Thickness #9.84 #thickness of total layer
          #Percent_T = Parcent_T #% Percent of B that is Transmissive
          #N = input$N #N umber of Low-k Layers (N)
          TG = HighKPorousMedia # transmissive geology
          LG = LowKPorousMedia # low K geology
          HalfLife = HalfLife()#input$HalfLife# years
          
          #---- Step 4: Input Values (Edit/Enter Values)
          
          # Hydrogeology Parameters  %%% need to check HK, ne, and n
          HK = HK()#TZ_Soil_Type$`Hydraulic Conductivity [ft/d]`[TZ_Soil_Type$Soil_Type==TG] # Hydraulic Conductivity of Transmissive Zone 850.393700787401#0.0920044444444444/12/2.54*86400#
          LK = LowK_Soil_Type$`Hydraulic Conductivity [cm/s]`[LowK_Soil_Type$Soil_Type==LG]/100*60*60*24 # Hydraulic Conductivity of Low-k Zone conver to meter per day
          ne = ne()#TZ_Soil_Type$`Effective Porosity [-]`[TZ_Soil_Type$Soil_Type==TG] # Effective Porosity of Transmissive Zone 0.225#
          n = n()#LowK_Soil_Type$`Porosity [-]`[LowK_Soil_Type$Soil_Type==LG] # Total Porosity of Low-k Zone 0.4#
          
          # Diffusion parameter  %%% need to check D and tortuosity
          D = D()#Constituents$`Diffusion Coefficient[cm2/sec]`[Constituents$`Constituents Name`==chem]*100*100*1000/365/24/60/60# 0.00000285#Diffusion Coefficient cm2/s
          tortuosity_LK = 0.77*(LK/86400)**0.04#Tortuosity of Low-k zone 1
          
          # Retardation Parameters
          FOC_HK = input$foc_HK #0 # Fraction Organic Carbon Transmissive Zone
          FOC_LK = input$foc_LK #0 # Fraction Organic Carbon Low-k Zone
          Bulk_Density_HK = input$Rho_HK #1.7 # Bulk Density of Transmissive Zone
          Bulk_Density_LK = input$Rho_LK #1.7 # Bulk Density of Low-k Zone
          KOC = KOC()#Constituents$`Partition Coefficient of Constituent Koc [L/kg]`[Constituents$`Constituents Name`==chem] # partition coefficient of constituent
          
          
          #---- Step 5: RESULTS.  See Timeframe to Reduce Plume Concentrations by 90%, 99%, and 99.9%.
          OM1 = Concentration*0.1 # A 90% Reduction in Concentration (1 Order of Magnitude) to …
          OM2 = Concentration*0.01 # A 99% Reduction in Concentration (2 Order of Magnitude) to …
          OM3 = Concentration*0.001 # A 99.9% Reduction in Concentration (3 Order of Magnitude) to …
          
          
          
          #---- Step6: Calculation in the Background
          X_m = X #convert from ft to meter
          Kave = Percent_T/100*HK
          Q = Kave*i*B*365 #convert to m2/day to ft2/yr
          K_m = HK*365 #convert from m/day to m/yr
          D_new = D*tortuosity_LK*(365*24*60*60)/10000 #convert to cm2/s to m2
          
          TL = Year_Removed -Year_Started
          Tt = (X_m*ne)/(K_m*i)
          TH = X_m*(ne*Percent_T/100+n*(1-Percent_T/100))/(K_m*Percent_T/100*i)
          TM =X_m*(Retardation_HK*ne*Percent_T/100+Retardation_LK*n*(1-Percent_T/100))/(K_m*Percent_T/100*i)
          PVH = X_m*ne*B*Percent_T/100
          PVL =X_m*n*B*(1-Percent_T/100)
          
          Alpha =(1-Percent_T/100)/(Percent_T/100)
          Beta =(1-Percent_T/100)*n/((Percent_T/100)*ne)
          ceta =Retardation_LK*(1-Percent_T/100)*n/(Retardation_HK*Percent_T/100*ne)
          
          LD = B*(1-Percent_T/100)/N/2
          TD = (Retardation_LK*LD**2)/(4*D_new)
          
          #coefficient filter by either BG or LG
          coeff <-Parameters%>%filter(Style=='LG')
          lnT1 = exp(coeff$lnT1[1]+coeff$lnT1[2]*log(TM)+coeff$lnT1[3]*log(TD))
          lnT2 = exp(coeff$lnT2[1]+coeff$lnT2[2]*log(TM)+coeff$lnT2[3]*log(TD))
          lnT3 = exp(coeff$lnT3[1]+coeff$lnT3[2]*log(TM)+coeff$lnT3[3]*log(TD))
          #---- Step7: Results Calculation
          T1 = lnT1 - (Year_Removed -Year_Removed)
          T2 = lnT2 - (Year_Removed -Year_Removed)
          T3 = lnT3 - (Year_Removed -Year_Removed)
          
          # half life implementation
          if (HalfLife>0){
            CTR1 =  exp(coeff$lnT1[4]+coeff$lnT1[5]*log(0.693/HalfLife*TD))
            CTR2 =  exp(coeff$lnT2[4]+coeff$lnT2[5]*log(0.693/HalfLife*TD))
            CTR3 =  exp(coeff$lnT3[4]+coeff$lnT3[5]*log(0.693/HalfLife*TD))
            print (CTR1,CTR2,CTR3)
            T1 = T1*CTR1
            T2 = T2*CTR2
            T3 = T3*CTR3
          }
          
          OoM = round(log10(1-((1-Concentration/Target_Clean_Level)*100)/100),3)
          if (OoM>=1&OoM<=3){
            A = log(T1+(Year_Removed -Year_Removed))
            B = log(T2+(Year_Removed -Year_Removed))
            C = log(T3+(Year_Removed -Year_Removed))
            X1 = c(1,2,3)
            X2 = c(1,4,9)
            Y = data.frame(A,B,C)
            Time_Cleanup = c()
            for (k in c(1:nrow(Y))){
              Y_1 <- as.list(as.data.frame(t(Y[k,])))[[1]]
              coef = summary(lm(Y_1~X1+X2))
              C1 = coef$coefficients[1]
              C2 = coef$coefficients[2]
              C3 = coef$coefficients[3]
              Time_Cleanup_1 = - (Year_Removed -Year_Removed) + exp(C1 + C2*OoM+ C3*OoM**2)
              Time_Cleanup = append(Time_Cleanup,Time_Cleanup_1)
            }
            # Y = c(A,B,C)
            # coef = summary(lm(Y~X1+X2))
            # C1 = coef$coefficients[1]
            # C2 = coef$coefficients[2]
            # C3 = coef$coefficients[3]
            # Time_Cleanup = - (Year_Removed -Year_Removed) + exp(C1 + C2*OoM+ C3*OoM**2)
          }else{
            Time_Cleanup=NA
          }
          results_list2 = data.frame(OM1,OM2,OM3,T1,T2,T3,Target_Clean_Level,Time_Cleanup)
        }
        
        Persistent_Source_Index = ifelse(is.na(Time_Cleanup),"N/A",
                                         ifelse(Time_Cleanup<=20,1,
                                                ifelse(Time_Cleanup<=30,2,
                                                       ifelse(Time_Cleanup<=40,3,
                                                              ifelse(Time_Cleanup<=50,4,
                                                                     ifelse(Time_Cleanup<=60,5,
                                                                            ifelse(Time_Cleanup<=70,6,
                                                                                   ifelse(Time_Cleanup<=80,7,
                                                                                          ifelse(Time_Cleanup<=90,8,
                                                                                                 ifelse(Time_Cleanup<=100,9,10))))))))))
        
        if (type=='BG'){
          results_list = results_list1
        }else if(type=='BGLG'){
          results_list = pmax(results_list1,results_list2)
        }else{
          results_list = results_list2
        }
        
        results_list$Persistent_Source_Index = Persistent_Source_Index
        results_list

        
      }) # cd_get
      
      
      #-------- update the values when it's get changes
      observeEvent({input$HighKPorousMedia
        input$LowKPorousMedia
        input$COC
        input$HalfLife
        input$Year_Removed
        input$Year_Started
        input$Rho_HK
        input$Rho_LK
        input$Partition_Coeff
        input$foc_HK
        input$foc_LK
        input$n
        input$ne},{
          
          
          chem <-input$COC
          # BG case
          TG<-input$HighKPorousMedia
          LG<-input$LowKPorousMedia
          LK <-LowK_Soil_Type$`Hydraulic Conductivity [cm/s]`[LowK_Soil_Type$Soil_Type==LG]/100*60*60*24
          HK = TZ_Soil_Type$`Hydraulic Conductivity [cm/s]`[TZ_Soil_Type$Soil_Type==TG]/100*60*60*24
          ne = TZ_Soil_Type$`Effective Porosity [-]`[TZ_Soil_Type$Soil_Type==TG] # Effective Porosity of Transmissive Zone 0.225
          n = LowK_Soil_Type$`Porosity [-]`[LowK_Soil_Type$Soil_Type==LG] # Total Porosity of Low-k Zone 0.4#
          D = Constituents$`Diffusion Coefficient[cm2/sec]`[Constituents$`Constituents Name`==chem]#Diffusion Coefficient cm2/s 0.00000285#
          tortuosity_LK = 0.77*(LK/86400)**0.04#Tortuosity of Low-k zone 1
          KOC = Constituents$`Partition Coefficient of Constituent Koc [L/kg]`[Constituents$`Constituents Name`==chem] # partition coefficient of constituent
          Retardation_LK = 1+input$Partition_Coeff*input$foc_LK*input$Rho_LK/input$n
          Retardation_HK = 1+input$Partition_Coeff*input$foc_HK*input$Rho_HK/input$ne
          
          updateNumericInput(session, "K", value = signif(HK*100/60/60/24,3))
          updateNumericInput(session, "ne", value = round(ne,2))
          updateNumericInput(session, "n", value = round(n,2))
          updateNumericInput(session, "D", value = round(D,8))
          updateNumericInput(session, "tortuosity_LK", value =round(tortuosity_LK,2))
          updateNumericInput(session, "Partition_Coeff", value = round(KOC,0))
          updateNumericInput(session, "Retardation_HK", value = signif(Retardation_HK,3))
          updateNumericInput(session, "Retardation_LK", value = signif(Retardation_LK,3))
          #numVal <-ifelse(input$HalfLife >(input$Year_Removed - input$Year_Started),input$Year_Removed - input$Year_Started,input$HalfLife)
          #updateNumericInput(session, "HalfLife", value = numVal,max = 50)
        })
      
      
      # -------------update input based on the loaded file
      observeEvent(input$update_inputs,{
        
        # If no file is loaded use deaf
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
      
      ###############################
      
      HK <- reactiveVal()
      n <- reactiveVal()
      D <- reactiveVal()
      ne <- reactiveVal()
      tortuosity_LK <- reactiveVal()
      KOC <-reactiveVal()
      HalfLife <-reactiveVal()
      Retardation_HK <-reactiveVal()
      Retardation_LK <-reactiveVal()
      Partition_Coeff <- reactiveVal()
      
      observeEvent({input$K
        input$HighKPorousMedia
        input$n
        input$ne
        input$D
        input$tortuosity_LK
        input$HalfLife
        input$HalfLifeYN
        input$Retardation_HK
        input$Retardation_LK
        input$Partition_Coeff
      },{
        HK(input$K/100*60*60*24)
        n(input$n)
        ne(input$ne)
        D(input$D)
        tortuosity_LK(input$tortuosity_LK)
        KOC(input$Partition_Coeff)
        Retardation_HK(input$Retardation_HK)
        Retardation_LK(input$Retardation_LK)
        Partition_Coeff(input$Partition_Coeff)
        if (input$HalfLifeYN==1){
          HalfLife(0)
        }else{
          HalfLife(input$HalfLife)
        }
        # updateNumericInput(session, "K", value = HK)
        print ('halflife')
        print (HalfLife())
      })
      
      observeEvent(input$go,{
        screenshot(filename = "Borden Tool")
      })

      
      
      #------------export table      
      output$calc_output <- render_gt(align = "left", {
        # Get Values
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

     
 #----------------- figure output     
      plotlyfigureoutput <- reactive({
        results_list_all = cd_get()
        #print ('result')
        #print (results_list_all)
        results_list<-apply(results_list_all,2,mean)
        min_list <-apply(results_list_all,2,min)
        max_list <-apply(results_list_all,2,max)
        #print (results_list)
        #print (min_list)
        #print (max_list)
        cd_1 <- data.frame(time = c(0,round(sort(results_list[c(4:6,8)]),0)),
                           Concentration=c(1000,#input$Concentration,
                                           sort(results_list[c(1:3,7)],decreasing=TRUE)))
        cd_1_min <- data.frame(time = c(0,round(sort(min_list[c(4:6,8)]),0)),
                           Concentration=c(1000,#input$Concentration,
                                           sort(min_list[c(1:3,7)],decreasing=TRUE)))
        cd_1_max <- data.frame(time = c(0,round(sort(max_list[c(4:6,8)]),0)),
                           Concentration=c(1000,#input$Concentration,
                                           sort(max_list[c(1:3,7)],decreasing=TRUE)))
        cd_1$range <-cd_1_max$time - cd_1$time
        
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
        
        #ttxt <- as.character(tval)

        #print (tval)
        #print (ttxt)
        #print ("plotly is here")
        #print (cd_1)
        # add anotation
        
        p <-plot_ly(error_x = list(array = cd_1$range,color='#000000'))%>%
          add_trace(data = cd_1, x= ~time+2020,#input$Year_Removed, 
                    y = ~Concentration , 
                    name = ' ',
                    type = "scatter", line = list(shape = "spline",color='rgb(31,119,180)'),
                    mode = 'lines+markers',
                    hovertemplate = paste('<br>Year: %{x}', '<br>Concentration: %{y} ug/L<br>')
          )%>%
          # add_segments(x = input$Year_Removed,
          #              xend = round(as.numeric(results_list[6])+input$Year_Removed,0),
          #              y = as.numeric(results_list[7]), yend = as.numeric(results_list[7]),
          #              name = ' ',
          #              hovertemplate = paste(' '))%>%
          add_annotations(x = (round(as.numeric(results_list[6])+input$Year_Removed,0)-5),
                          y = log10(as.numeric(results_list[7])*1.3),
                          text = paste("Clean-up Level (",results_list[7]," ug/L)"),
                          xref = "x",
                          yref = "y",
                          showarrow=F)%>%
          #plot_ly(source = "source") #%>%
          #add_trace(data = cd_1, x= ~time, y = ~Concentration , type = "scatter", 
          #          mode = 'lines+markers')  %>%
          #add_trace(data = cd_2, x= ~date, y = ~results, color = ~Analyte_Units, type = "scatter", mode = 'lines+markers',
          #          symbol = ~I(fill), yaxis = "y2") %>%
           layout(#legend = list(orientation = 'h'),
          #   # yaxis2 = list(
          #   #   overlaying = "y",
          #   #   side = "right",
          #   #   title = "",
          #   #   automargin = T,
          #   #   showgrid = FALSE),
          #   
          #   # title = paste0("The current cleanup goal for this monitoring well ",results_list[7], " ug/L will occur in ",
          #   #                round(as.numeric(results_list[8])+as.numeric(input$Year_Removed),0),sep=''),
          #   
            xaxis = list(title="Year",
                         automargin = T,
                         showline=T,
                         mirror = "ticks",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         #range = c(input$Year_now, input$Year_now+as.numeric(results_list[6])),
                         zeroline=F
            ),
            yaxis = list(title="COC Concentration at <br> Monitoring Well (ug/L)",
                         automargin = T,
                         type ='log',
                         tickvals=tval2,
                         ticktext=ttxt,
                         #showline=T,
                         #mirror = "ticks",
                         #linecolor = toRGB("black"),
                         #linewidth = 2,
                         #range = c(0, 1000),
                         zeroline=F),
            showlegend = FALSE,

            dragmode = "select", selectdirection = "h"
             )# %>%
        
        
          # config(
          #   displayModeBar = F,
          #   toImageButtonOptions = list(
          #     format = "png",
          #     filename = "plot")) %>%
          # event_register('plotly_brushing')
        
      })
      
      output$dygraph_plot1 <- renderPlotly({ 
        plotlyfigureoutput()
      }) #plotly output
      
      ## Export travel time results ---------------------
      output$selected_TT <- renderText({ 
        
        
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
      
      # Export title of plotly ---------------------
      output$selected_TT2 <- renderText({

        results_list <-cd_get()
        paste("<H4>","The concentratrion in the monitoring well will achieve the clean-up goal of ",mean(results_list$Target_Clean_Level), " ug/L in ",
              "<font color=\"#FF0000\"><b>",
              round(as.numeric(mean(results_list$Time_Cleanup))+as.numeric(input$Year_Removed),0),
              "</b></font></H4>","."
        )
      })
      
      ## Export Model Results ---------------------------
      # output$model_results <- downloadHandler(
      #   filename = function(){
      #     paste("Borden_Tool_Results","xlsx",sep=".")
      #   },
      #   
      #   content = function(con){
      #     # Model Results
      #     cd <- cd_get()
      #     cd <-data.frame(t(cd))
      #     orca(plotlyfigureoutput(),"plot.png")
      #     # cd <- MW_Calcs()
      #     # validate(need(cd != "Error with Inputs", 'Please Check Input Values'))
      #     # 
      #     # cd <- full_join(loc() %>% select("Location", "Date"), cd, by = "Location")
      #     # 
      #     
      #     if (HalfLife()==0){
      #       colnames(cd) <- c('A 90% concentration reduction (ug/L)', 
      #                         'A 99% concentration reduction (ug/L)', 
      #                         'A 99.9% concentration reduction (ug/L)', 
      #                         'Time takes a 90% concentration reduction (year)', 
      #                         'Time takes a 99% concentration reduction (year)',
      #                         'Time takes a 99.9% concentration reduction (year)', 
      #                         'Target clean level (ug/L)',
      #                         'Time takes to reach target clean level (ug/L)',
      #                         'Persistent_Source_Index')
      #     }else if (HalfLife()>0&input$BGLG!=1){
      #       cd <-cd [,c(2,3,5,6)]
      #       colnames(cd) <- c('A 99% concentration reduction (ug/L)', 
      #                         'A 99.9% concentration reduction (ug/L)',
      #                         'Time takes a 99% concentration reduction (year)',
      #                         'Time takes a 99.9% concentration reduction (year)')
      #     }else{
      #       cd <-cd [,c(3,6)]
      #       colnames(cd) <- c('A 99.9% concentration reduction (ug/L)', 
      #                         'Time takes a 99.9% concentration reduction (year)')
      #     }
      #     
      #     
      #     
      #     # Create empty excel file
      #     wb <- createWorkbook()
      #     
      #     # Add Results Tab
      #     addWorksheet(wb, "Borden_Tool_Results")
      #     writeData(wb, sheet = "Borden_Tool_Results", x = cd, startCol = 1, startRow = 1, colNames = T)
      #     insertImage(wb, "Borden_Tool_Results", paste0("./plot.png"), 
      #                 startRow = 9, startCol = 2, heigh = 864, width = 1618, units = "px")
      #     
      #     
      #     BGLGname <-ifelse(input$BGLG==1,'BG',ifelse(input$BGLG==2,'LG','both BG and LG'))
      #     HalfLifeYN_label <-ifelse(input$HalfLifeYN==1,'no','yes')
      #     # Add Parameters Tab
      #     x <- data.frame(# step 2
      #       c("Distance to Monitoring Well (m)", input$X),
      #       c("Hydraulic Gradient (-)", input$i),
      #       c("COC", input$COC),
      #       c("Year Source Started (year)", input$Year_Started),
      #       c("Year Source Removed (year)", input$Year_Removed),
      #       
      #       # step3
      #       c("The option for hydrogeologic setting", BGLGname),
      #       
      #       # step 4
      #       c("Aquifer Thickness (m)", input$Thickness),
      #       c("Transmissive Geology", input$HighKPorousMedia),
      #       c("Low-K Geology", input$LowKPorousMedia),
      #       c("Half Life Included", HalfLifeYN_label),
      #       
      #       #step 5&6
      #       c("Current Concentration at Monitoring Well", input$Concentration),
      #       #c("Year now (year)", input$Year_now),
      #       c("Target Clean-Up Level (ug/L)", input$Target_Clean_Level),
      #       
      #       #step 8
      #       c("Hydraulic Conductivity of Transmissive Zone (cm/s)", input$K),
      #       c("Effective Porosity of Transmissive Zone (-)", input$ne),
      #       c("Total Porosity of Low-K Zone (-)", input$n),
      #       c("Diffusion Coefficient of COC (cm2/s)", input$D),
      #       c("Tortuosity of Low-K Zone (-)", input$tortuosity_LK),
      #       c("Retardation Factor of Transmissive Layer (-)", input$Retardation_HK),
      #       c("Retardation Factor of Low-K Layer (-)", input$Retardation_LK),
      #       c("Fraction Organic Carbon Transmissive Layer (-)", input$foc_HK),
      #       c("Fraction Organic Carbon Low-K Layer (-)", input$foc_LK),
      #       c("Bulk Density of Transmissive Layer (kg/L)", input$Rho_HK),
      #       c("Bulk Density of Low-K Layer (kg/L)", input$Rho_LK),
      #       c("Partition Coefficient of COC (L/kg)",input$Partition_Coeff)
      #     )
      #     print (x)
      #     if (BGLGname %in% c("LG","BGLG")){
      #       x$`Percent of thickness that is transmissive (%)` <- c("Percent of thickness that is transmissive (%)",input$Percent_T)
      #       x$`Number of Low-K Layers` <- c("Number of Low-K Layers",input$N)
      #     }
      #     
      #     if (input$HalfLifeYN==2){
      #       x$`Low-K Degradation Half-Life (year)`<- c("Low-K Degradation Half-Life (year)",input$HalfLife)
      #     }
      #     
      #     addWorksheet(wb, "Parameters")
      #     writeData(wb, sheet = "Parameters", x = x, startCol = 1, startRow = 1, colNames = F)
      #     
      #     saveWorkbook(wb, con)
      #   }
      # )# end model_results
      
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
      
      observeEvent(tortuosity_LK, {
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
          if (input$HalfLife<0.6&input$HalfLifeYN==2){
            showNotification("WARNING!!! Half-life outside model range.",
                             type="warning",
                             duration=NULL)
          }
          if (input$HalfLifeYN==1){
            HalfLife(0)
          }
        })
      # warning message ---------------------
      
    }
  )
  end.time <- Sys.time()
  print(end.time-beginning)
} # end Cleanup Goals Server 
