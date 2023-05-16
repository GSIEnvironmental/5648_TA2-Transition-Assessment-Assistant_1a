# Tool 5 Plume Zone Version 2 

PlumeZoneUI <- function(id, label = "05_PlumeZone"){
  ns <- NS(id)
  
  tabPanel("5. Plume Projections",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 5.  Can I meet my cleanup goal at a downgradient point of compliance after the transition from active treatment?</h1></b>"),
                    column(5,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4><ol>
                           This tool uses site monitoring data to evaluate if concentration-based cleanup goals will be
                           exceeded at a downgradient point of compliance (e.g., site boundary) 
                           after transitioning from active treatment (e.g., pump-and-treat) to passive 
                           treatment (e.g., MNA). It includes several different options to estimate a 
                           site-specific attenuation rate constant, and then uses this rate constant to project the 
                           concentration vs. distance from the contaminant source. The predicted concentration at the 
                           downgradient point of compliance is then compared to the concentration goal.</ol></h4>")),
                    column(5,
                           HTML("<h3><b>How Does it Work?</b></h3>
                           <h4><ol>
                           <li> Use “Site-Specific Information” tab to enter relevant monitoring locations and concentration data.</li> 
                           <li> Select “Use Pre-Remediation Rate Constant” tab if concentration data are available for the monitoring period prior to the start of active treatment.  This will project the concentration vs. distance during the Post-Remediation period using the rate constant that applied before active treatment.</li>
                           <li> Select “Use Lab-Based Rate Constant” tab if a biodegradation rate constant is available from a lab-based microcosm, 14C assay, or biomarker data.  This rate constant will be used to project the concentration vs. distance during the Post-Remediation period.</li>     
                           <li> Select “Use Post-Remediation Rate Constant” tab if concentration data are available for the period after active treatment has stopped.  This will project the concentration vs. distance during the Post-Remediation period using the recent rate constant assuming steady state conditions have been restored.</li>
                                </ol></h4>"))), # end Page Title
           ## Input Data ----------
           fluidRow(
             column(5, 
                    #style='border-right: 5px solid black',
                    #HTML("<h2><b>Site-Specific Info</b></h2>"), 
                    tabsetPanel(id = ns('tabs'),
                      ## 1. Site/Temporal Settings & COC --------
                      tabPanel(value ='main', HTML("Site-Specific Info"), 
                               br(),
                               fluidRow(column(10, 
                                               HTML("<h4><b>Step 1.</b> Enter Data.</h4>"),
                                               HTML("<h4><i>See 'Data Input' tab for more information.</i></h4>")),
                                         column(2, align = "left", style = "padding:10px;",
                                                actionButton(ns("help1"), HTML("?"), style = button_style2))
                               ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 2.</b> Select Wells to be included in analysis.</h4>"),
                                               fluidRow(align = "center",
                                                        pickerInput(ns("select_mw"), label = NULL,
                                                                    choices = c(""),
                                                                    multiple = T,
                                                                    selected = "PW-1",
                                                                    options = list(`live-search`=TRUE,
                                                                                   `none-selected-text` = "Select Wells")))),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help2"), HTML("?"), style = button_style2))
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 3.</b> Select source well.</h4>"),
                                               HTML("<h4><i>In the 'Data Input' tab, define which well is the source well in the column labeled 'Well Grouping'.</i></h4>")
                                               )
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 4.</b> Input distance from source well to downgradient point of compliance.</h4>"),
                                               fluidRow(align = "center",
                                                        column(6, align = "right", 
                                                               numericInput(ns("Ltot"), label = NULL,
                                                                            value = 500, min = 0, step = 0.01,
                                                                            width = "80px")),
                                                        column(6, align = "left", 
                                                               HTML("<h4>m</h4>")),br()
                                                        )
                                               ),
                                        column(2, align = "left", style = "padding:10px;",
                                                      actionButton(ns("help5_3"), HTML("?"), style = button_style2)
                                               )
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 5.</b> Estimate seepage velocity.</h4>"),
                                               fluidRow(align = "center",
                                                        column(6, align = "right", 
                                                               numericInput(ns("gwv"), label = NULL,
                                                                            value = 30, min = 0, step = 0.01,
                                                                            width = "80px")),
                                                        column(6, align = "left", 
                                                               HTML("<h4>m/year</h4>")),br()
                                                        )
                                               ),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help5_3"), HTML("?"), style = button_style2))
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 6.</b> Choose COC.</h4>"),
                                               fluidRow(align = "center",
                                                        column(12, align = "right", 
                                                               pickerInput(ns("select_COC"), label = NULL,
                                                                           choices = c(),
                                                                           multiple = T,
                                                                           options = list(`live-search`=TRUE,
                                                                                          `none-selected-text` = "Select COCs")))))
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 7.</b> Select the cleanup goal.</h4>"),
                                               fluidRow(column(10,
                                                               fluidRow(
                                                                 column(6, align = "right", 
                                                                        numericInput(ns("Conc_goal"), label = NULL,
                                                                                     value = 10, min = 0, step = 0.01,
                                                                                     width = "80px")),
                                                                 column(6, align = "left", 
                                                                        htmlOutput(ns("unit"))))),
                                                        column(2, align = "left", style = "padding:10px;",
                                                               actionButton(ns("help1_1"), HTML("?"), style = button_style2)
                                                               )
                                                        )
                                               ), br()
                                        )# end parameter inputs
                               ), # end first tabpanel
                      ## 2. Select Scenario & Hydrologic Setting ---------------
                      tabPanel(value ='prerem',HTML("Use Pre-Remediation Rate Constant"),
                               br(),
                               fluidRow(column(10, 
                                               HTML("<h4><b>Step 1.</b> Select method and time range for combining time series data.</h4>"),
                                               HTML("<h4><i>Use only data from pre-remediation.</i></h4>"),
                                               fluidRow(align = "center",
                                                        radioButtons(ns("group_method1"), label = NULL,
                                                                     choices = c("Geomean", "Mean"),
                                                                     selected = "Mean",
                                                                     inline = T)),
                                               fluidRow(align = "center",
                                                        dateRangeInput(ns("date_range1"), label = NULL,
                                                                       start = min(temp_data$Date,na.rm = TRUE), 
                                                                       end = Sys.Date()))
                                               ),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help1"), HTML("?"), style = button_style2))
                               ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 2. </b> Enter current concentration for source well.</h4>"),
                                               fluidRow(align = "center",
                                                        column(6, align = "right", 
                                                               numericInput(ns("Lsource1"), label = NULL,
                                                                            value = 30, min = 0, step = 0.01,
                                                                            width = "80px")),
                                                        column(6, align = "left", 
                                                               HTML("<h4> ug/L</h4>")),br())),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help5_3"), HTML("?"), style = button_style2))
                               ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 3.</b> Select confidence interval for one sided test.</h4>"),
                                               fluidRow(align = "center",
                                                        radioButtons(ns("CIvalue1"), label = NULL,
                                                                     choices = c('80%','90%','95%','99%'),
                                                                     inline = T))),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help2"), HTML("?"), style = button_style2))
                                        ), br()
                               
                      ), # end tab panel 2
                      ## 3. (Optional) Site-Specific Parameters -------------------------------------
                      tabPanel(value ='lab', HTML("Use Lab-Based Rate Constant"),
                               br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 1.</b> Enter biodegradation rate constant for COC of interest.</h4>"),
                                               fluidRow(align = "center",
                                                        column(6, align = "right", 
                                                               numericInput(ns("Rate_bio"), label = NULL,
                                                                            value = 0.1, min = 0, step = 0.01,
                                                                            width = "80px")),
                                                        column(6, align = "left", 
                                                               HTML("<h4> per year</h4>")),br())),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help5_3"), HTML("?"), style = button_style2))
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 2.</b> Enter upper confidence limit for biodegradation rate constant (if known).</h4>"),
                                               fluidRow(align = "center",
                                                        column(6, align = "right", 
                                                               numericInput(ns("CIlimit"), label = NULL,
                                                                            value = 0.07, min = 0, step = 0.01,
                                                                            width = "80px")),
                                                        column(6, align = "left", 
                                                               HTML("<h4> per year</h4>")),br())),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help5_3"), HTML("?"), style = button_style2))
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 3.</b> Enter current concentration for source well.</h4>"),
                                               HTML("<h4><i>Use for projection during post-remediation period.</i></h4>"),
                                               fluidRow(align = "center",
                                                        column(6, align = "right", 
                                                               numericInput(ns("Lsource2"), label = NULL,
                                                                            value = 30, min = 0, step = 0.01,
                                                                            width = "80px")),
                                                        column(6, align = "left", 
                                                               HTML("<h4> ug/L</h4>")),br())),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help5_3"), HTML("?"), style = button_style2))
                                        ), br()
                               
                      ), # end tab panel 3 
                      ## 4. Uncertainty Analysis (Optional) -----------------
                      tabPanel(value ='postrem',HTML("Use Post-Remediation Rate Constant"),
                               br(),
                               br(),
                               fluidRow(column(10, 
                                               HTML("<h4><b>Step 1.</b> Select method and time range for combining time series data.</h4>"),
                                               HTML("<h4><i>Use only data from the post-remediation period.</i></h4>"),
                                               fluidRow(align = "center",
                                                        radioButtons(ns("group_method3"), label = NULL,
                                                                     choices = c("Geomean", "Mean"),
                                                                     selected = "Mean",
                                                                     inline = T)),
                                               fluidRow(align = "center",
                                                        dateRangeInput(ns("date_range3"), label = NULL,
                                                                       start = min(temp_data$Date,na.rm = TRUE), 
                                                                       end = Sys.Date()))
                                               ),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help1"), HTML("?"), style = button_style2)
                                               )
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 2. </b> Enter current concentration for source well.</h4>"),
                                               HTML("<h4><i>Used for projection during post remediation period.</i></h4>"),
                                               fluidRow(align = "center",
                                                        column(6, align = "right", 
                                                               numericInput(ns("Lsource3"), label = NULL,
                                                                            value = 30, min = 0, step = 0.01,
                                                                            width = "80px")),
                                                        column(6, align = "left", 
                                                               HTML("<h4> ug/L</h4>")),br())),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help5_3"), HTML("?"), style = button_style2)
                                               )
                                        ), br(),
                               fluidRow(column(10,
                                               HTML("<h4><b>Step 3.</b> Select confidence interval for one sided test.</h4>"),
                                               fluidRow(align = "center",
                                                        radioButtons(ns("CIvalue3"), label = NULL,
                                                                     choices = c('80%','90%','95%','99%'),
                                                                     inline = T))),
                                        column(2, align = "left", style = "padding:10px;",
                                               actionButton(ns("help2"), HTML("?"), style = button_style2))
                                        ), br()
                               ), # end Input Date tabset panel
                      )
                    ),
             # column(1, align = "center"),
             # Results -----------------------
             column(6, style='border-left: 5px solid black',
                    # Table of Results
                    fluidRow(align="left", style='padding-left:50px;',
                             tags$style(HTML(".shiny-output-error-validation {
                             color: #ff0000;
                             font-weight: bold;
                             font-size: 18pt;}")),
                             HTML("<h2><b>Results</b></h2>"),
                             
                             br(),
                             conditionalPanel(condition = "input.tabs==`main`", ns=ns,
                                              HTML("<h3 style = 'color: #4a746c;'><b><i>1. Pre-Remediation Period (actual)</i></b></h4>"),
                                              HTML("<h3 style = 'color: #FF0000;'><b>Please select COCs (Step 6) and 
                                                   select one of the Rate Constant tabs to see projection of concentration vs. distance.</b></h3>"),
                                              br(),br(),br(),br(),br(),br(),br(),br(),
                                              HTML("<h3 style = 'color: #4a746c;'><b><i>2. Post-Remediation Period (projected)</i></b></h4>"),
                                              HTML("<h3 style = 'color: #FF0000;'><b>Please select COCs (Step 6) and 
                                                   select one of the Rate Constant tabs to see projection of concentration vs. distance.</b></h3>"),
                                              br(),br(),br(),br(),br(),br(),br(),br()
                                              ),
                             #pre remediation
                             conditionalPanel(condition = "input.tabs==`prerem`", ns=ns,
                                              HTML("<h3 style = 'color: #4a746c;'><b><i>1. Pre-Remediation Period (actual)</i></b></h4>"),
                                              fluidRow(align = "center",
                                                       plotlyOutput(ns('ts_plot1_1'), height = "600px"),
                                                       br(),
                                                       
                                                       fluidRow(column(6,
                                                                       align = "left",
                                                                       HTML("<h3><b><i>Estimated Attenuation Rate Constant (per meter)</i></b></h3>")
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox1_1"))
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox1_2")))
                                                       ),
                                                       br()
                                                       ),
                                              HTML("<h3 style = 'color: #4a746c;'><b><i>2. Post-Remediation Period (projected)</i></b></h4>"),
                                              fluidRow(align = "center",
                                                       plotlyOutput(ns('ts_plot1_2'), height = "600px"),
                                                       br(),
                                                       
                                                       fluidRow(column(6,
                                                                       align = "left",
                                                                       HTML("<h3><b><i>Estimated Concentration at Point of Compliance (ug/L)</i></b></h3>")
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox1_3"))
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox1_4"))
                                                       ),
                                                       ),
                                                       
                                                       br(),
                                                       fluidRow(align = "center", 
                                                                column(6,
                                                                       align = "left",
                                                                       HTML("<h3><b><i>Cleanup Goal Achieved at Point of Compliance?</i></b></h3>")
                                                                ),
                                                                column(3,align = "center",
                                                                       valueBoxOutput(ns("vbox1_5"))
                                                                ),
                                                                column(3,align = "center",
                                                                       valueBoxOutput(ns("vbox1_6"))
                                                                       ),
                                                                ),
                                                       br()
                                                       ),
                                              ),
                             # lab based
                             conditionalPanel(condition = "input.tabs==`lab`", ns=ns,
                                     HTML("<h3 style = 'color: #4a746c;'><b><i>1. Pre-Remediation Period (actual)</i></b></h3>"),
                                     fluidRow(align = "center",
                                              HTML("<h3 style = 'color: #FF0000;'><b>Data from Pre-Remediation Period is not used.  
                                                   Attenuation rate constant is estimated using 
                                                   user-entered biodegradation rate constant and 
                                                   groundwater seepage velocity</b></h3>"),
                                      
                                              br(),
                                              
                                              fluidRow(column(6,
                                                              align = "left",
                                                              HTML("<h3><b><i>Estimated Attenuation Rate Constant (per meter)</i></b></h3>")
                                              ),
                                              column(3,align = "center",
                                                     valueBoxOutput(ns("vbox2_1"))
                                              ),
                                              column(3,align = "center",
                                                     valueBoxOutput(ns("vbox2_2"))
                                              ),
                                              ),
                                              br()
                                     ),
                                     HTML("<h3 style = 'color: #4a746c;'><b><i>2. Post-Remediation Period (projected)</i></b></h4>"),
                                     fluidRow(align = "center",
                                              plotlyOutput(ns('ts_plot2_2'), height = "600px"),
                                              br(),
                                              
                                              fluidRow(column(6,
                                                              align = "left",
                                                              HTML("<h3><b><i>Estimated Concentration at Point of Compliance (ug/L)</i></b></h3>")
                                              ),
                                              column(3,align = "center",
                                                     valueBoxOutput(ns("vbox2_3"))
                                              ),
                                              column(3,align = "center",
                                                     valueBoxOutput(ns("vbox2_4"))
                                              ),
                                              ),
                                              
                                              br(),
                                              fluidRow(align = "center", 
                                                       column(6,
                                                              align = "left",
                                                              HTML("<h3><b><i>Cleanup Goal Achieved at Point of Compliance?</i></b></h3>")
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox2_5"))
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox2_6"))
                                                       ),
                                                       ),
                                              br()
                                              ),
                                     ),
                             # postrem
                             conditionalPanel(condition = "input.tabs==`postrem`", ns=ns,
                                              HTML("<h3 style = 'color: #4a746c;'><b><i>1. Post-Remediation Period (actual)</i></b></h3>"),
                                              fluidRow(align = "center",
                                                       
                                                       plotlyOutput(ns('ts_plot3_1'), height = "600px"),
                                                       br(),
                                                       
                                                       fluidRow(column(6,
                                                                       align = "left",
                                                                       HTML("<h3><b><i>Estimated Attenuation Rate Constant (per meter)</i></b></h3>")
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox3_1"))
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox3_2"))
                                                       ),
                                                       ),
                                                       br()
                                              ),
                                              HTML("<h3 style = 'color: #4a746c;'><b><i>2. Post-Remediation Period (projected)</i></b></h4>"),
                                              fluidRow(align = "center",
                                                       plotlyOutput(ns('ts_plot3_2'), height = "600px"),
                                                       br(),
                                                       
                                                       fluidRow(column(6,
                                                                       align = "left",
                                                                       HTML("<h3><b><i>Estimated Concentration at Point of Compliance (ug/L)</i></b></h3>")
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox3_3"))
                                                       ),
                                                       column(3,align = "center",
                                                              valueBoxOutput(ns("vbox3_4"))
                                                       ),
                                                       ),
                                                       
                                                       br(),
                                                       fluidRow(align = "center", 
                                                                column(6,
                                                                       align = "left",
                                                                       HTML("<h3><b><i>Cleanup Goal Achieved at Point of Compliance?</i></b></h3>")
                                                                ),
                                                                column(3,align = "center",
                                                                       valueBoxOutput(ns("vbox3_5"))
                                                                ),
                                                                column(3,align = "center",
                                                                       valueBoxOutput(ns("vbox3_6"))
                                                                ),
                                                       ),
                                                       br()
                                              ),
                             ),
                             br(), br(),
                    ),
                    
                            
                             
                    ) # end Results
             ) # end FluidRow
  ) # end tab panel
} # end Cleanup Goals UI  

## Server Module -----------------------------------------
PlumeZoneServer <- function(id,data_input,nav) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      # RV: Concentration and Time Data -----------
      d_conc <- reactiveVal(data_long(temp_data))
      observeEvent(data_input$d_conc(),{
        d_conc(data_input$d_conc())
      }) # end d_conc()
      
      # update Units -------------------
      observe({
        req(nav() == "5. Plume Projections")
        req(d_conc())
        
        output$unit<- renderUI({
          HTML(paste0("<h4>",unique(d_conc()$Units),"</h4>",sep=''))
        })
      }) # end update unit 
      
      
      # RV: Location Data -----------------------
      d_loc <- reactiveVal(data_mw_clean(temp_mw_info))
      
      observeEvent(data_input$d_loc(),{
        d_loc(data_input$d_loc())
      }) # end d_loc()
      
      # RV: Merge d_loc and d_conc -----------------------
      d_mer <- reactiveVal()
      
      observeEvent({
        d_loc()
        d_conc()},{
          d_mer(data_merge(d_conc(), d_loc()))
          
        }) # end d_mer()
      
      # Well Selection Updates -----------------------
      observe({
        req(nav() == "5. Plume Projections")
        req(d_conc())
        choices <- sort(unique(d_conc()$WellID))
        
        updatePickerInput(session, "select_mw", choices = choices, selected = choices)
      }) # end update well selection
      
      # COC Selection Updates -----------------------
      observe({
        req(nav() == "5. Plume Projections")
        req(d_conc())
        
        choices <- sort(unique(d_conc()$COC))
        
        updatePickerInput(session, "select_COC", choices = choices)
        
      }) # end update well selection
      
      # ----- Data
      output$conc_time_data <- renderRHandsontable({
        validate(
          need(data_input$d_conc(), "Please enter data into Data Input tab (Step 1)."))
        
        tbl_name <- data_input$d_conc()%>%
          rename(`Date (Month/Day/Year)`=Date)%>%
          filter(WellID%in%input$select_mw)%>%
          filter(COC%in%input$select_COC)
        
        rhandsontable(tbl_name, readOnly = T, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })
      
      output$mw_data <- renderRHandsontable({
        validate(
          need(data_input$d_loc(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."))
        
        tbl_name <- data_input$d_conc()%>%
          rename(`Date (Month/Day/Year)`=Date)%>%
          filter(WellID%in%input$select_mw)%>%
          filter(COC%in%input$select_COC)
        
        loc_name<-data_input$d_loc()%>%
          filter(`Monitoring Wells`%in%unique(tbl_name$WellID))
        
        rhandsontable(loc_name, readOnly = T, rowHeaders = NULL, width = 1000, height = 600) %>%
          hot_cols(columnSorting = TRUE)
        
      })
      
      # RV: Series Avg Data ---------------
      df <- reactiveVal()
      
      observe({
        req(d_conc(),
            input$select_mw,
            input$group_method1,
            input$date_range1,
            input$select_COC)
        
        ave_switch <- input$group_method1
      
        # Filter to Wells
        df_MW <- d_mer() %>%
          filter(WellID %in% input$select_mw,
                 Date >= input$date_range1[1],
                 Date <= input$date_range1[2],
                 COC %in% input$select_COC) 
        
        # Apply Selected Avg. Method
        if (ave_switch == 'Mean'){
          df_MW <- df_MW %>% group_by(WellID, COC,State) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE),
                      Distance = mean(`Distance from Source (m)`,na.rm=TRUE))
        }
        
        if (ave_switch == 'Geomean'){
          df_MW <- df_MW %>% group_by(WellID, COC,State) %>%
            summarise(Concentration = exp(mean(log10(Concentration), na.rm=TRUE)),
                      Distance = exp(mean(log10(`Distance from Source (m)`),na.rm=TRUE)))
        }
        
        
        # assign color
        colpalette= brewer.pal(n = 8, name = "Dark2")
        count = 1
        df_MW$color <- colpalette[1]
        for (j in unique(df_MW$State)){
          df_MW$color = ifelse(df_MW$State==j,colpalette[count],df_MW$color)
          count = count+1
        }
   
        df(df_MW)
      }) # end df()
      
      
      # RV: Sen Trend Model ---------------
      sen_lm <- reactiveVal()
      
      observe({
        req(length(df()$Concentration) > 2)
       
        if(length(unique(df()$State))==1){
          sen_lm(list(sen_trend_distance(df(),input$select_COC)))
        }else{
          sen_lm(sen_trend_distance(df(),input$select_COC))
        }
      })
    
      
      setBorderColor <- function(valueBoxTag, color)
      {tagQuery(valueBoxTag)$find("div.small-box")$addAttrs(
          "style" = sprintf("border-style: solid; border-color: %s; width: 200px;", color))$allTags()}
      
      #--- Pre Remediation BOX
      output$vbox1_1 <- renderValueBox({
        req(sen_lm())
        rate_constant_pre=as.numeric(sen_lm()[[1]][1]$coefficients[2])
        
        setBorderColor(valueBox(
          "Without Confidence Limit",
          signif(rate_constant_pre,2)),
          'black'
          )
        
      })
      
      
      output$vbox1_2 <- renderValueBox({
        req(sen_lm())
        
        CIvalue1 = ifelse(input$CIvalue1=='80%',0.8,
                          ifelse(input$CIvalue1=='90%',0.9,
                                 ifelse(input$CIvalue1=='95%',0.95,0.99)))
        
        rate_constant_pre_CI = confint(sen_lm()[[1]],level=CIvalue1*2-1)[[4]]
        setBorderColor(valueBox(
          "With Confidence Limit",
          signif(rate_constant_pre_CI,2)
        ),'black'      )      })
    
      output$vbox1_3 <- renderValueBox({
        req(sen_lm())
        rate_constant_post=10^(as.numeric(sen_lm()[[1]]$coefficients[1])+
                                 as.numeric(sen_lm()[[1]]$coefficients[2])*input$Ltot)
        setBorderColor(valueBox(
          "Without Confidence Limit",
          signif(rate_constant_post,2)
        ),
        'black'
        )
      })
      
      output$vbox1_4 <- renderValueBox({
        req(sen_lm())
        
        CIvalue1 = ifelse(input$CIvalue1=='80%',0.8,
                          ifelse(input$CIvalue1=='90%',0.9,
                                 ifelse(input$CIvalue1=='95%',0.95,0.99)))
        rate_constant_post_CI = 10^(as.numeric(confint(sen_lm()[[1]],level=CIvalue1*2-1)[[3]])+
                                       as.numeric(confint(sen_lm()[[1]],level=CIvalue1*2-1)[[4]])*input$Ltot)
        setBorderColor(valueBox(
          "With Confidence Limit",
          signif(rate_constant_post_CI,2)
        ),
        'black'
        )
      })
      
      output$vbox1_5 <- renderValueBox({
        req(sen_lm())
        
        time_woCI = ifelse(10^(as.numeric(sen_lm()[[1]]$coefficients[1])+
                                 as.numeric(sen_lm()[[1]]$coefficients[2])*input$Ltot)>input$Conc_goal,
                           "No","Yes")
                           
        setBorderColor(valueBox(
          "Without Confidence Limit",
          subtitle=time_woCI
        ),
        'black'
        )
      })
      
      output$vbox1_6 <- renderValueBox({
        req(sen_lm())
        
        CIvalue1 = ifelse(input$CIvalue1=='80%',0.8,
                          ifelse(input$CIvalue1=='90%',0.9,
                                 ifelse(input$CIvalue1=='95%',0.95,0.99)))
        time_wCI = ifelse(10^(as.numeric(confint(sen_lm()[[1]],level=CIvalue1*2-1)[[3]])+
                                 as.numeric(confint(sen_lm()[[1]],level=CIvalue1*2-1)[[4]])*input$Ltot)>input$Conc_goal,
                           "No","Yes")
        setBorderColor(valueBox(
          "With Confidence Limit",
          subtitle=time_wCI
        ),
        'black'
        )
        
      })
      
      #--- Lab Based BOX
      output$vbox2_1 <- renderValueBox({
        req(input$gwv,
            input$Rate_bio)
        rate_constant_pre=as.numeric(input$Rate_bio/input$gwv)
        
        setBorderColor(valueBox(
          "Without Confidence Limit",
          signif(rate_constant_pre,2)
        ),
        'black'
        )
      })
      
      output$vbox2_2 <- renderValueBox({
        req(input$gwv,
            input$CIlimit)
        
        rate_constant_pre_CI = as.numeric(input$CIlimit/input$gwv)
        setBorderColor(valueBox(
          "With Confidence Limit",
          signif(rate_constant_pre_CI,2)
        ),
        'black'
        )
      })
      
      output$vbox2_3 <- renderValueBox({
        req(input$gwv,
            input$Rate_bio,
            input$Ltot,
            input$Lsource2)
        rate_constant_post=input$Lsource2 - as.numeric(input$Rate_bio/input$gwv)*input$Ltot
        setBorderColor(valueBox(
          "Without Confidence Limit",
          signif(rate_constant_post,2)
        ),
        'black'
        )
      })
      
      output$vbox2_4 <- renderValueBox({
        req(input$gwv,
            input$CIlimit,
            input$Ltot,
            input$Lsource2)
        rate_constant_post_CI = input$Lsource2 - as.numeric(input$CIlimit/input$gwv)*input$Ltot
        setBorderColor(valueBox(
          "With Confidence Limit",
          signif(rate_constant_post_CI,2)
        ),
        'black'
      )
      })
      
      output$vbox2_5 <- renderValueBox({
        req(input$gwv,
            input$Rate_bio,
            input$Ltot,
            input$Lsource2,
            input$Conc_goal)
        
        time_woCI = ifelse((input$Lsource2 - as.numeric(input$Rate_bio/input$gwv)*input$Ltot)>input$Conc_goal,
                           "No","Yes")
        
        setBorderColor(valueBox(
          "Without Confidence Limit",
          subtitle=time_woCI
        ),
        'black'
        )
      })
      
      output$vbox2_6 <- renderValueBox({
        req(input$gwv,
            input$CIlimit,
            input$Ltot,
            input$Lsource2,
            input$Conc_goal)
        
        time_wCI = ifelse((input$Lsource2 - as.numeric(input$CIlimit/input$gwv)*input$Ltot)>input$Conc_goal,
                          "No","Yes")
        setBorderColor(valueBox(
          "With Confidence Limit",
          subtitle=time_wCI
        ),
        'black'
        )
        
      })
      
      #--- Post Remediation BOX
      output$vbox3_1 <- renderValueBox({
        req(sen_lm())
        rate_constant_pre=as.numeric(sen_lm()[[2]]$coefficients[2])
        
        setBorderColor(valueBox(
          "Without Confidence Limit",
          signif(rate_constant_pre,2)
        ),
        'black'
        )
      })
      
      output$vbox3_2 <- renderValueBox({
        req(sen_lm())
        
        CIvalue1 = ifelse(input$CIvalue1=='80%',0.8,
                          ifelse(input$CIvalue1=='90%',0.9,
                                 ifelse(input$CIvalue1=='95%',0.95,0.99)))
        
        rate_constant_pre_CI = confint(sen_lm()[[2]],level=CIvalue1*2-1)[[4]]
        setBorderColor(valueBox(
          "With Confidence Limit",
          signif(rate_constant_pre_CI,2)
        ),
        'black'
        )
      })
      
      output$vbox3_3 <- renderValueBox({
        req(sen_lm())
        rate_constant_post=10^(as.numeric(sen_lm()[[2]]$coefficients[1])+
                                 as.numeric(sen_lm()[[2]]$coefficients[2])*input$Ltot)
        setBorderColor(valueBox(
          "Without Confidence Limit",
          signif(rate_constant_post,2)
        ),
        'black'
      )
      })
      
      output$vbox3_4 <- renderValueBox({
        req(sen_lm())
        
        CIvalue1 = ifelse(input$CIvalue1=='80%',0.8,
                          ifelse(input$CIvalue1=='90%',0.9,
                                 ifelse(input$CIvalue1=='95%',0.95,0.99)))
        rate_constant_post_CI = 10^(as.numeric(confint(sen_lm()[[2]],level=CIvalue1*2-1)[[3]])+
                                      as.numeric(confint(sen_lm()[[2]],level=CIvalue1*2-1)[[4]])*input$Ltot)
        setBorderColor(valueBox(
          "With Confidence Limit",
          signif(rate_constant_post_CI,2)
        ),
        'black'
        )
      })
      
      output$vbox3_5 <- renderValueBox({
        req(sen_lm())
        
        time_woCI = ifelse(10^(as.numeric(sen_lm()[[2]]$coefficients[1])+
                                 as.numeric(sen_lm()[[2]]$coefficients[2])*input$Ltot)>input$Conc_goal,
                           "No","Yes")
        
        setBorderColor(valueBox(
          "Without Confidence Limit",
          subtitle=time_woCI
        ),
        'black'
        )
      })
      
      output$vbox3_6 <- renderValueBox({
        req(sen_lm())
        
        CIvalue3 = ifelse(input$CIvalue3=='80%',0.8,
                          ifelse(input$CIvalue3=='90%',0.9,
                                 ifelse(input$CIvalue3=='95%',0.95,0.99)))
        time_wCI = ifelse(10^(as.numeric(confint(sen_lm()[[2]],level=CIvalue3*2-1)[[3]])+
                                as.numeric(confint(sen_lm()[[2]],level=CIvalue3*2-1)[[4]])*input$Ltot)>input$Conc_goal,
                          "No","Yes")
        setBorderColor(valueBox(
          "With Confidence Limit",
          subtitle=time_wCI
        ),
        'black'
        )
        
      })
      


      #----- help function 
      lapply(
        X = 1:4,
        FUN = function(i){
          observeEvent(input[[paste0("help5_", i)]], {
            flname <-as.character(figure_list_5[i])
            Helpboxfunction(flname,Y='"./05_GWModels/')
          })
        }
      )
      
      # Plots ------------------
      
      output$ts_plot1_1 <- renderPlotly({
          validate(need(d_conc(), "Please enter data into the Data Input tab (Step 1)."))
          validate(need(df(), "Please select COCs (Step 6) and select one of the Rate Constant tabs to see projection of concentration vs. distance."))

          req(df(),
              sen_lm())
        p<-Tool5fig(df(), input$Conc_goal, input$Lsource1, input$Ltot, input$CIvalue1, "PreRem",input$group_method1,
                    sen = sen_lm()[[1]],gwv=NULL,Rate_bio=NULL)
        
        p
      })
      
      output$ts_plot1_2 <- renderPlotly({
        validate(need(d_conc(), "Please enter data into the Data Input tab (Step 1)."))
        validate(need(df(), "Please select COCs (Step 6) and select one of the Rate Constant tabs to see projection of concentration vs. distance."))
        
        req(df(),
            sen_lm())
        p<-Tool5fig(df(), input$Conc_goal, input$Lsource1, input$Ltot, input$CIvalue1, "Projected",input$group_method1,
                           sen = sen_lm()[[1]],gwv=NULL,Rate_bio=NULL)
        
        p
      })
      
      output$ts_plot2_2 <- renderPlotly({
        validate(need(d_conc(), "Please enter data into the Data Input tab (Step 1)."))
        validate(need(df(), "Please select COCs (Step 6) and select one of the Rate Constant tabs to see projection of concentration vs. distance."))
        
        req(df(),
            sen_lm())
        p<-Tool5fig(df(), input$Conc_goal, input$Lsource2, input$Ltot, input$CIlimit, "Lab-Based",input$group_method1,
                    sen = NULL,gwv=input$gwv,Rate_bio=input$Rate_bio)
        
        p
      })
      
      output$ts_plot3_1 <- renderPlotly({
        validate(need(d_conc(), "Please enter data into the Data Input tab (Step 1)."))
        validate(need(df(), "Please select COCs (Step 6) and select one of the Rate Constant tabs to see projection of concentration vs. distance."))
        
        req(df(),
            sen_lm())
        p<-Tool5fig(df(), input$Conc_goal, input$Lsource3, input$Ltot, input$CIvalue3, "PostRem",input$group_method3,
                    sen = sen_lm()[[2]],gwv=NULL,Rate_bio=NULL)
        
        p
      })
      
      output$ts_plot3_2 <- renderPlotly({
        validate(need(d_conc(), "Please enter data into the Data Input tab (Step 1)."))
        validate(need(df(), "Please select COCs (Step 6) and select one of the Rate Constant tabs to see projection of concentration vs. distance."))
        
        req(df(),
            sen_lm())
        p<-Tool5fig(df(), input$Conc_goal, input$Lsource3, input$Ltot, input$CIvalue3, "Projected",input$group_method3,
                    sen = sen_lm()[[2]],gwv=NULL,Rate_bio=NULL)
        
        p
      })
      
    })
}