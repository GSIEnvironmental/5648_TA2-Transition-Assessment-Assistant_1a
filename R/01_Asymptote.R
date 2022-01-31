# Asymptote Modules -----------------------------
# For slope: https://www.usgs.gov/software/ktrline-kendall-theil-robust-line-software-page#:~:text=The%20Kendall-Theil%20robust%20line%20was%20selected%20because%20this,median%20of%20all%20possible%20pairwise%20slopes%20between%20points.
## UI -----------------------------------------
AsymptoteUI <- function(id, label = "01_Asymptote"){
  ns <- NS(id)
  
  tabPanel("1. Asymptote",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 1. Has a concentration vs time asymptote been reached at my site?</h1></b>"),
                    column(5,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4><ol>
                           <li> It calculates source attenuation rates from a monitoring well’s concentration vs. time data.</li> 
                           <li> Provides a range of time to clean estimates based on a cleanup goal you enter.</li>
                           <li> Helps you determine if asymptotic conditions are present at this location.</li>
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
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help1"), HTML("?"), style = button_style2))), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 2.</b> Select Wells to be included in analysis.</h4>"),
                                    fluidRow(align = "center",
                                             pickerInput(ns("select_mw"), label = NULL,
                                                         choices = c(),
                                                         multiple = T,
                                                         options = list(`live-search`=TRUE,
                                                                        `none-selected-text` = "Select Wells")))),
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help2"), HTML("?"), style = button_style2))), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 3.</b> Select method for combining data collected on the same day.</h4>"),
                                    fluidRow(align = "center",
                                             radioButtons(ns("group_method"), label = NULL,
                                                          choices = c("Geomean", "Mean"),
                                                          selected = "Geomean",
                                                          inline = T))),
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help3"), HTML("?"), style = button_style2))), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 4.</b> Select the concentration goal.</h4>"),
                                    fluidRow(
                                      column(6, align = "right", 
                                             numericInput(ns("conc_goal"), label = NULL,
                                                 value = NULL, min = 0, step = 0.01,
                                                 width = "80px")),
                                      column(6, align = "left", 
                                             HTML("<h4>ug/L</h4>")))),
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help4"), HTML("?"), style = button_style2))), br(),
                    fluidRow(column(10,
                                    HTML("<h4><b>Step 5.</b> Select breakpoint between two different time periods.</h4>
                                         <p>You can calculate First Order Decay Coefficents for the entire record and two different time intervals, such as before, during, or after remediation.</p>")),
                             column(2, align = "left", style = "padding:10px;",
                                    actionButton(ns("help5"), HTML("?"), style = button_style2))),
                    HTML("<hr class='featurette-divider'>"),
                    HTML("<h4><b>Key Assumptions</b></h4>
                         <ol>
                         <li> The source attenuation trends can be represented by a first order decay relationship.</li>
                         <li> The range of the source attenuation rate is bounded by a 90% confidence level</li>
                         <li> Four simple rules of thumb (heuristics) can provide evidence that for all practical purposes an asymptote in the concentration vs. time data has been reached.</li></ol>")#,
                    # HTML("<hr class='featurette-divider'>"),
                    # HTML("<h4><b>Authors</b></h4>
                    #      Charles Newell and Tom McHugh, GSI Environmental. Contact: temchugh@gsi-net.com")
             ), #end instruction column
             column(9,
             tabsetPanel(
               # Overall Results -----------------------------
               tabPanel("Overall Results",
                        plotlyOutput(ns('ts_plot1'), height = "600px"), br(),
                        gt_output(ns("rates_table"))), 
               # Asymptote Analysis -------------------------
               tabPanel("Asymptote Analysis", br(),
                        fluidRow(
                          column(6,
                                 HTML("Why the interest in Asymptotes?  From the  National Research Council, 2013:")),
                          # column(6,
                          #        actionButton(ns("help4"), HTML("?"), style = button_style2))
                          ),
                        HTML("<i>“Specifically, if data indicate that contaminant concentrations are approaching an <b>asymptote</b>, resulting in exponential increases in the unit cost of the remedy, then there is limited benefit in its continued operation.”<br><br>
                              “If <b>asymptotic conditions</b> have occurred, a transition assessment is performed.”</i>"),
                        HTML("<hr class='featurette-divider'>"),
                        plotlyOutput(ns('ts_plot2'), height = "600px"), br(),
                        gt_output(ns("LOE_Table"))
                        )), br(),
             fluidRow(align = "center",
                      actionButton(ns("save_data"),
                                   HTML("Save Data and Analysis"), style = button_style))
             ) # end results column
           ), br()
  ) # end tab panel
} # end Asymptote UI         


