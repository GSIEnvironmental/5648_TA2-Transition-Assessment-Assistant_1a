# Trend Modules -----------------------------

## UI -----------------------------------------
TrendUI <- function(id, label = "01_Trend"){
  ns <- NS(id)
  
  tabPanel("2. Expansion",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 2. Is my plume still expanding?</h1></b>"),
                    column(5,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4>This tool uses concentration vs. time monitoring well data entered by the user to calculate trends in 
                           the data. The monitoring well data can be aggregated into three groups: <ol>
                           <li> Source wells</li> 
                           <li> Mid-plume wells</li>
                           <li> Downgradient wells (or any other grouping of wells)</li>
                           </ol>
                           The tool then uses a non-parameteric trend test (Mann-Kendall Test) to determine if increasing or decreasing trends are present.</h4>")),
                    column(5,
                           HTML("<h3><b>How Does it Work?</b></h3>
                           <h4><ol>
                           <li> Enter your monitoring well’s concentration vs. time data under the 'Data Input' tab.</li> 
                           <li> Go through Steps 1-4 to get the trends and determine if your plume is still expanding.</li>
                                </ol></h4>"))
                    ), # end Page Title
           fluidRow(br(),
                    # Instructions and General Inputs --------------
                    column(3,
                           fluidRow(column(10, 
                                           HTML("<h4><b>Step 1.</b> Enter Data. See 'Data Input' tab for more information</h4>")),
                                    # column(2, align = "left", style = "padding:10px;",
                                    #        actionButton(ns("help1"), HTML("?"), style = button_style2))
                                    ), br(),
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 2.</b> Select Well Groupings to be included in analysis.</h4>"),
                                           fluidRow(align = "center",
                                                    pickerInput(ns("select_mw_group"), label = NULL,
                                                                choices = c("All Monitoring Wells"),
                                                                selected = "All Monitoring Wells",
                                                                multiple = F,
                                                                options = list(`live-search`=TRUE,
                                                                               `none-selected-text` = "Select Well Groups")))),
                                    # column(2, align = "left", style = "padding:10px;",
                                    #        actionButton(ns("help2"), HTML("?"), style = button_style2))
                           ), br(),
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 3.</b> Select data type to analyze.</h4>"),
                                           fluidRow(align = "center",
                                                    radioButtons(ns("type"), label = NULL,
                                                                 choices = c("Concentration", "Mass"),
                                                                 selected = "Concentration",
                                                                 inline = T))),
                                    # column(2, align = "left", style = "padding:10px;",
                                    #        actionButton(ns("help3"), HTML("?"), style = button_style2))
                                    ), 
                           conditionalPanel(
                             condition = "input.type == 'Mass'", ns = ns,
                             fluidRow(column(10,
                                             HTML("<h5><i>For the plume or plume layer being analyzed what are the typical values for:</i><h5>"))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Plume Top (ft bgs)</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("plume_top"), label = NULL,
                                                          value = 5, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help2_2"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right", 
                                             HTML("<h5>Plume Buttom (ft bgs)</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("plume_bottom"), label = NULL,
                                                          value = 10, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help2_3"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Total Porosity of Transmissive Media</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("trans_porosity"), label = NULL,
                                                          value = 0.3, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help2_4"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Total Porosity of Low-K Zone</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("lowk_porosity"), label = NULL,
                                                          value = 0.35, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help2_5"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Fraction of Plume Thickness with Transmissive Geologic Media</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("fraction_trans"), label = NULL,
                                                          value = 0.5, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help2_6"), HTML("?"), style = button_style2)))
                             ), # end conditional Panel
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 4.</b> Choose COC.</h4>"),
                                           fluidRow(align = "center",
                                                    column(12, align = "right", 
                                                           pickerInput(ns("select_COC"), label = NULL,
                                                                       choices = c(),
                                                                       multiple = T,
                                                                       options = list(`live-search`=TRUE,
                                                                                      `none-selected-text` = "Select COCs")))))
                           ),br(),
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 5.</b> Select method for combining data.</h4>"),
                                           fluidRow(align = "center",
                                                    radioButtons(ns("group_method"), label = NULL,
                                                                 choices = c("Geomean", "Mean"),
                                                                 selected = "Geomean",
                                                                 inline = T))),
                                    # column(2, align = "left", style = "padding:10px;",
                                    #        actionButton(ns("help3"), HTML("?"), style = button_style2))
                                    ), 
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 6 (Optional).</b> Select the concentration goal.</h4>"),
                                           fluidRow(
                                             column(6, align = "right", 
                                                    numericInput(ns("conc_goal"), label = NULL,
                                                                 value = NULL, min = 0, step = 0.01,
                                                                 width = "80px")),
                                             column(6, align = "left", 
                                                    htmlOutput(ns("unit"))))),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help2_1"), HTML("?"), style = button_style2)))#,
                           # HTML("<hr class='featurette-divider'>"),
                           # HTML("<h4><b>Data Handling</b></h4>"),
                           # HTML("<hr class='featurette-divider'>"),
                           # HTML("<h4><b>Mann-Kendall Test and Sen's Slope</b></h4>"),
                           # HTML("<hr class='featurette-divider'>"),
                           # HTML("<h4><b>Parameter Description</b></h4>"),
                           # HTML("<hr class='featurette-divider'>"),
                           # HTML("<h4><b>Key Assumptions</b></h4>"),
                           # HTML("<hr class='featurette-divider'>"),
                           # HTML("<h4><b>References</b></h4>"),
                           # HTML("<hr class='featurette-divider'>"),
                           # HTML("<h4><b>Authors</b></h4>")
                    ), #end instruction column Handling
                    column(9,
                           tabsetPanel(id = ns("Trend_Result_Tabs"),
                             # Results -----------------------------
                             tabPanel("Results", br(),
                                      gt_output(ns("results_table_1")), br(), br(),
                                      gt_output(ns("results_table_2")), br(), br(),
                                      gt_output(ns("concl_table"))), 
                             # Time Series Plot  -------------------------
                             tabPanel("Time Series Plot", br(),
                                      fluidRow(align = "center",
                                               column(3, align = "right",
                                                      conditionalPanel(
                                                        condition = "input.type == 'Concentration'", ns = ns,
                                                        HTML("<h4><b>Display Results:</b></h4>"))),
                                               column(3, align = "left", style = "padding:10px;",
                                                      conditionalPanel(
                                                        condition = "input.type == 'Concentration'", ns = ns,
                                                        radioButtons(ns("select_plot_group"),
                                                                     label = NULL,
                                                                     choices = c("Grouped Wells", "All Wells"),
                                                                     inline = T))),
                                      column(3, align = "right",
                                             HTML("<h4><b>Y-Axis Scale:</b></h4>")),
                                      column(3, align = "left", style = "padding:10px;",
                                             radioButtons(ns("log_linear"),
                                                          label = NULL,
                                                          choices = c("Linear", "Log"),
                                                          inline = T))),
                                      plotlyOutput(ns("ts_plot"), height = "600px")),
                             # Trend Map --------------------------------
                             tabPanel("Trend Map", br(),
                                      fluidRow(
                                        column(3, align = "right", style = "padding:10px;",
                                               HTML("<h4>Select Date to Display:")),
                                        column(3, align = "left", style = "padding:10px;",
                                               pickerInput(ns("select_map"), label = NULL,
                                                           choices = "",
                                                           multiple = F,
                                                           options = list(`live-search`=TRUE,
                                                                          `none-selected-text` = "Select Date"))),
                                        column(6, align = "center", 
                                               actionButton(ns("save_map"),
                                                            HTML("Save Map"), style = button_style))), br(),
                                      leafletOutput(ns("map"), height = "600px")),
                             # Data -----------------
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
                                                 HTML("Save Data and Analysis"), style = button_style))
                    ) # end results column
           ), br()
  ) # end tab panel
} # end Asymptote UI         


