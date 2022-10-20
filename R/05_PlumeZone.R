# Asymptote Modules -----------------------------

## UI -----------------------------------------
PlumeZoneUI <- function(id, label = "05_PlumeZone"){
  ns <- NS(id)
  
  tabPanel("5. Plume Zone",
           fluidRow(style='border-bottom: 5px solid black',
                    tags$h1(tags$b("Tool 5. Establish a Plume Assimilative Capacity Zone."))),
           fluidRow(br(),
                    column(3,
                           fluidRow(column(10,
                                           fluidRow(column(10, 
                                                           HTML("<h4><b>Step 1.</b> Enter Data. See 'Data Input' tab for more information</h4>")),
                                                    column(2, align = "left", style = "padding:10px;",
                                                           actionButton(ns("help1"), HTML("?"), style = button_style2))
                                           ), br(),
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 2.</b> Estimate the total length of plume assimilative Capacity Zone</h4>"),
                                                           fluidRow(align = "center",
                                                                    column(6, align = "right", 
                                                                           numericInput(ns("Ltot"), label = NULL,
                                                                                        value = 500, min = 0, step = 0.01,
                                                                                        width = "80px")
                                                                           ),
                                                                    column(6, align = "left", 
                                                                           HTML("<h4>m</h4>")),br()
                                                                    )
                                                           ),
                                                    column(2, align = "left", style = "padding:10px;",
                                                                              actionButton(ns("help1"), HTML("?"), style = button_style2)
                                                           )
                                                    ), br(),
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 3.</b> Select the concentration goal</h4>"),
                                                           fluidRow(align = "center",
                                                                    column(6, align = "right", 
                                                                           numericInput(ns("Conc_goal"), label = NULL,
                                                                                        value = 5, min = 0, step = 0.01,
                                                                                        width = "80px")
                                                                    ),
                                                                    column(6, align = "left", 
                                                                           htmlOutput(ns("unit"))),br())),
                                                    column(2, align = "left", style = "padding:10px;",
                                                           actionButton(ns("help1"), HTML("?"), style = button_style2))), 
                                           br(),
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 4.</b> Estimate seepage velocity</h4>"),
                                                           fluidRow(align = "center",
                                                                    column(6, align = "right", 
                                                                           numericInput(ns("gwv"), label = NULL,
                                                                                        value = 1, min = 0, step = 0.01,
                                                                                        width = "80px")),
                                                                    column(6, align = "left", 
                                                                           HTML("<h4>cm/s</h4>")),br())),
                                                    column(2, align = "left", style = "padding:10px;",
                                                           actionButton(ns("help1"), HTML("?"), style = button_style2))),
                                           br(),
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 5.</b> Select Wells to be included in analysis.</h4>"),
                                                           fluidRow(align = "center",
                                                                    pickerInput(ns("select_mw"), label = NULL,
                                                                choices = c(),
                                                                multiple = T,
                                                                options = list(`live-search`=TRUE,
                                                                               `none-selected-text` = "Select Wells")))),
                                                    column(2, align = "left", style = "padding:10px;",
                                                           actionButton(ns("help2"), HTML("?"), style = button_style2))), 
                                           br(),
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 6.</b> Select method and time range for combining time series data.</h4>"),
                                                           fluidRow(align = "center",
                                                                    radioButtons(ns("group_method"), label = NULL,
                                                                 choices = c("Geomean", "Mean"),
                                                                 selected = "Geomean",
                                                                 inline = T)),
                                                           fluidRow(align = "center",
                                                                    dateRangeInput(ns("date_range"), label = NULL,
                                                                   start = min(temp_data$Date,na.rm = TRUE), 
                                                                   end = Sys.Date()))),
                                                    column(2, align = "left", style = "padding:10px;",
                                                           actionButton(ns("help3"), HTML("?"), style = button_style2))
                                                    ), br(),
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 7.</b> Input distance from source to pumping well.</h4>"),
                                                           fluidRow(align = "center",
                                                                    column(6, align = "right", 
                                                                           numericInput(ns("Lsource"), label = NULL,
                                                                                        value = 850, min = 0, step = 0.01,
                                                                                        width = "80px")
                                                                    ),
                                                                    column(6, align = "left", 
                                                                           HTML("<h4>m</h4>")))),
                                                    column(2, align = "left", style = "padding:10px;",
                                                           actionButton(ns("help3"), HTML("?"), style = button_style2))
                                                    ), br(),
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 8.</b> Choose COC.</h4>"),
                                                           fluidRow(align = "center",
                                                                    column(12, align = "right", 
                                                                           pickerInput(ns("select_COC"), label = NULL,
                                                                                       choices = c(),
                                                                                       multiple = T,
                                                                                       options = list(`live-search`=TRUE,
                                                                                                      `none-selected-text` = "Select COCs"))),
                                                                    br()
                                                                    # conditionalPanel(
                                                                    #   condition='length(input.select_COC)==1',ns=ns,
                                                                    #   fluidRow(column(6, align = "left", uiOutput(ns("R_1"))),
                                                                    #            column(6, align = "center", numericInput(ns("Rvalue_1"), NULL, value = NULL, min = 0)
                                                                    #                   )
                                                                    )
                                                                    )#fluid row
                                                           # br(),
                                                           # conditionalPanel(condition="length(input.select_COC)==2",ns=ns,
                                                           #                  fluidRow(column(6, align = "left", uiOutput(ns("R_1"))),
                                                           #                           column(6, align = "center", numericInput(ns("Rvalue_1"), NULL, value = NULL, min = 0))
                                                           #                           )
                                                                            )#,
                                                           # conditionalPanel(condition="length(input.select_COC)==2",ns=ns,
                                                           #                  fluidRow(column(6, align = "left", uiOutput(ns("R_1"))),
                                                           #                           column(6, align = "center", numericInput(ns("Rvalue_1"), NULL, value = NULL, min = 0))),
                                                           #                  fluidRow(column(6, align = "left", uiOutput(ns("R_2"))),
                                                           #                           column(6, align = "center", numericInput(ns("Rvalue_2"), NULL, value = NULL, min = 0)))),
                                                           # conditionalPanel(condition="length(input.select_COC)==3",ns=ns,
                                                           #                  fluidRow(column(6, align = "left", uiOutput(ns("R_1"))),
                                                           #                           column(6, align = "center", numericInput(ns("Rvalue_1"), NULL, value = NULL, min = 0))),
                                                           #                  fluidRow(column(6, align = "left", uiOutput(ns("R_2"))),
                                                           #                           column(6, align = "center", numericInput(ns("Rvalue_2"), NULL, value = NULL, min = 0))),
                                                           #                  fluidRow(column(6, align = "left", uiOutput(ns("R_3"))),
                                                           #                           column(6, align = "center", numericInput(ns("Rvalue_3"), NULL, value = NULL, min = 0))))
                                                           )#column
                                                    # column(2, align = "left", style = "padding:10px;",
                                                    #        actionButton(ns("help3"), HTML("?"), style = button_style2))
                                           ), br()
                                           ),
                    column(9,
                           fluidRow(
                             HTML('<img style = "padding: 10px 50px 10px 10px;" 
                                               src = "./05_GWModels/Fig/Tool5_Fig1.jpg" 
                                               width = "100%"  
                                               height = "100%">')),
                           fluidRow(
                             tabsetPanel(
                               tabPanel("Results",
                                        br(),br(),
                                        uiOutput(ns("asy_summary")), br(), br(),
                                        plotlyOutput(ns('ts_plot1'), height = "600px")
                                        ),
                               tabPanel("Data",
                                        tabsetPanel(
                                          tabPanel(HTML("1. Concentration and Time Data"), br(),
                                                   rHandsontableOutput(ns("conc_time_data"))
                                                   ), # end concentration and time table
                                          tabPanel(HTML("2. Monitoring Well Information"), br(),
                                                   rHandsontableOutput(ns("mw_data"))
                                                   ) # end concentration and time table
                                          )
                                        )
                               )
                             )
                           )
                    )
                   
           #HTML("<h3><p style='color:red;'>This tool is currently under development.</h3></p>")
  )
  } # end Asymptote UI         


