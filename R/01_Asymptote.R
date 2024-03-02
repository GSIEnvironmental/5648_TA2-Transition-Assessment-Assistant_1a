# Asymptote Modules -----------------------------
# For slope: https://www.usgs.gov/software/ktrline-kendall-theil-robust-line-software-page#:~:text=The%20Kendall-Theil%20robust%20line%20was%20selected%20because%20this,median%20of%20all%20possible%20pairwise%20slopes%20between%20points.
## UI -----------------------------------------
AsymptoteUI <- function(id, label = "01_Asymptote"){
  ns <- NS(id)
  
  tabPanel("1. Asymptote",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 1. Am I Approaching a Concentration vs Time Asymptotic Condition at My Site?</h1></b>"),
                    column(5,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4><ol>
                           <li> It calculates source attenuation rates from a monitoring well’s concentration vs. time data.</li> 
                           <li> It provides a range of time to clean estimates based on a cleanup goal you enter.</li>
                           <li> It helps you determine if asymptotic conditions are present at this location.</li>
                                </ol></h4>")),
                    column(5,
                           HTML("<h3><b>How Does it Work?</b></h3>
                           <h4><ol>
                           <li> Enter your monitoring well’s concentration vs. time data under the 'Data Input' tab.</li> 
                           <li> Go through Steps 1-5 to see rates, time to clean, and asymptote Lines of Evidence.</li>
                                </ol></h4>"))), # end Page Title
           fluidRow(br(),
             # Instructions and General Inputs --------------
             column(3,
                    fluidRow(column(10, 
                                    HTML("<h4><b>Step 1.</b> Enter Data. See 'Data Input' tab for more information</h4>")),
                             # column(2, align = "left", style = "padding:10px;",
                             #        actionButton(ns("help1"), HTML("?"), style = button_style2))
                             ), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 2.</b> Select Wells to be included in analysis.</h4>"),
                                    fluidRow(align = "center",
                                             radioButtons(ns("select_group_type"), label = NULL,
                                                          choices = c("Individual Wells" = "individual",
                                                                      "Well Groups" = "groups"),
                                                          inline = T),
                                             br(),
                                             pickerInput(ns("select_mw"), label = NULL,
                                                         choices = c(""),
                                                         multiple = T,
                                                         selected = "",
                                                         options = list(`live-search`=TRUE,
                                                                        `none-selected-text` = "Select Wells")))),
                             # column(2, align = "left", style = "padding:10px;",
                             #        actionButton(ns("help2"), HTML("?"), style = button_style2))
                             ), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 3.</b> Choose COC.</h4>"),
                                    fluidRow(align = "center",
                                             column(12, align = "right", 
                                                    pickerInput(ns("select_COC"), label = NULL,
                                                                choices = c(),
                                                                multiple = T,
                                                                options = list(`live-search`=TRUE,
                                                                               `none-selected-text` = "Select COCs")))))
                             ), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 4.</b> Select method for combining data collected on the same day.</h4>"),
                                    fluidRow(align = "center",
                                             radioButtons(ns("group_method"), label = NULL,
                                                          choices = c("Geomean", "Mean"),
                                                          selected = "Geomean",
                                                          inline = T))),
                             # column(2, align = "left", style = "padding:10px;",
                             #        actionButton(ns("help3"), HTML("?"), style = button_style2))
                             ), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 5.</b> Select the concentration goal.</h4>"),
                                    fluidRow(
                                      column(6, align = "right", 
                                             numericInput(ns("conc_goal"), label = NULL,
                                                 value = NULL, min = 0, step = 0.01,
                                                 width = "80px")),
                                      column(6, align = "left", 
                                             htmlOutput(ns("unit"))))),
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help1_1"), HTML("?"), style = button_style2))), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 6.</b> Select date range for data.</h4>"),
                                    dateRangeInput(ns("date_range"), label = NULL,
                                                   start = "1900-01-01", end = Sys.Date())),
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help1_2"), HTML("?"), style = button_style2))),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 7.</b> Select Confidence Inteval (max 0.99).</h4>"),
                                    fluidRow(
                                      column(6, align = "right", 
                                             numericInput(ns("CI_input"), label = NULL,
                                                          value = 0.95, min = 0, step = 0.01,
                                                          width = "80px")))),
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help1_3"), HTML("?"), style = button_style2))), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 8.</b> Select breakpoint between two different time periods.</h4>"),
                                    HTML("<p><i>Breakpoint is indicated on plot with a dotted line. To manually select a breakpoint click data point on plot.To deselect, double click the figure where there is no data point.</i></p>")),
                             # column(2, align = "left", style = "padding:10px;",
                             #        actionButton(ns("help5"), HTML("?"), style = button_style2))
                             ),
                    HTML("<hr class='featurette-divider'>"),
                    HTML("<h4><b>Key Assumptions</b></h4>
                         <ol>
                         <li> The source attenuation trends can be represented by a first order decay relationship.</li>
                         <li> The upper bound of the source attenuation rate is given by the confidence interval selected in Step 7.</li>
                         <li> Five simple rules of thumb (heuristics) can provide evidence that for all practical purposes an asymptote in the concentration vs. time data has been reached.</li></ol>")#,
                    # HTML("<hr class='featurette-divider'>"),
                    # HTML("<h4><b>Authors</b></h4>
                    #      Charles Newell and Tom McHugh, GSI Environmental. Contact: temchugh@gsi-net.com")
             ), #end instruction column
             column(9,
                    tabsetPanel(
                      tabPanel("Results", br(),
                               # Overall Results
                               plotlyOutput(ns('ts_plot1'), height = "600px"), br(),
                               HTML("<hr class='featurette-divider'>"),
                               HTML("<h2><b>Overall Results</b></h2>"),
                               gt_output(ns("rates_table")), br(),
                               HTML("<hr class='featurette-divider'>"),
                               # Asymptotic Analysis -------------------------
                               HTML("<h2><b>Asymptote Analysis</b></h2>"),
                               HTML("Why the interest in Asymptotes?  From the  National Research Council, 2013:<br><br>
                                    <i>“Specifically, if data indicate that contaminant concentrations are approaching an <b>asymptote</b>, resulting in exponential increases in the unit cost of the remedy, then there is limited benefit in its continued operation.”<br><br>
                                    “If <b>asymptotic conditions</b> have occurred, a transition assessment is performed.”</i>"), br(), br(),
                               fluidRow(align = "center",
                               gt_output(ns("LOE_Table")), br(), 
                               uiOutput(ns("asy_summary")))),
                      tabPanel("Data", br(),
                               tabsetPanel(
                                 tabPanel(HTML("1. Concentration and Time Data"), br(),
                                          rHandsontableOutput(ns("conc_time_data"))
                                          ), # end concentration and time table
                                 tabPanel(HTML("2. Monitoring Well Information"), br(),
                                          rHandsontableOutput(ns("mw_data"))
                                          ) # end concentration and time table
                               ))), br(), br(),
           fluidRow(align = "center",
                    downloadButton(ns("save_data"),
                                 HTML("Save Data and Analysis"), style = button_style)), br())
           )
  ) # end tab panel
} # end Asymptote UI         


