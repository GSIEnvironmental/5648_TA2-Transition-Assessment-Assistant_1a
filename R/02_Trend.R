# Trend Modules -----------------------------

## UI -----------------------------------------
TrendUI <- function(id, label = "01_Trend"){
  ns <- NS(id)
  
  tabPanel("2. Expansion",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 2a. Is my plume still expanding?</h1></b>"),
                    column(5,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4>This tool uses concentration vs. time monitoring well data entered by the user to calculate trends in 
                           the data. The monitoring well data can be aggregated into three groups: <ol>
                           <li> Source wells</li> 
                           <li> Mid-plume wells</li>
                           <li> Downgradient wells (or any other grouping of wells)</li>
                           The tool then uses a non-parameteric trend test (Mann-Kendall Test) to determine if increasing or decreasing trends are present.
                           </ol></h4>")),
                    column(5,
                           HTML("<h3><b>How Does it Work?</b></h3>
                           <h4><ol>
                           <li> Enter your monitoring well’s concentration vs. time data under the 'Data Input' tab.</li> 
                           <li> Go through Steps 1-4 to get the trends and determine if your plume is still expanding.</li>
                                </ol></h4>"))), # end Page Title
           fluidRow(br(),
                    # Instructions and General Inputs --------------
                    column(3,
                           fluidRow(column(10, 
                                           HTML("<h4><b>Step 1.</b> Enter Data. See 'Data Input' tab for more information</h4>")),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help1"), HTML("?"), style = button_style2))), br(),
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 2.</b> Select data type to analyze.</h4>"),
                                           fluidRow(align = "center",
                                                    radioButtons(ns("type"), label = NULL,
                                                                 choices = c("Concentration", "Mass"),
                                                                 selected = "Concentration",
                                                                 inline = T))),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help3"), HTML("?"), style = button_style2))),
                           conditionalPanel(
                             condition = "input.type == 'Mass'", ns = ns,
                             fluidRow(column(10,
                                             HTML("<h5><i>For the plume or plume layer being analyzed what are the typical values for:</i><h5>"))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Plume Top (ft bgs)</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("plume_top"), label = NULL,
                                                          value = NA, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help4"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right", 
                                             HTML("<h5>Plume Buttom (ft bgs)</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("plume_bottom"), label = NULL,
                                                          value = NA, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help4"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Total Porosity of Transmissive Media</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("trans_porosity"), label = NULL,
                                                          value = NA, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help4"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Total Porosity of Low-K Zone</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("lowk_porosity"), label = NULL,
                                                          value = NA, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help4"), HTML("?"), style = button_style2))),
                             fluidRow(column(6, align = "right",
                                             HTML("<h5>Fraction of Plume Thickness with Transmissive Geologic Media</h5>")),
                                      column(4, align = "left", style = "padding:10px;",
                                             numericInput(ns("fraction_trans"), label = NULL,
                                                          value = NA, width = '100px')),
                                      column(2, align = "left", style = "padding:10px;",
                                             actionButton(ns("help4"), HTML("?"), style = button_style2)))
                             ), # end conditional Panel
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 3.</b> Select Well Groupings to be included in analysis.</h4>"),
                                           fluidRow(align = "center",
                                                    pickerInput(ns("select_mw_group"), label = NULL,
                                                                choices = c("All Monitoring Wells", "Recent Sample Above Concentration Goal"),
                                                                selected = "All Monitoring Wells",
                                                                multiple = T,
                                                                options = list(`live-search`=TRUE,
                                                                               `none-selected-text` = "Select Well Groups")))),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help2"), HTML("?"), style = button_style2))), br(),
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 4.</b> Select method for combining data.</h4>"),
                                           fluidRow(align = "center",
                                                    radioButtons(ns("group_method"), label = NULL,
                                                                 choices = c("Geomean", "Mean"),
                                                                 selected = "Geomean",
                                                                 inline = T))),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help3"), HTML("?"), style = button_style2))), 
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 5 (Optional).</b> Select the concentration goal.</h4>"),
                                           fluidRow(
                                             column(6, align = "right", 
                                                    numericInput(ns("conc_goal"), label = NULL,
                                                                 value = NULL, min = 0, step = 0.01,
                                                                 width = "80px")),
                                             column(6, align = "left", 
                                                    HTML("<h4>ug/L</h4>")))),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help4"), HTML("?"), style = button_style2)))#,
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
                                               HTML("<h4>Select Group to Display:")),
                                        column(3, align = "left", style = "padding:10px;",
                                               pickerInput(ns("select_map"), label = NULL,
                                                           choices = c("All Monitoring Wells"),
                                                           multiple = F,
                                                           options = list(`live-search`=TRUE,
                                                                          `none-selected-text` = "Select Well/Group"))),
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
                                    actionButton(ns("save_data"),
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
      # RV: Pivot Conc data long -----------------
      d_conc_long <- reactiveVal()
      
      observeEvent(data_input$d_conc(),{
        
        d_conc_long(data_input$d_conc() %>% 
                      select(where(~!all(is.na(.x)))) %>% # removing columns with no data
                      filter(!if_all(starts_with("MW-"), ~is.na(.))) %>% #removing events with all NAs
                      pivot_longer(cols = c(-"Event", -"Date", -"COC", -"Units"), 
                                   names_to = "WellID", values_to = "Concentration") %>% 
                      filter(!is.na(Concentration)))
      }) # end d_conc_long()
      
      # RV: Location Data ----------------
      d_loc <- reactiveVal()
      
      observeEvent(data_input$d_loc(),{
        
        d_loc(data_input$d_loc() %>% filter(!is.na(`Monitoring Wells`)))
        
      }) # end d_loc()
      
      # RV: Series Data (Avg By Date) -------------------
      df <- reactiveVal()
      
      observe({
        req(d_conc_long(),
            input$group_method)
        
        if (input$group_method == 'Mean'){
          df_MW <- d_conc_long() %>% group_by(WellID, Date) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE)) %>% ungroup()}
        
        if (input$group_method == 'Geomean'){
          df_MW <- d_conc_long() %>% group_by(WellID, Date) %>%
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
        if (sum(unique(d_loc()$`Well Grouping`) %in% input$select_mw_group) > 0){
          req(d_loc(),
              length(unique(d_loc()$`Well Grouping`)) > 0)
          
          x <- left_join(df(), d_loc(), by = c("WellID" = "Monitoring Wells")) %>%
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
        
        MK_conc_well(MannKendall_MAROS(d = df_MW))
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
        
        MK_conc_group(MannKendall_MAROS(d = df_MW_group %>% rename(Value = Concentration)))
      })
      
      # RV: Mass by Group ----------------------
     df_mass_group <- reactiveVal()
      
      observe({
        req(df_group(),
            input$type == "Mass",
            input$select_mw_group,
            input$trans_porosity,
            input$lowk_porosity,
            input$plume_bottom,
            input$plume_top,
            input$fraction_trans)
        
        cd <- df_group() %>% 
          left_join(d_loc() %>% select(-`Well Grouping`), by = c("WellID" = "Monitoring Wells")) %>%
          filter(!is.na(Latitude) & !is.na(Longitude) & Group %in% input$select_mw_group)

        porosityHK <- input$trans_porosity
        porosityLK <- input$lowk_porosity
        thicknessHK <- (input$plume_bottom - input$plume_top) * input$fraction_trans # units in ft bgs
        thicknessLK <- (input$plume_bottom - input$plume_top) * (1 - input$fraction_trans)  # units in ft bgs
        
        df_mass_group(sp_interpolation(d = cd, porosityHK, porosityLK, thicknessHK, thicknessLK))
      })
      
      # RV: MK Mass by Group ----------------------
      MK_mass_group <- reactiveVal()
      
      observe({
        req(df_group(),
            df_mass_group(),
            input$type == "Mass")

        cd <- df_mass_group()[["overall_tbl"]] %>% 
          select(Group, Date, Value = total_mass_kg)
        
        MK_mass_group(MannKendall_MAROS(d = cd))
      })
      
      # Select Updates: Well Grouping --------------
      observe({
<<<<<<< HEAD
        req(nav() == "2. Expansion",
=======
        req(nav() == "2a. Concentration Analysis",
>>>>>>> 16479d809b2459fdb08393f644ce2e5a20e26053
            input$type)
        
        if(input$type == "Concentration"){
          choices <- c("All Monitoring Wells", "Recent Sample Above Concentration Goal", 
                       sort(unique(d_loc()$`Well Grouping`)))
        }
        
        if(input$type == "Mass"){
          choices <- c("All Monitoring Wells", 
                       sort(unique(d_loc()$`Well Grouping`)))
        }
       
        updatePickerInput(session, "select_mw_group",
                          choices = choices,
                          selected = "All Monitoring Wells")
      }) # end update well grouping selection
      
      
      # Select Updates: Map Grouping --------------
      observe({
<<<<<<< HEAD
        req(nav() == "2. Expansion")
=======
        req(nav() == "2a. Concentration Analysis")
>>>>>>> 16479d809b2459fdb08393f644ce2e5a20e26053
        req(d_loc())
        
        choices <- c("All Monitoring Wells", "Recent Sample Above Concentration Goal", sort(unique(d_loc()$`Well Grouping`)))
        
        updatePickerInput(session, "select_map",
                          choices = choices,
                          selected = "All Monitoring Wells")
      }) # end update well grouping selection
      
      
      # Results Table 1 -------------------------
      output$results_table_1 <- render_gt({
        validate(
          need(d_conc_long(), "Please enter data into Data Input tab (Step 1)."),
          need(input$select_mw_group, "Please select well groupings (Step 2)."))

        
        if(input$type == "Concentration"){
          validate(
            need(ifelse(sum("Recent Sample Above Concentration Goal" %in% input$select_mw_group) > 0, !is.na(input$conc_goal), T), 
                 "Please enter concentration goal (Step 5)."))
          
          req(MK_conc_group())
          
          cd <- MK_conc_group() %>% 
            select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)
          
          t <- gt(cd) %>%
            # fmt_percent(columns = c("MK.CF"),
            #             decimals = 0) %>%
            fmt_number(columns = c("MK.p", "MK.CV", "S.Slope"),
                       decimals = 3) %>%
            fmt_number(columns = c("MK.S"),
                       decimals = 0) %>%
            cols_label(Group = md("**Groups of Wells**"),
                       Trend = md("**Trend**"),
                       MK.S = md("*S Statistic*"),
                       MK.p = md("*p-Value*"),
                       MK.CV = md("*Coefficient of Variation*"),
                       S.Slope = md("*Sen's Slope*")) %>%
            tab_header(title = md("**OVERALL MANN-KENDALL TEST RESULTS**")) %>%
            tab_style(style = list(cell_borders(sides = c("bottom"),
                                                color = NULL,
                                                weight = NULL)),
                      locations = list(cells_body(rows = gt::everything())))
        }
        
        if(input$type == "Mass"){
          validate(
            need(d_loc(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."))
          validate(
            need(d_loc()$Latitude & d_loc()$Longitude, 
                 "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))
          validate(
            need(dim(d_loc() %>% filter(!is.na(as.numeric(Latitude)) & !is.na(as.numeric(Longitude))))[1],
                 "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))
          
          req(df_mass_group())
          
          
          cd <- df_mass_group()[["overall_tbl"]] %>% group_by(Group) %>%
            summarise(`Date Range` = paste(min(Date, na.rm = T), "to",
                                           max(Date, na.rm = T)),
                      `Approximate Mass in Transmissive Unit (kg)` = sum(highK_mass_kg, na.rm = T),
                      `Approximate Mass in Low-k Units (kg)` = sum(lowK_mass_kg, na.rm = T),
                      `Approximate Total Mass (kg)` = sum(total_mass_kg, na.rm = T))
          
          t <- gt(cd) %>%
            fmt_number(columns = c("Approximate Mass in Transmissive Unit (kg)",
                                    "Approximate Mass in Low-k Units (kg)",
                                    "Approximate Total Mass (kg)"),
                        decimals = 2) %>%
            tab_header(title = md("**ESTIMATE OF PLUME MASS**")) %>%
            tab_style(style = list(cell_borders(sides = c("bottom"),
                                                color = NULL,
                                                weight = NULL)),
                      locations = list(cells_body(rows = gt::everything())))
          
        } # end Mass Table 
        
        t # print table
      }, align = "center") # grouped result table
      
      # Results Table 2 -------------------------
      output$results_table_2 <- render_gt({
        req(d_conc_long())

        if(input$type == "Concentration"){
          req(MK_conc_well())
          cd <- MK_conc_well() %>%
            select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)

          t <- gt(cd) %>%
            # fmt_percent(columns = c("MK.CF"),
            #             decimals = 0) %>%
            fmt_number(columns = c("MK.p", "MK.CV", "S.Slope"),
                       decimals = 3) %>%
            fmt_number(columns = c("MK.S"),
                       decimals = 0) %>%
            cols_label(Group = md("**Monitoring Well**"),
                       Trend = md("**Trend**"),
                       MK.S = md("*S Statistic*"),
                       MK.p = md("*p-Value*"),
                       MK.CV = md("*Coefficient of Variation*"),
                       S.Slope = md("*Sen's Slope*")) %>%
            tab_header(title = md("**MANN-KENDALL TEST RESULTS BY WELL**")) %>%
            tab_style(style = list(cell_borders(sides = c("bottom"),
                                                color = NULL,
                                                weight = NULL)),
                      locations = list(cells_body(rows = gt::everything())))

        } # Concentration

        if(input$type == "Mass"){
          req(MK_mass_group())
          
          cd <- MK_mass_group() %>%
            select(Group, Trend, MK.S, MK.p, MK.CV, S.Slope)

          t <- gt(cd) %>%
            # fmt_percent(columns = c("MK.CF"),
            #             decimals = 0) %>%
            fmt_number(columns = c("MK.p", "MK.CV", "S.Slope"),
                       decimals = 3) %>%
            fmt_number(columns = c("MK.S"),
                       decimals = 0) %>%
            cols_label(Group = md("**Group**"),
                       Trend = md("**Trend**"),
                       MK.S = md("*S Statistic*"),
                       MK.p = md("*p-Value*"),
                       MK.CV = md("*Coefficient of Variation*"),
                       S.Slope = md("*Sen's Slope*")) %>%
            tab_header(title = md("**PLUME MASS MANN-KENDALL TEST RESULTS**")) %>%
            tab_style(style = list(cell_borders(sides = c("bottom"),
                                                color = NULL,
                                                weight = NULL)),
                      locations = list(cells_body(rows = gt::everything())))
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
                     expanding = md("**Is the plume still expanding?**")) %>%
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
          need(d_conc_long(), "Please enter data into Data Input tab (Step 1)."),
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
  

        graph_vis(d, log_flag = input$log_linear, vis_flag = input$type)

      }) # end TS plot

      # Map -----------------------
      output$map <- renderLeaflet({
        validate(
          need(d_conc_long(), "Please enter data into Data Input tab (Step 1)."),
          need(d_loc(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."),
          need(input$select_map, "Please select well groupings (Step 2)."),
          need(ifelse(sum("Recent Sample Above Concentration Goal" %in% input$select_map) > 0, !is.na(input$conc_goal), T),
               "Please enter concentration goal (Step 4)."))
        validate(
          need(d_loc()$Latitude & d_loc()$Longitude,
          "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))
        validate(
          need(dim(d_loc() %>% filter(!is.na(as.numeric(Latitude)) & !is.na(as.numeric(Longitude))))[1],
               "Please enter Latitude and Longitude information into the Monitoring Well Information in the Data Input tab (Step 1)."))

        site_map %>%
          addLayersControl(baseGroups = c('Grey Base','Satellite (ESRI)','Satellite (Google)'),
                           overlayGroups = c("Well Labels"),
                           position = "bottomright",
                           options = layersControlOptions(collapsed = FALSE)) %>%
          addLegend(position = "bottomleft",
                    labels = c("Insufficent Data", "No Trend", "Increasing", "Decreasing", "Stable"),
                    colors = c("black", simp[3], simp[8], simp[6], simp[1]),
                    opacity = 0.8) %>%
          hideGroup("Well Labels")
      }) # map

      observe({
        proxy <- leafletProxy("map") %>%
          clearGroup(group="markers")

<<<<<<< HEAD
        req(nav() == "2. Expansion",
=======
        req(nav() == "2a. Concentration Analysis",
>>>>>>> 16479d809b2459fdb08393f644ce2e5a20e26053
            input$type == "Concentration",
            input$Trend_Result_Tabs == "Trend Map",
            input$select_map,
            MK_conc_well(),
            d_loc())

        cd <- left_join(MK_conc_well(), d_loc(), by = c("Group" = "Monitoring Wells")) %>%
          filter(!is.na(Latitude), !is.na(Longitude))
        req(dim(cd)[1] > 0)

        # Recent Sample Above Concentration Goal
        if (sum("Recent Sample Above Concentration Goal" %in% input$select_map) > 0){
          req(input$conc_goal)
          req(d_conc_long())

          x <- d_conc_long() %>% group_by(WellID) %>%
            mutate(Group = ifelse(Concentration[which.max(Date)] > input$conc_goal,
                                  "Wells with Recent Samples Above Concentration Goal",
                                  "Wells with Recent Samples Below Concentration Goal")) %>% ungroup() %>%
            filter(Group == "Wells with Recent Samples Above Concentration Goal") %>% pull(WellID)

          cd <- cd %>% filter(Group %in% x)
        }

        # Manually Assigned Groups
        if (sum(unique(d_loc()$`Well Grouping`) %in% input$select_map) > 0){
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
<<<<<<< HEAD
                                           "p-Value: ", round(MK.p, 3), "<br>",
=======
                                           "p-Value: ", round(MK.p, 3), "%<br>",
>>>>>>> 16479d809b2459fdb08393f644ce2e5a20e26053
                                           "S Statistic: ", round(MK.S, 0), "<br>",
                                           "Sen's Slope: ", round(S.Slope, 3), "<br>"),
                           layerId = ~Group, options = pathOptions(pane="markers")) %>%
          addLabelOnlyMarkers(data = cd, lng = ~Longitude, lat = ~Latitude, label = ~MapFlag,
                              layerId = ~paste0(Group, "_Label"),
                              labelOptions = labelOptions(noHide = T, textOnly = TRUE, textsize = "25px",
                                                          offset = c(25, 25)), group = "Well Labels")
      })

      observeEvent({input$map_groups},{
        if("Well Labels" %in% input$map_groups){

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
      
      # Data ----------------
      output$conc_time_data <- renderRHandsontable({
        validate(
          need(data_input$d_conc(), "Please enter data into Data Input tab (Step 1)."))
        
        rhandsontable(data_input$d_conc(), readOnly = T, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })
      
      output$mw_data <- renderRHandsontable({
        validate(
          need(data_input$d_loc(), "Please enter data Monitoring Well Information into Data Input tab (Step 1)."))
        
        rhandsontable(data_input$d_loc(), readOnly = T, rowHeaders = NULL, width = 800, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })
      
    }
  )
} # end Trend Server  