## Server Module -----------------------------------------
PlumeZoneServer <- function(id,data_input,nav) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      # RV: Concentration and Time Data -----------
      d_conc <- reactiveVal(data_long(temp_data))
      
      observeEvent(data_input$d_conc(),{
        d_conc(data_input$d_conc())
        #browser()
      }) # end d_conc()
      
      # update Units -------------------
      observe({
        req(nav() == "5. Plume Zone")
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
        req(nav() == "5. Plume Zone")
        req(d_conc())
        choices <- sort(unique(d_conc()$WellID))
        
        updatePickerInput(session, "select_mw", choices = choices, selected = choices)
      }) # end update well selection
      
      # COC Selection Updates -----------------------
      observe({
        req(nav() == "5. Plume Zone")
        req(d_conc())
        
        choices <- sort(unique(d_conc()$COC))
        
        updatePickerInput(session, "select_COC", choices = choices)

      }) # end update well selection
      
      # ----- Data
      output$conc_time_data <- renderRHandsontable({
        validate(
          need(data_input$d_conc(), "Please enter data into Data Input tab (Step 1)."))
        
        tbl_name <- data_input$d_conc()%>%
          rename(`Date (Month/Day/Year)`=Date)
        
        rhandsontable(tbl_name, readOnly = T, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })
      
      output$mw_data <- renderRHandsontable({
        validate(
          need(data_input$d_loc(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."))
        
        rhandsontable(data_input$d_loc(), readOnly = T, rowHeaders = NULL, width = 1000, height = 600) %>%
          hot_cols(columnSorting = TRUE)

      })
      
      # RV: Series Avg Data ---------------
      df <- reactiveVal()
      
      observe({
        req(d_conc(),
            input$select_mw,
            input$group_method,
            input$date_range,
            input$select_COC)
        
        ave_switch <- input$group_method
        
        # Filter to Wells
          df_MW <- d_mer() %>%
            filter(WellID %in% input$select_mw,
                   Date >= input$date_range[1],
                   Date <= input$date_range[2]) 
        
        # Apply Selected Avg. Method
        if (ave_switch == 'Mean'){
          df_MW <- df_MW %>% group_by(WellID, COC) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE),
                      Distance = mean(`Distance from Source (m)`,na.rm=TRUE))
        }
        
        if (ave_switch == 'Geomean'){
          df_MW <- df_MW %>% group_by(WellID, COC) %>%
            summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE)),
                      Distance = exp(mean(log(`Distance from Source (m)`),na.rm=TRUE)))
        }
        
        # # Add Period if breakpoint if available 
        # if(!is.null(bp()$x)){
        #   df_MW <- df_MW %>%
        #     mutate(period = ifelse(Date <= bp()$x, "Period 1", "Period 2"))
        # }
          
        
        df(df_MW)
      }) # end df()
      
      
      # RV: Sen Trend Model ---------------
      sen_lm <- reactiveVal()
      
      observe({
        req(length(df()$Concentration) > 2)
        sen_lm(sen_trend_distance(df()))
      })
      
      # ## Render Text ------------------------
      # #----- retardation factor
      # 
      # observeEvent({input$select_COC},{
      #   validate(need(!is.null(input$select_COC),'Please select COC.'))
      #   lapply(X = 1:length(input$select_COC),
      #   FUN = function(i){
      #     observe(
      #       {output[[paste0("R_", i)]] = renderUI({
      #                    req(input$select_COC)
      #                    
      #                    HTML(paste0("<h4>Retardation Factor of ",COCs[i], "</h4>"))
      #                    })
      #        COCs = sort(input$select_COC)
      #        print (COCs)
      #        Partition_Coeff =Constituents %>% filter(`Constituents Name` ==COCs[i]) %>% 
      #          pull(`Partition Coefficient of Constituent Koc [L/kg]`)
      #        Retardation_HK = 1 +Partition_Coeff * 0.001 * 1.7/0.22
      #        updateNumericInput(session, paste0("Rvalue_", i), value = signif(Retardation_HK,2))
      #                  })
      #     #browser()#lapply
      # })})

      # Plot 1 ------------------
      output$ts_plot1 <- renderPlotly({
        validate(need(d_conc(), "Please enter data into the Data Input tab (Step 1)."))
        validate(need(df(), "Please select wells or well grouping to analyze (Step 2)."))
        
        req(df(),
            sen_lm())
        
        # generate plots
        # create y axis as log
        tval <- sort(as.vector(sapply(seq(1,9), 
                                      function(x) 
                                        x*(seq(floor(log(min(input$Conc_goal,min(df()$Concentration,na.rm=TRUE)))),
                                               ceiling(log(max(df()$Concentration,na.rm=TRUE))))))))#generates a sequence of numbers in logarithmic divisions
        
        ttxt <- rep(" ",length(tval))  # no label at most of the ticks
        ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
        
        
        # estimate the intercept at concentration goal
        Cthreshold = exp(as.numeric(sen_lm()$coefficients[1])+as.numeric(sen_lm()$coefficients[2])*Distance_pump)
        
        C_goal = input$Conc_goal
        
        Length = -log(C_goal/Cthreshold)/abs(as.numeric(sen_lm()$coefficients[2])) + input$Lsource
        # convert concentration from natural log to raw
        c_raw <- sort(exp(c(predict(sen_lm(),data.frame(Distance = 0)),
                            fitted(sen_lm()),
                            predict(sen_lm(),data.frame(Distance = input$Lsource)),
                            predict(sen_lm(),data.frame(Distance = input$Lsource*2.9)),
                            log(C_goal))))
        
        p <- plot_ly(source = 'ts_selected')%>%
          add_segments(y = log(input$Conc_goal), yend = log(input$Conc_goal), 
                       x = 0, xend = input$Lsource *2.9,#max(df()$Distance,na.rm = TRUE)*1.1, 
                       line = list(dash = "dash",color='black'), showlegend=FALSE)%>%
          add_segments(y = log(min(c_raw))-0.5, yend = max(sen_lm()$model$Concentration)+1, 
                       x = input$Lsource, xend = input$Lsource,#max(df()$Distance,na.rm = TRUE)*1.1, 
                       line = list(dash = "dash",color='red'), showlegend=FALSE)%>%
          add_segments(y = log(min(c_raw))-0.5, yend = max(sen_lm()$model$Concentration)+1, 
                       x = input$Ltot+input$Lsource, xend = input$Ltot+input$Lsource,#max(df()$Distance,na.rm = TRUE)*1.1, 
                       line = list(dash = "dash",color='purple'), showlegend=FALSE)%>%
          add_trace(x= c(0,0),
                    y = c(log(min(c_raw))-0.5, max(sen_lm()$model$Concentration)+1) , 
                    name = 'Start Line',
                    type = "scatter", line = list(shape = 'linear',color='rgba(255, 0, 0, 0.4)'),
                    mode = 'lines',
                    hovertemplate = 'Source'
          )%>%
          add_trace(x= c(input$Lsource,input$Lsource),
                    y = c(log(min(c_raw))-0.5, max(sen_lm()$model$Concentration)+1) , 
                    name = ' ',
                    type = "scatter", line = list(shape = 'linear',color='rgba(255, 0, 0, 0.4)'),
                    mode = 'lines',
                    fill='tonexty',
                    fillcolor = 'rgba(255, 0, 0, 0.4)',
                    hovertemplate = paste('<br>Pumping Well <br> Distance: %{x:.0f} m')
          )%>%
          add_trace(x= c(input$Ltot+input$Lsource,input$Ltot+input$Lsource),#10%
                    y = c(log(min(c_raw))-0.5, max(sen_lm()$model$Concentration)+1) , 
                    name = ' ',
                    type = "scatter", #line = list(shape = "spline",color='rgb(31,119,180)'),
                    mode = 'lines',
                    fill='tonexty',
                    fillcolor = 'rgba(185,103,239,0.8)',
                    line = list(shape = 'linear',color='rgba(185,103,239,0.8)'),
                    hovertemplate =  paste('<br>Point of Compliance <br> Distance: %{x} m')
                    #hovertemplate = paste('<br>Year: %{x:.0f}', '<br>Concentration 10th %: %{y} ug/L<br>')
          )%>%
          add_trace(data = df(),
                    x= ~Distance,
                    y = ~log(Concentration) ,
                    name = ' ',
                    type = "scatter",
                    mode = 'markers',
                    text = ~Concentration,
                    marker = marker_plotly(color='rgb(31,150,180)'),
                    hovertemplate = paste('<br>Distance: %{x} m', '<br>Concentration: %{text:.2f} ug/L<br>'))

        p <- p%>%
          add_lines(data = sen_lm(),
                    x = sort(c(0, sen_lm()$model$Distance,input$Lsource,input$Lsource*2.9,Length),decreasing =TRUE), 
                    y = sort(c(predict(sen_lm(),data.frame(Distance = 0)),
                          fitted(sen_lm()),
                          predict(sen_lm(),data.frame(Distance = input$Lsource)),
                          predict(sen_lm(),data.frame(Distance = input$Lsource*2.9)),log(C_goal))),
                    text = c_raw,
                    line = list(color = 'rgb(31,150,180)',shape='spline'),
                    name = "Regression Line",
                    hovertemplate = paste('<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ug/L<br>'))

        #browser()
        # format the figure
        p <- p %>%
          # add_segments(y = log(input$Conc_goal), yend = log(input$Conc_goal),
          #              x = 0, xend = input$Lsource *2.9,#max(df()$Distance,na.rm = TRUE)*1.1,
          #              line = list(dash = "dash",color='black'), showlegend=FALSE)%>%
          # add_segments(y = log(min(c_raw))-0.5, yend = max(sen_lm()$model$Concentration)+1,
          #              x = input$Lsource, xend = input$Lsource,#max(df()$Distance,na.rm = TRUE)*1.1,
          #              line = list(dash = "dash",color='red'), showlegend=FALSE)%>%
          # add_segments(y = log(min(c_raw))-0.5, yend = max(sen_lm()$model$Concentration)+1,
          #              x = input$Ltot+input$Lsource, xend = input$Ltot+input$Lsource,#max(df()$Distance,na.rm = TRUE)*1.1,
          #              line = list(dash = "dash",color='purple'), showlegend=FALSE)%>%
          add_annotations(x = mean(df()$Distance*1.2,na.rm = TRUE),
                          y = log(input$Conc_goal*1.3),
                          text = paste0("Concentration Goal (",input$Conc_goal," ug/L)"),
                          xref = "x",
                          yref = "y",
                          font=list(size=15, color="black"),
                          showarrow=F)%>%
          add_annotations(x = input$Lsource,
                          y = max(sen_lm()$model$Concentration),
                          text = paste0("Pumping Well <br> (active)"),
                          xref = "x",
                          yref = "y",
                          xanchor = 'right',
                          font=list(size=15, color="red"),
                          showarrow=T)%>%
          add_annotations(x = input$Ltot+input$Lsource,
                          y = max(sen_lm()$model$Concentration),
                          text = paste0("Point of<br>Compilance"),
                          xref = "x",
                          yref = "y",
                          xanchor = 'right',
                          font=list(size=15, color="purple"),
                          showarrow=T)%>%
          add_annotations(x = input$Lsource/2,
                          y = log(min(c_raw)),
                          text = paste0("CONTAINMENT ZONE"),
                          xref = "x",
                          yref = "y",
                          xanchor = 'center',
                          font=list(size=15, color="red"),
                          showarrow=F)%>%
          add_annotations(x = (input$Ltot+input$Lsource*2)/2,
                          y = log(min(c_raw)),
                          text = paste0("PLUME ASSIMILATIVE <br> CAPACITY ZONE (L<sub>total</sub>)"),
                          xref = "x",
                          yref = "y",
                          xanchor = 'center',
                          font=list(size=15, color="purple"),
                          showarrow=F)%>%
          plotly::layout(
            title = title_plotly(paste0("<b>",input$group_method," Concentration of COC in Selected Wells Over Distance</b>")),
            #shapes = s,
            xaxis = list(title = "Distance (m)",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         showline=T,
                         mirror = "ticks",
                         range = c(0,input$Lsource *2.9)),
            yaxis = list(title = "Ln [COC Concentration (ug/L)]",
                         range=c(log(min(c_raw))-0.5, yend = max(sen_lm()$model$Concentration)+1),
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         showline=T,
                         zeroline = FALSE,
                         mirror = "ticks"
                         ), #type = "log",
            #tval = tval, ttxt = ttxt),
            showlegend = FALSE,
            margin = margin)


        p
      })
      
      
      # Summary Text ------------------
      output$asy_summary <- renderUI({
        req(df(),
            sen_lm())
        
        Distance_pump = input$Lsource
        Cthreshold = exp(as.numeric(sen_lm()$coefficients[1])+as.numeric(sen_lm()$coefficients[2])*Distance_pump)
        
        C_goal = input$Conc_goal
        
        Length = -log(C_goal/Cthreshold)/abs(as.numeric(sen_lm()$coefficients[2]))
        
        Ltotal = input$Ltot
        
        if (Length<=Ltotal){
          result =HTML(paste0('Estimated distance to reach concentration goal (',round(Length, digits = 0), ' m) is smaller than 
                              Plume Capacity Zone Length (', Ltotal, ' m), <font color="red"> Positive Line of Evidence for Transitioning to MNA. </font>'))
        }else{
          result =HTML(paste0('Estimated distance to reach concentration goal (',round(Length, digits = 0), ' m) is greater than 
                              Plume Capacity Zone Length (', Ltotal, ' m), <font color="red"> require further pumping.</font>'))
        }
        
   
        # HTML(paste0("<h3><Center>",
        #             result,".</Center></h3>",
        #             "<h3><Center> Total Length of Assimilative Capacity Zone is ",
        #             Ltotal,"m.</Center></h3>",
        #             "<h3><Center> Estimated distance to reach concentration goal is ",
        #             round(Length, digits = 0),"m.</Center></h3>"))
      })

      #browser()
      # p <- p%>%
      #   add_lines(data = sen_lm,x = sen_lm$model$Distance, y = (fitted(sen_lm)),
      #             line = list(color = 'rgb(31,150,180)',shape='spline'),
      #             name = "Entire Record")
      # 
      # # format the figure
      # p <- p %>%
      #   layout(
      #     title = title_plotly("<b>Average Concentration of COC in Selected Wells Over Distance</b>"),
      #     #shapes = s,
      #     xaxis = x_axis_fmt(title = "Distance (m)"),
      #     yaxis = y_axis_nofmt(title = "Ln COC Concentration<br>(ug/L)"), #type = "log",
      #     #tval = tval, ttxt = ttxt),
      #     showlegend = FALSE,
      #     margin = margin)
      # p

      # # Updates Values for Uncertainty Analysis ranges ---------------
      # lapply(
      #   X = 1:length(input$select_COC),
      #   FUN = function(i){
      #     observeEvent(input[[paste0("Rvalue_", i)]], {
      #       req(input$select_COC)
      #       Partition_Coeff = Constituents%>%filter(`Constituents Name`%in%sort(input$select_COC))
      #       Retardation_HK = 1 + input$Partition_Coeff[i] * 0.001 * 1.7/0.22
      #       updateNumericInput(session, paste0("Rvalue_", i), value = Retardation_HK)
      #       }
      #       )
      #   })#lapply
      }
  )
} # end Asymptote Server     