## Server Module -----------------------------------------
TrendServer <- function(id, data_input, nav) {
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
      
      
      # update Units -------------------
      observe({
        req(nav() == "2. Expansion")
        req(d_conc())
        
        output$unit<- renderUI({
          HTML(paste0("<h4>",unique(d_conc()$Units),"</h4>",sep=''))
        })
      }) # end update unit 
      
      # RV: Series Data (Avg By Date) -------------------
      df <- reactiveVal()

      observe({
        req(d_conc(),
            input$group_method,
            input$select_COC)
        
        validate(need(!is.na(input$select_COC),"Please choose  (Step 4)."))

        if (input$group_method == 'Mean'){
          df_MW <- d_conc() %>% filter(COC%in%input$select_COC)%>%group_by(WellID, Date) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE)) %>% ungroup()}

        if (input$group_method == 'Geomean'){
          df_MW <- d_conc() %>% filter(COC%in%input$select_COC)%>%group_by(WellID, Date) %>%
            summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE))) %>% ungroup()}

        df_MW <- df_MW %>% select(Date, Concentration, WellID)
        
        df(df_MW)
      }) # end df()


      # RV: Series Data (Avg By Group) ----------------------
      df_group <- reactiveVal()

      observe({
        req(df(),
            input$select_mw_group)

        cd <- c()

        # All
        if (sum("All Monitoring Wells" %in% input$select_mw_group) > 0){
          cd <- bind_rows(cd, df() %>% mutate(Group = "All Monitoring Wells"))
        }

        # Recent Sample Above Concentration Goal
        if (sum("Recent Sample Above Concentration Goal" %in% input$select_mw_group) > 0){
          req(input$conc_goal)

          x <- df() %>% group_by(WellID) %>%
            mutate(Group = ifelse(Concentration[which.max(Date)] > input$conc_goal,
                                  "Wells with Recent Samples Above Concentration Goal",
                                  "Wells with Recent Samples Below Concentration Goal")) %>% ungroup()

          cd <- bind_rows(cd, x)
        }

        # Manually Assigned Groups
        if (sum(unique(d_loc_T1()$`Well Grouping`) %in% input$select_mw_group) > 0){
          req(d_loc_T1(),
              length(unique(d_loc_T1()$`Well Grouping`)) > 0)
          x <- data_merge(df(), d_loc_T1()) %>%
            filter(`Well Grouping` %in% input$select_mw_group) %>%
            select(WellID, Date, Concentration, Group = `Well Grouping`)

          cd <- bind_rows(cd, x)
        }

        df_group(cd)
      }) # end df_group()

      # RV: MK by Well ----------------------
      MK_conc_well <- reactiveVal()

      observe({
        req(df(),
            input$type == "Concentration")

        df_MW <- df() %>% rename(Group = WellID, Value = Concentration)
        MK_conc_well(MannKendall_MAROS(d = df_MW,MK_table))
      })

      # RV: MK Concentration by Group ----------------------
      MK_conc_group <- reactiveVal()

      observe({
        req(df_group(),
            input$group_method,
            input$type == "Concentration")

        # Avg by Group
        if (input$group_method == 'Mean'){
          df_MW_group <- df_group() %>% group_by(Group, Date) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE)) %>% ungroup()}

        if (input$group_method == 'Geomean'){
          df_MW_group <- df_group() %>% group_by(Group, Date) %>%
            summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE))) %>% ungroup()}

        MK_conc_group(MannKendall_MAROS(d = df_MW_group %>% rename(Value = Concentration),MK_table))
      })

      # RV: Mass by Group ----------------------
     df_mass_group <- reactiveVal()

      observe({
        req(df_group(),
            d_loc_T1(),
            input$type == "Mass",
            input$select_mw_group,
            input$trans_porosity,
            input$lowk_porosity,
            input$plume_bottom,
            input$plume_top,
            input$fraction_trans)

        cd <- df_group() %>%
          left_join(d_loc_T1() %>% select(-`Well Grouping`), by = c("WellID" = "Monitoring Wells")) %>%
          filter(!is.na(Latitude) & !is.na(Longitude) & Group %in% input$select_mw_group)

        porosityHK <- input$trans_porosity
        porosityLK <- input$lowk_porosity
        thicknessHK <- (input$plume_bottom - input$plume_top) * input$fraction_trans # units in ft bgs
        thicknessLK <- (input$plume_bottom - input$plume_top) * (1 - input$fraction_trans)  # units in ft bgs
        
        unit = unique(d_conc()$Units)
        df_mass_group(sp_interpolation(d = cd, porosityHK, porosityLK, thicknessHK, thicknessLK,unit))
       
      })

      # RV: MK Mass by Group ----------------------
      MK_mass_group <- reactiveVal()

      observe({
        req(df_group(),
            df_mass_group(),
            input$type == "Mass")

        cd <- df_mass_group()[["overall_tbl"]] %>%
          select(Group, Date, Value = total_mass_kg)

        MK_mass_group(MannKendall_MAROS(d = cd,MK_table))
      })

      # Select Updates: Well Grouping --------------
      observe({
        req(nav() == "2. Expansion",
            input$type)

        if(input$type == "Concentration"){
          choices <- c("All Monitoring Wells", 
                       sort(unique(d_loc_T1()$`Well Grouping`)))
        }

        if(input$type == "Mass"){
          choices <- c("All Monitoring Wells",
                       sort(unique(d_loc_T1()$`Well Grouping`)))
        }

        updatePickerInput(session, "select_mw_group",
                          choices = choices,
                          selected = input$select_mw_group)
      }) # end update well grouping selection


      # Select Updates: Map Grouping --------------
      observe({
        req(nav() == "2. Expansion")
        req(d_loc_T1())
        
        if(input$type == "Concentration"){
          choices <- c("All Monitoring Wells", 
                       sort(unique(d_loc_T1()$`Well Grouping`)))
        }
        
        if(input$type == "Mass"){
          req(df_mass_group())
          choices <- names(df_mass_group()[[input$select_mw_group]])
        }

        updatePickerInput(session, "select_map",
                          choices = choices,
                          selected = input$select_mw_group)
                          #selected = "All Monitoring Wells")
      }) # end update well grouping selection

      # COC Selection Updates -----------------------
      observe({
        req(nav() == "2. Expansion")
        req(d_loc_T1(),
            d_conc(),
            input$select_mw_group)

        if (input$select_mw_group=="All Monitoring Wells"){
          COC_unique<-d_loc_T1()
          COC_unique<-d_conc()%>%filter(WellID%in%COC_unique$`Monitoring Wells`)
        }else{
          COC_unique<-d_loc_T1()%>%filter(`Well Grouping`%in%input$select_mw_group)
          COC_unique<-d_conc()%>%filter(WellID%in%COC_unique$`Monitoring Wells`)
        }
        
        choices <- sort(unique(COC_unique$COC))
        
        updatePickerInput(session, "select_COC", choices = choices)
        
      }) # end update well selection
      
      # Results Table 1 -------------------------
      output$results_table_1 <- render_gt({
        validate(
          need(d_conc(), "Please enter data into Data Input tab (Step 1)."),
          need(input$select_mw_group, "Please select well groupings (Step 2)."),
          need(input$select_COC, "Please select COC (Step 4)."))


        if(input$type == "Concentration"){
          validate(
            need(ifelse(sum("Recent Sample Above Concentration Goal" %in% input$select_mw_group) > 0, !is.na(input$conc_goal), T),
                 "Please enter concentration goal (Step 6)."))

          req(MK_conc_group())

          cd <- MK_conc_group() %>%
            select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)%>%
            mutate(MK.p = ifelse(MK.p<0.05,'<0.05',as.character(signif(MK.p,3))))
       
          t <- gt(cd) %>%
            fmt_number(columns = c("MK.CV", "S.Slope"),
                       n_sigfig = 3) %>%
            fmt_number(columns = c("MK.S"),
                       decimals = 0) %>%
            cols_label(Group = md("**Groups of Wells**"),
                       Trend = md("**Trend**"),
                       MK.S = md("*S Statistic*"),
                       MK.p = md("*p-Value*"),
                       MK.CV = md("*Coefficient of Variation*"),
                       S.Slope = md("*Sen's Slope*")) %>%
            tab_header(title = md("**OVERALL MANN-KENDALL TEST RESULTS**")) %>%
            tab_style(style = style_body(),
                      locations = cells_body()) %>%
            tab_style(style = style_col_labels(),
                      locations = cells_column_labels()) %>%
            tab_style(style = list(cell_fill(color= "#F9E3D6"),
                                   cell_text(weight="bold")),
                      locations = cells_body(columns=c(Group,Trend)))%>%
            opt_table_outline() %>%
            # GT bug fix
            tab_options(table.additional_css = "th, td {padding: 5px 10px !important;	border: 1px solid white;}" )
          
        }

        if(input$type == "Mass"){
          validate(
            need(d_loc_T1(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."))
          validate(
            need(d_loc_T1()$Latitude & d_loc_T1()$Longitude,
                 "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))
          validate(
            need(dim(d_loc_T1() %>% filter(!is.na(as.numeric(Latitude)) & !is.na(as.numeric(Longitude))))[1],
                 "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))

          req(df_mass_group())


          cd <- df_mass_group()[["overall_tbl"]] 
          
          t <- gt(cd) %>%
            tab_spanner(label = "Approximate Mass (kg)",
                        columns = ends_with("mass_kg"), gather = T) %>%
            cols_label(Group = "Group",
                       Date = "Event",
                       MW_count = "Number of Wells",
                       highK_mass_kg = "Transmissive Unit",
                       lowK_mass_kg = "Low-k Units",
                       total_mass_kg = "Total Mass") %>%
            fmt_number(columns = c(highK_mass_kg, lowK_mass_kg, total_mass_kg),
                       n_sigfig = 3) %>%
            tab_header(title = md("**ESTIMATE OF PLUME MASS**")) %>%
            tab_style(style = style_body(),
                      locations = cells_body()) %>%
            tab_style(style = style_col_labels(),
                      locations = cells_column_labels()) %>%
            opt_table_outline() %>%
            # GT bug fix
            tab_options(table.additional_css = "th, td {padding: 5px 10px !important;	border: 1px solid white;}" )
          
        } # end Mass Table

        t # print table
      }, align = "center") # grouped result table

      # Results Table 2 -------------------------
      output$results_table_2 <- render_gt({
        req(d_conc())
        validate(need(unique(MK_conc_well()$enough_data)!='FALSE','The individual wells have no time series data.'))
        if(input$type == "Concentration"){
          req(MK_conc_well())
        
          cd <- MK_conc_well() %>%
            select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)%>%
            mutate(MK.p = ifelse(MK.p<0.05,'<0.05',as.character(signif(MK.p,3))))%>%
            filter(Group%in%unique(df_group()$WellID))


          t <- gt(cd) %>%
            fmt_number(columns = c("MK.CV", "S.Slope"),
                       n_sigfig = 3) %>%
            fmt_number(columns = c("MK.S"),
                       decimals = 0) %>%
            cols_label(Group = md("**Monitoring Well**"),
                       Trend = md("**Trend**"),
                       MK.S = md("*S Statistic*"),
                       MK.p = md("*p-Value*"),
                       MK.CV = md("*Coefficient of Variation*"),
                       S.Slope = md("*Sen's Slope*")) %>%
            tab_header(title = md("**MANN-KENDALL TEST RESULTS BY WELL**")) %>%
            tab_style(style = style_body(),
                      locations = cells_body()) %>%
            tab_style(style = style_col_labels(),
                      locations = cells_column_labels()) %>%
            tab_style(style = list(cell_fill(color= "#F9E3D6"),
                                   cell_text(weight="bold")),
                      locations = cells_body(columns=c(Group,Trend)))%>%
            opt_table_outline() %>%
            # GT bug fix
            tab_options(table.additional_css = "th, td {padding: 5px 10px !important;	border: 1px solid white;}" )
          

        } # Concentration

        if(input$type == "Mass"){
          req(MK_mass_group())

          cd <- MK_mass_group() %>%
            select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)%>%
            mutate(MK.p = ifelse(MK.p<0.05,'<0.05',as.character(signif(MK.p,3))))
          
          t <- gt(cd) %>%
            fmt_number(columns = c("MK.CV", "S.Slope"),
                       n_sigfig = 3) %>%
            fmt_number(columns = c("MK.S"),
                       decimals = 0) %>%
            cols_label(Group = md("**Group**"),
                       Trend = md("**Trend**"),
                       MK.S = md("*S Statistic*"),
                       MK.p = md("*p-Value*"),
                       MK.CV = md("*Coefficient of Variation*"),
                       S.Slope = md("*Sen's Slope*")) %>%
            tab_header(title = md("**PLUME MASS MANN-KENDALL TEST RESULTS**")) %>%
            tab_style(style = style_body(),
                      locations = cells_body()) %>%
            tab_style(style = style_col_labels(),
                      locations = cells_column_labels()) %>%
            tab_style(style = list(cell_fill(color= "#F9E3D6"),
                                   cell_text(weight="bold")),
                      locations = cells_body(columns=c(Group,Trend)))%>%
            opt_table_outline() %>%
            # GT bug fix
            tab_options(table.additional_css = "th, td {padding: 5px 10px !important;	border: 1px solid white;}" )
          
        } # Mass Table
        t
      }, align = "center") # well result table

      # Conclusion Table ----------------------
      output$concl_table <- render_gt({

        if(input$type == "Concentration"){
          req(MK_conc_group())

          cd <- MK_conc_group()
        }

        if(input$type == "Mass"){
          req(MK_mass_group())

          cd <- MK_mass_group()
        }

        cd <- cd %>%
          mutate(expanding = ifelse(Trend %in% c("Decreasing", "Probably Decreasing", "Stable"), "No", "Yes")) %>%
          select(Group, expanding)
        
        t <- gt(cd) %>%
          cols_label(Group = "",
                     expanding = md(ifelse(input$type == "Mass",
                                           "**Is the mass still expanding?**",
                                           "**Is the plume still expanding?**"))) %>%
          tab_style(style = list(cell_borders(sides = c("bottom"),
                                              color = NULL,
                                              weight = NULL)),
                    locations = list(cells_body(rows = gt::everything()))) %>%
          tab_style(style = list(cell_text(align = "center",
                                           style = "italic")),
                    locations = list(cells_body(columns = "expanding"))) %>%
          tab_style(style = list(cell_text(align = "right")),
                    locations = list(cells_body(columns = "Group")))

        t # print table
      }) # end conclusion table

      # TS Plot ----------------------------------
      output$ts_plot <- renderPlotly({
        req(input$select_plot_group)
        req(input$log_linear)

        validate(
          need(d_conc(), "Please enter data into Data Input tab (Step 1)."),
          need(ifelse(input$select_plot_group == "Grouped Wells",
                      !is.null(input$select_mw_group), T), "Please select well groupings (Step 2)."))

        if(input$type == "Concentration"){

          if(input$select_plot_group == "All Wells"){
            req(df())
            d <- df() %>% rename(Group = WellID)
          }

          if(input$select_plot_group == "Grouped Wells"){
            req(df_group())

            # Avg by Group
            if (input$group_method == 'Mean'){
              d <- df_group() %>% group_by(Group, Date) %>%
                summarise(Concentration = mean(Concentration, na.rm=TRUE)) %>% ungroup()}

            if (input$group_method == 'Geomean'){
              d <- df_group() %>% group_by(Group, Date) %>%
                summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE))) %>% ungroup()}
          }
        }
        
        if(input$type == "Mass"){
          d <- df_mass_group()[["overall_tbl"]] %>% rename(Mass = total_mass_kg)
        }

        unit = unique(d_conc()$Units)
       
        graph_vis(d, log_flag = input$log_linear, vis_flag = input$type,unit=unit)

      }) # end TS plot

      # Map -----------------------
      output$map <- renderLeaflet({
        validate(
          need(d_conc(), "Please enter data into Data Input tab (Step 1)."),
          need(d_loc_T1(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."),
          need(input$select_map, "Please select group to veiw (above)."),
          need(ifelse(sum("Recent Sample Above Concentration Goal" %in% input$select_map) > 0, !is.na(input$conc_goal), T),
               "Please enter concentration goal (Step 6)."))
        validate(
          need(d_loc_T1()$Latitude & d_loc_T1()$Longitude,
          "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))
        validate(
          need(dim(d_loc_T1() %>% filter(!is.na(as.numeric(Latitude)) & !is.na(as.numeric(Longitude))))[1],
               "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))

        site_map %>%
          addLayersControl(baseGroups = c('Grey Base','Satellite (ESRI)','Satellite (Google)'),
                           overlayGroups = c("Well Labels"),
                           position = "bottomright",
                           options = layersControlOptions(collapsed = FALSE)) %>%
          hideGroup("Well Labels")
      }) # map

      observe({
        proxy <- leafletProxy("map") %>%
          clearGroup(group="markers")

        req(nav() == "2. Expansion",
            input$Trend_Result_Tabs == "Trend Map",
            input$select_map)
        
        if(input$type == "Concentration"){
          
        req(
          MK_conc_well(),
          d_loc_T1())
          
          cd <- left_join(MK_conc_well(), d_loc_T1(), by = c("Group" = "Monitoring Wells")) %>%
            filter(!is.na(Latitude), !is.na(Longitude))
          req(dim(cd)[1] > 0)
          
          # Recent Sample Above Concentration Goal
          if (sum("Recent Sample Above Concentration Goal" %in% input$select_map) > 0){
            req(input$conc_goal)
            req(d_conc())
            
            x <- d_conc() %>% group_by(WellID) %>%
              mutate(Group = ifelse(Concentration[which.max(Date)] > input$conc_goal,
                                    "Wells with Recent Samples Above Concentration Goal",
                                    "Wells with Recent Samples Below Concentration Goal")) %>% ungroup() %>%
              filter(Group == "Wells with Recent Samples Above Concentration Goal") %>% pull(WellID)
            
            cd <- cd %>% filter(Group %in% x)
          }
          
          # Manually Assigned Groups
          if (sum(unique(d_loc_T1()$`Well Grouping`) %in% input$select_map) > 0){
            cd <- cd %>%
              filter(`Well Grouping` %in% input$select_map)
          }
          
          proxy %>%
            fitBounds(min(cd$Longitude), min(cd$Latitude), max(cd$Longitude), max(cd$Latitude)) %>%
            addCircleMarkers(data = cd, lng = ~Longitude, lat = ~Latitude, label = ~Group,
                             fillColor = ~Color, color = "black", group = "markers",
                             radius = 8, stroke = TRUE, fillOpacity = 0.8, weight = 1, opacity = 1,
                             popup = ~paste0("<b>",Group, "</b>:<br>",
                                             "Trend: ", Trend, "<br>",
                                             "p-Value: ", round(MK.p, 3), "<br>",
                                             "S Statistic: ", round(MK.S, 0), "<br>",
                                             "Sen's Slope: ", round(S.Slope, 3), "<br>"),
                             layerId = ~Group, options = pathOptions(pane="markers")) %>%
            addLabelOnlyMarkers(data = cd, lng = ~Longitude, lat = ~Latitude, label = ~MapFlag,
                                layerId = ~paste0(Group, "_Label"),
                                labelOptions = labelOptions(noHide = T, textOnly = TRUE, textsize = "25px",
                                                            offset = c(25, 25)), group = "Well Labels")  %>%
            addLegend(position = "bottomleft",
                      labels = c("Insufficent Data", "No Trend", "Increasing", "Decreasing", "Stable"),
                      colors = c("black", simp[3], simp[8], simp[6], simp[1]),
                      opacity = 0.8) 
          
        }
        
        if(input$type == "Mass"){
          req(df_mass_group())
          
          proxy <- proxy %>%
            removeControl(layerId = "Legend") %>%
            clearGroup(group = "image")
          
          cd <- df_mass_group()[[input$select_mw_group]][[input$select_map]][["df"]]
          nnmsk <- df_mass_group()[[input$select_mw_group]][[input$select_map]][["shape"]]

          
          pal <- colorNumeric(palette = "viridis", nnmsk$total_mass,
                              na.color = "transparent")

          nnmsk$colors <- pal(nnmsk$total_mass)

          proxy %>%
            fitBounds(min(cd$Longitude), min(cd$Latitude), max(cd$Longitude), max(cd$Latitude)) %>%
            addCircleMarkers(data = cd, lng = ~Longitude, lat = ~Latitude, label = ~WellID,
                             fillColor = col["blue"], color = "black", group = "markers",
                             radius = 8, stroke = TRUE, fillOpacity = 0.8, weight = 1, opacity = 1,
                             popup = ~paste0("<b>",WellID, "</b>:<br>",
                                             "Area: ", round(area, 0), "m<sup>2</sup><br>",
                                             "Total Mass: ", signif(total_mass, 2)),
                             layerId = ~WellID, options = pathOptions(pane="markers")) %>%
            addLabelOnlyMarkers(data = cd, lng = ~Longitude, lat = ~Latitude, label = ~WellID,
                                layerId = ~paste0(WellID, "_Label"),
                                labelOptions = labelOptions(noHide = T, textOnly = TRUE, textsize = "25px",
                                                            offset = c(25, 25)), group = "Well Labels") %>%
            addFeatures(nnmsk, weight = 1, color = "black", fillColor = ~colors, group = "image") %>%
            addLegend("bottomleft", pal = pal, values = nnmsk$total_mass,
                      title = "Dissolved Plume<br>Mass (kg)",
                      layerId = "Legend")
          
        }


      })

      observeEvent({input$map_groups
        input$type},{
        if("Well Labels" %in% input$map_groups & input$type == "Concentration"){

          proxy <- leafletProxy("map") %>%
            removeControl(layerId = "label_legend")

          proxy %>%
            addLegend(position = "bottomright",
                      labels = c("<b>NA</b>: Insufficent Data",
                                 "<b>NT</b>: No Trend",
                                 "<b>I</b>: Increasing",
                                 "<b>PI</b>: Probably Increasing",
                                 "<b>D</b>: Decreasing",
                                 "<b>PD</b>: Probably Decreasing",
                                 "<b>S</b>: Stable"),
                      colors = c(NA, NA, NA, NA, NA, NA, NA),
                      layerId = "label_legend")
      
        }
      })

      # Save Map ----------------------
      observeEvent(input$save_map,{
        screenshot(filename = "Expansion")
      })

      # Save Dataframes --------------------
      
      output$save_data <- downloadHandler(
        
        filename = function() {
          paste0("Expanding_Results", ".xlsx")
        },
        content = function(file) {
          
          if (input$type == 'Concentration'){
            parameter_tbl<-data.frame(
              'data type' = input$type,
              'well grouping' = input$select_mw_group,
              'average method' = input$group_method)
            cdata = MK_conc_group()
            
            result2 = MK_conc_well() %>%
              select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)%>%
              mutate(MK.p = ifelse(MK.p<0.05,'<0.05',as.character(signif(MK.p,3))))%>%
              filter(Group%in%unique(df_group()$WellID))
          }else{
            parameter_tbl<-data.frame(
              'data type' = input$type,
              'well grouping' = input$select_mw_group,
              'average method' = input$group_method,
              'plume_top' = input$plume_top,
              'plume_bottom' = input$plume_bottom,
              'HighK_porosity' = input$trans_porosity,
              'LowK_porosity' = input$lowk_porosity,
              'Plume Thickness Fraction' = input$fraction_trans
            )
            cdata = MK_mass_group()
            result2 = df_mass_group()[["overall_tbl"]] 
          }
          
          result =  cdata %>%
            select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)%>%
            mutate(MK.p = ifelse(MK.p<0.05,'<0.05',as.character(signif(MK.p,3))))
          
          result3 = cdata%>%
                  mutate(expanding = ifelse(Trend %in% c("Decreasing", "Probably Decreasing", "Stable"), "No", "Yes")) %>%
                  select(Group, expanding)
          
          if(input$select_mw_group!="All Monitoring Wells"){
            location_tbl = data_input$d_loc_T1()%>%filter(`Well Grouping`==input$select_mw_group,
                                                       COC%in%input$select_COC)
          }else{
            location_tbl = data_input$d_loc_T1()
          }
          
          if (input$type == 'Concentration'){
            list_of_datasets<-list(
              "Ave Concentration" = as.data.frame(df_group()),
              "Location" =location_tbl,
              "parameters" = parameter_tbl,
              "Overall MK Results" = result,
              "MK Results by Well" = result2,
              'Plume Expanding' = result3
              
            )
          }else{
            list_of_datasets<-list(
              "Ave Concentration" = as.data.frame(df_group()),
              "Location" =location_tbl,
              "parameters" = parameter_tbl,
              "Overall MK Results" = result,
              "Estimate of Plume Mass" = result2,
              'Plume Expanding' = result3
              
            )
          }
          
          
          
          write.xlsx(list_of_datasets, file)
          
          
        }
        
      )
      
      #----- help function 
      lapply(
        X = 1:6,
        FUN = function(i){
          observeEvent(input[[paste0("help2_", i)]], {
            flname <-as.character(figure_list_2[i])
            Helpboxfunction(flname,Y='"./02_Trend/')
          })
        }
      )
      
      # Data ----------------
      output$conc_time_data <- renderRHandsontable({
        validate(
          need(data_input$d_conc(), "Please enter data into Data Input tab (Step 1)."))
        
        
        x <- df() %>% group_by(WellID) %>%
          mutate(Group = ifelse(Concentration[which.max(Date)] > input$conc_goal,
                                "Wells with Recent Samples Above Concentration Goal",
                                "Wells with Recent Samples Below Concentration Goal")) %>% 
          filter(Group=="Wells with Recent Samples Above Concentration Goal")
        
        if (input$select_mw_group%in%c("Recent Sample Above Concentration Goal")){
          tbl_name <- data_input$d_conc()%>%
            rename(`Date (Month/Day/Year)`=Date)%>%
            filter(WellID%in%x$WellID,
                   COC%in%input$select_COC)
        }else{
          tbl_name <- data_input$d_conc()%>%
            rename(`Date (Month/Day/Year)`=Date)%>%
            filter(WellID%in%unique(df_group()$WellID),
                   COC%in%input$select_COC)
        }
        
        
        
        rhandsontable(tbl_name, readOnly = T, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })

      output$mw_data <- renderRHandsontable({
        validate(
          need(data_input$d_loc_T1(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."))

        x <- df() %>% group_by(WellID) %>%
          mutate(Group = ifelse(Concentration[which.max(Date)] > input$conc_goal,
                                "Wells with Recent Samples Above Concentration Goal",
                                "Wells with Recent Samples Below Concentration Goal")) %>% 
          filter(Group=="Wells with Recent Samples Above Concentration Goal")
        
        if (input$select_mw_group%in%c("Recent Sample Above Concentration Goal")){
          loc_name<-data_input$d_loc_T1()%>%
            filter(`Monitoring Wells`%in%unique(x$WellID))
        }
        else{
          loc_name<-data_input$d_loc_T1()%>%
          filter(`Monitoring Wells`%in%unique(df_group()$WellID))
        }
        
        
        
        rhandsontable(loc_name, readOnly = T, rowHeaders = NULL, width = 1000, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })
      
      
      # Return Dataframes ------------------
      
      return(list(
        MK_conc_well = reactive({
          req(MK_conc_well())
          MK_conc_group()}),
        MK_mass_group = reactive({
          req(MK_mass_group())
          MK_mass_group() })
      ))
      
      
    }
  )
} # end Trend Server  