## Server Module -----------------------------------------
AsymptoteServer <- function(id, data_input, nav) {
  moduleServer(
    id,
    
    function(input, output, session) {
      # RV: Concentration and Time Data -----------
      d_conc <- reactiveVal(data_long(temp_data))

      observeEvent(data_input$d_conc(),{
        d_conc(data_input$d_conc())
      }) # end d_conc()

      # RV: Location Data -----------------------
      d_loc_T1 <- reactiveVal(data_mw_clean(temp_mw_info_tool1))

      observeEvent(data_input$d_loc_T1(),{
        d_loc_T1(data_input$d_loc_T1())
      }) # end d_loc_T1()
      
      # RV: Merge d_loc_T1 and d_conc -----------------------
      d_mer <- reactiveVal()
      
      observeEvent({
        d_loc_T1()
        d_conc()},{
          d_mer(data_merge(d_conc(), d_loc_T1()))
        }) # end d_mer()
      
      # RV: Series Avg Data ---------------
      df <- reactiveVal()
      
      observe({
        req(d_conc(),
            input$select_mw,
            input$group_method,
            input$date_range,
            input$select_COC)
        
        ave_switch <- input$group_method
        
        # Filter to Wells/Grouping
        if(input$select_group_type == "individual"){
          df_MW <- d_mer() %>%
            filter(WellID %in% input$select_mw|`Well Grouping` %in% input$select_mw,
                   Date >= input$date_range[1],
                   Date <= input$date_range[2],
                   COC%in%input$select_COC)
        }
        
        if(input$select_group_type == "groups"){
          df_MW <- d_mer() %>%
            filter(`Well Grouping` %in% input$select_mw|WellID%in%input$select_mw,
                   Date >= input$date_range[1],
                   Date <= input$date_range[2],
                   COC%in%input$select_COC) 
        }
        
        # Apply Selected Avg. Method
        if (ave_switch == 'Mean'){
          df_MW <- df_MW %>% group_by(Date) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE))
        }
        
        if (ave_switch == 'Geomean'){
          df_MW <- df_MW %>% group_by(Date) %>%
            summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE)))
        }
        
        # Add Period if breakpoint if available 
        if(!is.null(bp()$x)){
          df_MW <- df_MW %>%
            mutate(period = ifelse(Date <= bp()$x, "Period 1", "Period 2"))
        }
        
        df(df_MW)
      }) # end df()
      
      # RV: Breakpoint ---------------
      bp <- reactiveVal()
      
      observeEvent(event_data(event = "plotly_click", source = "ts_selected"),{
        req(df())
        bp(event_data(event = "plotly_click", source = "ts_selected"))
        print (bp())
      })
      
      observeEvent(event_data(event = "plotly_doubleclick", source = "ts_selected"),{
        req(df())
        bp(NULL)
        print ('bp')
      })
      
      # RV: Sen Trend Model ---------------
      sen_lm <- reactiveVal()
    
      observe({
        req(length(df()$Concentration) > 2)
        cd <- sen_trend(df())
        cd_sen <- list(`Entire Record` = cd)
        
        # If Breakpoint is chosen by user 
        if(!is.null(bp())){
          # Calculate trend for first period
          df_1 <- df() %>% filter(Date <= bp()$x)
          if(length(df_1$Concentration) > 2){
            cd_1 <- sen_trend(df_1)
            cd_sen <- c(cd_sen, list(`Period 1`= cd_1))
          }
          
          # Calculate trend for second period
          df_2 <- df() %>% filter(Date > bp()$x)
          if(length(df_2$Concentration) > 2){
            cd_2 <- sen_trend(df_2)
            cd_sen <- c(cd_sen, list(`Period 2` = cd_2))
          }
        }
        sen_lm(cd_sen)
      })
      
      # RV: Cleanup Forecast--------------------
      sen_table <- reactiveVal()
      
      observeEvent({
        sen_lm()
        input$conc_goal
        input$CI_input},{
          req(sen_lm(),
              input$conc_goal > 0)
          
          cd <- map_dfr(1:length(sen_lm()), ~{
            forecasted_clean(sen_lm()[[.x]], input$conc_goal, input$CI_input) %>%
              mutate(type = names(sen_lm())[.x])
          })
          print (cd)
          sen_table(cd)
      })
      
      # RV: Results of Asymptotic Analysis --------------
      asy_results <- reactiveVal()
      
      observe({
        req(df(),
            bp(),
            sen_lm(),
            input$CI_input,
            length(df() %>% filter("period" == "Period 1")) > 2,
            length(df() %>% filter("period" == "Period 2")) > 2)
        
        if (bp()$pointNumber>2){
          results <- Asymptote_Analysis(df(), sen_lm(),input$CI_input,'two.sided') 
        }else{
          results <-NULL
        }
        asy_results(results)
      })
      
      
      # Well Selection Updates -----------------------
      observe({
        req(nav() == "1. Asymptote")
        req(d_conc())
        
        if(input$select_group_type == "individual"){
          choices <- sort(unique(d_conc()$WellID))
        }
        
        if(input$select_group_type == "groups"){
          choices <- sort(unique(d_loc_T1()$`Well Grouping`))
        }
                      
        updatePickerInput(session, "select_mw", choices = choices,
                          selected = "")
      }) # end update well selection
      
      # Date Range Updates -------------------
      observe({
        req(nav() == "1. Asymptote")
        req(d_conc())

        updateDateRangeInput(session, "date_range", 
                             start = min(d_conc()$Date, na.rm = T),
                             end = max(d_conc()$Date, na.rm = T))
        output$unit<- renderUI({
          HTML(paste0("<h4>",unique(d_conc()$Units),"</h4>",sep=''))
        })
      }) # end update well selection
      
      # COC Selection Updates -----------------------
      observe({
        req(nav() == "1. Asymptote")
        req(d_conc())

        if (input$select_group_type=='groups'){
          listwell = d_loc_T1()%>%filter(`Well Grouping` %in% input$select_mw|`Monitoring Wells` %in% input$select_mw)
          COC_unique<-d_conc()%>%filter(WellID%in%listwell$`Monitoring Wells`)
        }else{
          COC_unique<-d_conc()%>%filter(WellID%in%input$select_mw)
        }
        choices <- sort(unique(COC_unique$COC))
        updatePickerInput(session, "select_COC", choices = choices)
        
      }) # end update well selection
      
      p = plot_ly(source = 'ts_selected')
      
      # Plot 1 ------------------
      output$ts_plot1 <- renderPlotly({
        validate(need(d_conc(), "Please enter data into the Data Input tab (Step 1)."))
        validate(need(input$select_mw, "Please select wells or well grouping to analyze (Step 2)."))
        validate(need(input$select_COC, "Please select COC (Step 3)."))
        
        req(df(),
            sen_lm(),
            input$CI_input)
        
        unit = unique(d_conc()$Units)

        logscale_figure(df(), name = input$group_method, sen = sen_lm(), bp = bp()$x,fit = sen_lm(),CI = input$CI_input,unit = unit)
      })
      
      # Attenuation Rates Table -------------------------
      output$rates_table <- render_gt({
        req(input$select_mw)
        validate(need(input$select_COC, "Please select COC (Step 3)"))
        validate(need(length(df()$Concentration) > 2, "Insufficent data to calculate rate. Make sure at least 2 data points are present."))
        validate(need(input$conc_goal > 0, "Please select a valid concentration goal (Step 5)"))
        req(sen_table())
        
   
        cd <- sen_table() %>%
          mutate(year_0.1 = ifelse(slope_LCL<0,year_LCL,'Increasing'),
                 year_0.9 = ifelse(slope_UCL<0,year_UCL,'Increasing'),
                 pearson_model = signif(pearson_model,3),
                 pvalue = signif(pvalue_model,3),
                 interpretation = case_when( pearson_model>=0.8|pearson_model<=-0.8&pvalue_model<0.05~ 'Very High Correlation, Statistically Significant',
                                            (pearson_model<0.8& pearson_model>=0.6&pvalue_model<0.05)|(pearson_model<=-0.6& pearson_model>-0.8&pvalue_model<0.05) ~ 'High Correlation, Statistically Significant',
                                            (pearson_model<0.6& pearson_model>=0.4&pvalue_model<0.05)|(pearson_model<=-0.4& pearson_model>-0.6&pvalue_model<0.05) ~ 'Moderate Correlation, Statistically Significant',
                                            (pearson_model<0.4& pearson_model>=0.2&pvalue_model<0.05)|(pearson_model<=-0.2& pearson_model>-0.4&pvalue_model<0.05) ~ 'Low Correlation, Statistically Significant',
                                            (pearson_model<0.2& pearson_model>=0&pvalue_model<0.05)|(pearson_model<=0& pearson_model>-0.2&pvalue_model<0.05) ~ 'Very Low Correlation, Statistically Significant',
                                             pearson_model>=0.8|pearson_model<=-0.8&pvalue_model>=0.05~ 'Very High Correlation, Statistically Not Significant',
                                            (pearson_model<0.8& pearson_model>=0.6&pvalue_model>=0.05)|(pearson_model<=-0.6& pearson_model>-0.8&pvalue_model>=0.05) ~ 'High Correlation Statistically Not Significant',
                                            (pearson_model<0.6& pearson_model>=0.4&pvalue_model>=0.05)|(pearson_model<=-0.4& pearson_model>-0.6&pvalue_model>=0.05) ~ 'Moderate Correlation Statistically Not Significant',
                                            (pearson_model<0.4& pearson_model>=0.2&pvalue_model>=0.05)|(pearson_model<=-0.2& pearson_model>-0.4&pvalue_model>=0.05) ~ 'Low Correlation Statistically Not Significant',
                                            (pearson_model<0.2& pearson_model>=0&pvalue_model>=0.05)|(pearson_model<=0& pearson_model>-0.2&pvalue_model>=0.05) ~ 'Very Low Correlation Statistically Not Significant'
                                            )
                 )%>%
          select(type, rate_model, year_model, year_0.9)
          #select(type, rate_model, year_0.1, year_model, year_0.9, pearson_model, pvalue,interpretation)
    
        gt(cd, rowname_col = "type") %>%
          tab_spanner(label = "Estimated Time-to-Clean",
                      columns = starts_with("year"), gather = T) %>%
          cols_label(rate_model = HTML("First Order Source Attenuation Rates<br>(per year)"),
                     #year_0.1 = "Lower Bound Year",
                     year_model = "Year",
                     year_0.9 = "Upper Bound Year"
                     #pearson_model = HTML("Pearson's<br>Correlation<br>Coefficient (r)"),
                     #pvalue = 'p-value',
                     #interpretation = HTML('Correlation<br>Strength')
                     ) %>%
          fmt_number(columns = rate_model, n_sigfig = 3) %>%
          tab_source_note(source_note = "Lower and upper bound years based on 95% confidence interval.")%>%
          tab_source_note(source_note = "Cell says 'increasing' when the apparent concentration trend is increasing over time.")%>%
          tab_style(style = style_body(),
                    locations = cells_body()) %>%
          tab_style(style = style_col_labels(),
                    locations = cells_column_labels()) %>%
          opt_table_outline() %>%
          # GT bug fix
          tab_options(table.additional_css = "th, td {padding: 5px 10px !important;	border: 1px solid white;}" )
          
      })
      
      
      
      # LOE Table -------------------------
      output$LOE_Table <- render_gt({
        req(input$select_mw)
        # calculate binary segmentation
        #browser()
        validate(need(length(df()$Concentration)>1,paste0("The selected well/s have no time series data.")))
        fit_changepoint = cpt.mean(df()$Concentration,method='BinSeg',Q=1)
        # Return estimates
        fitcp_tbl = c(ints = param.est(fit_changepoint)$mean,
                      cp = cpts(fit_changepoint))
       
        validate(need(bp()$x, paste0("Please select a breakpoint between two different time periods in the above figure.\n",
                                     "Binary Segmentation suggest change point at ",
                                     as.character(as.Date(df()[as.numeric(fitcp_tbl[3]),]$Date)),sep='')))
        # validate(need(dim(df() %>% filter("period" == "Period 2"))[1] > 2, "Period 1 must have at least 2 data points."))
        # validate(need(dim(df() %>% filter("period" == "Period 2"))[1] > 2, "Period 2 must have at least 2 data points."))
        
        #print(df())

        #print(as.data.frame(df()) %>% filter("period" == "Period 2"))
        #print(length(df() %>% filter("period" == "Period 2")) > 2)
        req(df(), 
            bp(),
            sen_lm())
        
        validate(need(bp()$pointNumber>2,"Please select a breakpoint has more than two points for each segment"))
        
        results <- asy_results()
        
        cd <- data.frame(LOE = c("1. Are the two rates of attenuation for the two periods significantly different?",
                                 "2. Is attenuation rate in period 2 significantly close to 0?",
                                 "3. Is the attenuation rate of the first period more than two times the second rate?",
                                 "4. Is the the absolute difference between the last points on each regression line less than 10?",
                                 "5. Is the period 2 attenuation rate less than 0.0693 per year (10 year half-life)?"),
                         Condition = 1:5)
        
        cd <- left_join(cd, results, by = "Condition") %>% select(-Condition) %>%
          mutate(LOE = map(LOE, gt::html))
          
        
        gt(cd) %>%
          cols_label(LOE = "Possible Asymptotic Conditions",
                     Met = "Is the Condition Met?") %>%
          cols_width(LOE ~ px(700)) %>%
          tab_style(style = style_body(),
                    locations = cells_body(columns = Met)) %>%
          tab_style(style = list(cell_text(weight = "bold",
                                           color = "white"),
                                 cell_fill(color = col["purple"])),
                    locations = cells_body(columns = Met,
                                           rows = Met == "YES")) %>%
          tab_style(style = style_body("left"),
                    locations = cells_body(columns = LOE)) %>%
          tab_style(style = style_col_labels(),
                    locations = cells_column_labels()) %>%
          opt_table_outline() %>%
          # GT bug fix
          tab_options(table.additional_css = "th, td {padding: 5px 10px !important;	border: 1px solid white;}" )
        
        
      })
      
      # Asymptotic Summary Text ------------------
      output$asy_summary <- renderUI({
        req(df(),
            bp(),
            sen_lm(),
            length(df() %>% filter("period" == "Period 1")) > 2,
            length(df() %>% filter("period" == "Period 2")) > 2)
        
        validate(need(!is.null(asy_results()),""))
        results <- asy_results() %>% 
          mutate(Met = (Met == "YES"))
        
        HTML(paste0("<h3><b style='color:", col["purple"],"'>", sum(results$Met,na.rm=TRUE), "</b> of the <b style='color:", col["purple"],"'>5</b> possible asymptotic conditions are present.</h3>"))
      })
      
      # Save Dataframes --------------------
      
      output$save_data <- downloadHandler(
        
        filename = function() {
          paste0("Asymptote_Results", ".xlsx")
        },
        content = function(file) {
          
          parameter_tbl<-data.frame(
            'select_mw' = input$select_mw,
            'select_group_type' = input$select_group_type,
            'start' = input$date_range[1],
            'end' = input$date_range[2],
            'conc_goal' = input$conc_goal,
            'group_method' = input$group_method,
            'CI_input' = input$CI_input,
            'unit' = unique(d_conc()$Units)
            
            
          )
          result = sen_table()%>%
            mutate(rate_model = signif(rate_model,3),
                   `Lower Bound Year` = ifelse(slope_LCL<0,year_LCL,'Increasing'),
                   `Upper Bound Year` = ifelse(slope_UCL<0,year_UCL,'Increasing'),
                   `Pearson's Correlation Coefficient (r)` = signif(pearson_model,3),
                   `p-value` = signif(pvalue_model,3),
                   `Correlation Strength` = case_when( pearson_model>=0.8|pearson_model<=-0.8&pvalue_model<0.05~ 'Very High Correlation, Statistically Significant',
                                               (pearson_model<0.8& pearson_model>=0.6&pvalue_model<0.05)|(pearson_model<=-0.6& pearson_model>-0.8&pvalue_model<0.05) ~ 'High Correlation, Statistically Significant',
                                               (pearson_model<0.6& pearson_model>=0.4&pvalue_model<0.05)|(pearson_model<=-0.4& pearson_model>-0.6&pvalue_model<0.05) ~ 'Moderate Correlation, Statistically Significant',
                                               (pearson_model<0.4& pearson_model>=0.2&pvalue_model<0.05)|(pearson_model<=-0.2& pearson_model>-0.4&pvalue_model<0.05) ~ 'Low Correlation, Statistically Significant',
                                               (pearson_model<0.2& pearson_model>=0&pvalue_model<0.05)|(pearson_model<=0& pearson_model>-0.2&pvalue_model<0.05) ~ 'Very Low Correlation, Statistically Significant',
                                               pearson_model>=0.8|pearson_model<=-0.8&pvalue_model>=0.05~ 'Very High Correlation, Statistically Not Significant',
                                               (pearson_model<0.8& pearson_model>=0.6&pvalue_model>=0.05)|(pearson_model<=-0.6& pearson_model>-0.8&pvalue_model>=0.05) ~ 'High Correlation Statistically Not Significant',
                                               (pearson_model<0.6& pearson_model>=0.4&pvalue_model>=0.05)|(pearson_model<=-0.4& pearson_model>-0.6&pvalue_model>=0.05) ~ 'Moderate Correlation Statistically Not Significant',
                                               (pearson_model<0.4& pearson_model>=0.2&pvalue_model>=0.05)|(pearson_model<=-0.2& pearson_model>-0.4&pvalue_model>=0.05) ~ 'Low Correlation Statistically Not Significant',
                                               (pearson_model<0.2& pearson_model>=0&pvalue_model>=0.05)|(pearson_model<=0& pearson_model>-0.2&pvalue_model>=0.05) ~ 'Very Low Correlation Statistically Not Significant'
                   )
            )%>%
            select(type, rate_model, `Lower Bound Year`, year_model, `Upper Bound Year`, 
                   `Pearson's Correlation Coefficient (r)`, `p-value`,`Correlation Strength`)%>%
            rename(`First Order Source Attenuation Rates (per year)` = rate_model,
                   `Year` = year_model)
          # result = rownames_to_column(as.data.frame(t(result)),"variable")
          # colnames(result)<-result[1,]
          # result <- result[2:nrow(result),]
          
          
            list_of_datasets<-list(
              "Ave Concentration" = as.data.frame(df()),
              "Location" = data_input$d_loc_T1()%>%filter(`Monitoring Wells`%in%input$select_mw),
              "parameters" = parameter_tbl,
              "Overall Results" = result,
              "Asymptote Analysis" = as.data.frame(asy_results())
              
            )
          
          
          write.xlsx(list_of_datasets, file)
          
          
        }
        
      )
      
      #----- help function 
      lapply(
        X = 1:3,
        FUN = function(i){
          observeEvent(input[[paste0("help1_", i)]], {
            flname <-as.character(figure_list_1[i])
            Helpboxfunction(flname,Y='"./01_Asymptote/')
          })
        }
      )
      
      # Data ----------------
      output$conc_time_data <- renderRHandsontable({
        validate(
          need(data_input$d_conc(), "Please enter data into Data Input tab (Step 1)."))
  
        loc_name<-data_input$d_loc_T1()%>%
          filter(`Monitoring Wells`%in%input$select_mw|`Well Grouping`%in%input$select_mw)
        
        tbl_name <- data_input$d_conc()%>%
          rename(`Date (Month/Day/Year)`=Date)%>%
          filter(WellID%in%loc_name$`Monitoring Wells`&COC%in%input$select_COC)
       
        rhandsontable(tbl_name, readOnly = T, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })
      
      output$mw_data <- renderRHandsontable({
        validate(
          need(data_input$d_loc_T1(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."))

        loc_name<-data_input$d_loc_T1()%>%
          filter(`Monitoring Wells`%in%input$select_mw|`Well Grouping`%in%input$select_mw)
        
        rhandsontable(loc_name, readOnly = T, rowHeaders = NULL, width = 1000, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })

      
      # Return Dataframes ------------------
      
      return(list(
        LOE_asymp = reactive({
          req(asy_results())
          results = asy_results() %>% 
            mutate(Met = (Met == "YES"))})
        ))
      
    }
  )
} # end Asymptote Server  