## Server Module -----------------------------------------
AsymptoteServer <- function(id, data_input, nav) {
  moduleServer(
    id,
    
    function(input, output, session) {
      # Reactive Variables -----------------
      # Concentration and Time Data (pivoting long)
      d_conc_long <- reactiveVal()
      
      observeEvent(data_input$d_conc(),{
        d_conc_long(data_input$d_conc() %>% 
                      select(where(~!all(is.na(.x)))) %>% # removing columns with no data
                      filter(!if_all(starts_with("MW-"), ~is.na(.))) %>% #removing events with all NAs
                      pivot_longer(cols = c(-"Event", -"Date", -"COC", -"Units"), 
                                   names_to = "WellID", values_to = "Concentration")) 
      }) # end d_conc_long()
      
      # Location Data
      d_loc <- reactiveVal()
      
      observeEvent(data_input$d_loc(),{
        d_loc(data_input$d_loc() %>% filter(!is.na(`Monitoring Wells`)))
      }) # end d_loc()
      
      # Series Data
      df <- reactiveVal()
      
      observe({
        req(d_conc_long(),
            input$select_mw,
            input$group_method)
        
        ave_switch <- input$group_method
        
        df_MW <- d_conc_long() %>%
          filter(WellID %in% input$select_mw) #%>%
          # mutate(Date = as.Date(Date))
        
        if (ave_switch == 'Mean'){
          df_MW <- df_MW %>% group_by(Date) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE))
        }
        
        if (ave_switch == 'Geomean'){
          df_MW <- df_MW %>% group_by(Date) %>%
            summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE)))
        }
        
        df(df_MW)
      }) # end df()
      
      # Period 1 Data
      df_1 <- reactiveVal()
      
      # Period 2 Data
      df_2 <- reactiveVal()
      
      
      # Select Updates --------------
      # Well Selection
      observe({
        req(nav() == "1. Asymptote")
        req(d_conc_long())
        
        choices <- sort(unique(d_conc_long()$WellID))
        
        # if(!is.null(d_loc())){
        #   print(d_loc())
        #   selected <- sort(unique(d_loc() %>% filter(`Downgradient Well` == T)))
        # }else{
        #   selected <- c()
        # }
                         
        updatePickerInput(session, "select_mw",
                          choices = choices)
      }) # end update well selection
      
      # Plot 1 ------------------
      output$ts_plot1 <- renderPlotly({
        req(df())
        df_MW <- df()
        # create y axis as log
        tval <- sort(as.vector(sapply(seq(1,9), 
                                      function(x) 
                                        x*10^seq(floor(log10(min(df_MW$Concentration,na.rm=TRUE))),
                                                 ceiling(log10(max(df_MW$Concentration,na.rm=TRUE))))))) #generates a sequence of numbers in logarithmic divisions
        
        ttxt <- rep(" ",length(tval))  # no label at most of the ticks
        ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled

        p <- plot_ly() %>%
          add_trace(data = df_MW, x= ~Date,
                    y = ~Concentration ,
                    name = ' ',
                    type = "scatter", 
                    mode = 'markers',marker = list(color='rgb(31,150,180)'),
                    hovertemplate = paste('<br>Date: %{x}', '<br>Concentration: %{y:.2f} ug/L<br>')) %>%
          layout(
            xaxis = list(title="Year",
                         automargin = T,
                         showline=T,
                         mirror = "ticks",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         zeroline=F),
            yaxis = list(title="COC Concentration at <br> Monitoring Well (ug/L)",
                         type ='log',
                         range = c(floor(log10(min(df_MW$Concentration,na.rm=TRUE))),
                                   ceiling(log10(max(df_MW$Concentration,na.rm=TRUE)))),
                         tickvals=tval,
                         ticktext=ttxt,
                         showline=T,
                         mirror = "ticks",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         zeroline=F),
            showlegend = FALSE,
            dragmode = "select", selectdirection = "h")
        p
      })
      
      # Attenuation Rates Table -------------------------
      output$rates_table <- render_gt({
        cd <- data.frame(Time = c("Entire Record", "Period 1", "Period 2"),
                         Rates = c(0, 0, 0),
                         Year = c(0, 0, 0),
                         Lower_Year = c(0, 0, 0),
                         Upper_Year = c(0, 0, 0))
        
        gt(cd) %>%
          # tab_spanner(label = "Forecasted Time-to-Clean", 
          #             columns = c("Year", "Lower_Year", "Upper_Year"), gather = T) %>%
          cols_label(Time = "",
                     Rates = "First Order Source Attenuation Rates<br>(per year)",
                     Year = "Most Likely Year",
                     Lower_Year = "Lower Bound",
                     Upper_Year = "Upper Bound") %>%
          tab_style(style = list(cell_borders(sides = "all",
                                         style = "solid",
                                         weight = px(2),
                                         color = "#D3D3D3"),
                                 cell_text(align = "center",
                                           v_align = "middle")),
                    locations = cells_body()) 
      })
      
      # Plot 2 ------------------
      output$ts_plot2 <- renderPlotly({
        req(df())
        df_MW <- df()
        # create y axis as log
        tval <- sort(as.vector(sapply(seq(1,9), 
                                      function(x) 
                                        x*10^seq(floor(log10(min(df_MW$Concentration,na.rm=TRUE))),
                                                 ceiling(log10(max(df_MW$Concentration,na.rm=TRUE))))))) #generates a sequence of numbers in logarithmic divisions
        
        ttxt <- rep(" ",length(tval))  # no label at most of the ticks
        ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
        
        p <- plot_ly() %>%
          add_trace(data = df_MW, x= ~Date,
                    y = ~Concentration ,
                    name = ' ',
                    type = "scatter", 
                    mode = 'markers',marker = list(color='rgb(31,150,180)'),
                    hovertemplate = paste('<br>Date: %{x}', '<br>Concentration: %{y:.2f} ug/L<br>')) %>%
          layout(
            xaxis = list(title="Year",
                         automargin = T,
                         showline=T,
                         mirror = "ticks",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         zeroline=F),
            yaxis = list(title="COC Concentration at <br> Monitoring Well (ug/L)",
                         type ='log',
                         range = c(floor(log10(min(df_MW$Concentration,na.rm=TRUE))),
                                   ceiling(log10(max(df_MW$Concentration,na.rm=TRUE)))),
                         tickvals=tval,
                         ticktext=ttxt,
                         showline=T,
                         mirror = "ticks",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         zeroline=F),
            showlegend = FALSE,
            dragmode = "select", selectdirection = "h")
        p
      })
      
      # LOE Table -------------------------
      output$LOE_Table <- render_gt({
        cd <- data.frame(LOE = c("LOE 1 Absolute rate: Is Rate 2 Statistically Significant Different than rate of zero?",
                                 "LOE 2 Compare Rates: Is the rate of the first period you selected more than two times the second rate?",
                                 "LOE 3 Order of Magnitude?: Is the Concentration Difference of the last points on the regression lines shown in the graph greater than 1 Order of Magnitude (OoM)?",
                                 "LOE 4  Very Low Rate: Is the Period 3 rate from Step 4 less than 0.0693 per year (10 year half-life)?"),
                         Method = c("", "", "", ""),
                         Values = c("", "", "", ""),
                         Condition = c("No", "No", "No", "No"))
        
        gt(cd) %>%
          cols_label(LOE = "",
                     Method = "",
                     Values = "",
                     Condition = "Is the Condition Met?")
        
      })

      ## FOLLOWING IS THE CHEAT SHEET OF CALLING EACH FUNCTION
      ##CHEAT SHEET

      # library(tidyverse)
      # library(readxl)
      # library(plotly)
      # library(stringr)
      # library(lubridate)
      # 
      # lapply(paste0("./R/Functions/",
      #               list.files(path = "./R/Functions",
      #                          pattern = "[.]R$",
      #                          recursive = TRUE),
      #               sep=''),
      #        source)
      # # -----read in files
      # location <- read_excel("C:/Users/hmori/Desktop/GSI Work Files/5648_SERDP_Borden/TA2 Module 1 2 Data File v3.xlsx",
      #                        sheet = "Data File Template", skip = 2,
      #                        n_max = 2)
      # 
      # 
      # df <- read_excel("C:/Users/hmori/Desktop/GSI Work Files/5648_SERDP_Borden/TA2 Module 1 2 Data File v3.xlsx",
      #                  sheet = "Data File Template", range = "B6:K26",
      #                  col_types = c("date", "numeric", "numeric",
      #                                "numeric", "numeric", "numeric",
      #                                "numeric", "numeric", "numeric","numeric"))
      # 
      # cname <-c('Date',colnames(location)[2:10])
      # 
      # colnames(df)<-cname
      # 
      # # ----- Step 3 monitoring well group to be averaged user input
      # pickwell<-c('MW-1','MW-2')
      # 
      # 
      # 
      # # ----- Step 4 choose whether mean or geomean user input
      # ave_switch = 'mean' #or 'geomean
      # 
      # 
      # # ----- Step 5 concentration goal user input
      # C_goal <-0.5
      # 
      # # user input
      # date_slider1 = '2012-03-02'
      # date_slider2 = '2013-08-31'
      # 
      # #################################################################
      # #  project # 5648 TA2 - Transition Assessment
      # # function for Tool 1
      # # Asymptote Analysis
      # 
      # 
      # #--- export the averaged monitoring well concentration for all period, period1, and period2
      # test<-df_series(df,ave_switch,pickwell,
      #                 date_slider1,date_slider2)
      # 
      # #--- export the fitness of the models range 1 and range 2
      # fit_test <- regression_fitness(test)
      # 
      # #--- export figure
      # p <- logscale_figure(test,fit_test,date_slider1,date_slider2)
      # 
      # # To Hannah,
      # # make sliders for choosing the date_slider1 and date_slider2
      # # --- Results return all the necessary information to fill in the cell in storyboard
      # Results <- Asymptote_Analysis(C_goal,test,fit_test)
    }
  )
} # end Asymptote Server  
