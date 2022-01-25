# Trend Modules -----------------------------

## UI -----------------------------------------
TrendUI <- function(id, label = "01_Trend"){
  ns <- NS(id)
  
  tabPanel("2a. Concentration Analysis",
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
                                           HTML("<h4><b>Step 2.</b> Select Well Groupings to be included in analysis.</h4>"),
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
                                           HTML("<h4><b>Step 3.</b> Select method for combining data.</h4>"),
                                           fluidRow(align = "center",
                                                    radioButtons(ns("group_method"), label = NULL,
                                                                 choices = c("Geomean", "Mean"),
                                                                 selected = "Geomean",
                                                                 inline = T))),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help3"), HTML("?"), style = button_style2))), br(),
                           fluidRow(column(10,
                                           HTML("<h4><b>Step 4 (Optional).</b> Select the concentration goal.</h4>"),
                                           fluidRow(
                                             column(6, align = "right", 
                                                    numericInput(ns("conc_goal"), label = NULL,
                                                                 value = NULL, min = 0, step = 0.01,
                                                                 width = "80px")),
                                             column(6, align = "left", 
                                                    HTML("<h4>ug/L</h4>")))),
                                    column(2, align = "left", style = "padding:10px;",
                                           actionButton(ns("help4"), HTML("?"), style = button_style2))),
                           HTML("<hr class='featurette-divider'>"),
                           HTML("<h4><b>Data Handeling</b></h4>"),
                           HTML("<hr class='featurette-divider'>"),
                           HTML("<h4><b>Mann-Kendall Test and Sen's Slope</b></h4>"),
                           HTML("<hr class='featurette-divider'>"),
                           HTML("<h4><b>Parameter Description</b></h4>"),
                           HTML("<hr class='featurette-divider'>"),
                           HTML("<h4><b>Key Assumptions</b></h4>"),
                           HTML("<hr class='featurette-divider'>"),
                           HTML("<h4><b>References</b></h4>"),
                           HTML("<hr class='featurette-divider'>"),
                           HTML("<h4><b>Authors</b></h4>")
                    ), #end instruction column
                    column(9,
                           tabsetPanel(
                             # Results -----------------------------
                             tabPanel("Results", br(),
                                      gt_output(ns("group_results")), br(), br(),
                                      gt_output(ns("well_results")), br(), br(),
                                      gt_output(ns("concl_table"))), 
                             # Time Series Plot  -------------------------
                             tabPanel("Time Series Plot", br(),
                                      fluidRow(align = "center",
                                               column(3, align = "right",
                                                      HTML("<h4><b>Display Results:</b></h4>")),
                                               column(3, align = "left", style = "padding:10px;",
                                                      radioButtons(ns("select_plot_group"),
                                                                   label = NULL,
                                                                   choices = c("Grouped Wells", "All Wells"),
                                                                   inline = T)),
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
                                        column(3, align = "right",
                                               HTML("<h4><b>Display Results:</b></h4>")),
                                        column(3, align = "left", style = "padding:10px;",
                                               radioButtons(ns("select_map_group"),
                                                            label = NULL,
                                                            choices = c("Grouped Wells", "All Wells"),
                                                            inline = T)),
                                        column(3, align = "right",
                                               HTML("<h4>Select Well/Group to Display:")),
                                        column(3, align = "left",
                                               pickerInput(ns("select_map"), label = NULL,
                                                           choices = c(),
                                                           multiple = F,
                                                           options = list(`live-search`=TRUE,
                                                                          `none-selected-text` = "Select Well/Group")))),
                                      leafletOutput(ns("map"))),
                             tabPanel("Data")), br(), br(),
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
      # Reactive Variables -----------------
      # Concentration and Time Data (pivoting long)
      d_conc_long <- reactiveVal()
      
      observeEvent(data_input$d_conc(),{
        
        d_conc_long(data_input$d_conc() %>% 
                      select(where(~!all(is.na(.x)))) %>% # removing columns with no data
                      filter(!if_all(starts_with("MW-"), ~is.na(.))) %>% #removing events with all NAs
                      pivot_longer(cols = c(-"Event", -"Date", -"COC", -"Units"), 
                                   names_to = "WellID", values_to = "Concentration") %>% 
                      filter(!is.na(Concentration)))
      }) # end d_conc_long()
      
      # Location Data
      d_loc <- reactiveVal()
      
      observeEvent(data_input$d_loc(),{
        
        d_loc(data_input$d_loc() %>% filter(!is.na(`Monitoring Wells`)))
        
      }) # end d_loc()
      
      # Reactive Variables: Series Data (Avg By Date) -------------------
      df <- reactiveVal()
      
      observe({
        req(d_conc_long(),
            input$group_method)
        
        ave_switch <- input$group_method
        
        if (ave_switch == 'Mean'){
          df_MW <- d_conc_long() %>% group_by(WellID, Date) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE)) %>% ungroup()}
        
        if (ave_switch == 'Geomean'){
          df_MW <- d_conc_long() %>% group_by(WellID, Date) %>%
            summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE))) %>% ungroup()}
        
        df_MW <- df_MW %>% select(Date, Concentration, Group = WellID)
        
        df(df_MW)
      }) # end df()
      
      
      # Reactive Variables: Series Data (Avg By Group) ----------------------
      df_group <- reactiveVal()
      
      observe({
        req(df(),
            input$select_mw_group,
            input$group_method)
        
        ave_switch <- input$group_method
        
        df_MW <- df() %>% rename(WellID = Group)
        
        cd <- c()
        
        # All
        if (sum("All Monitoring Wells" %in% input$select_mw_group) > 0){
          cd <- bind_rows(cd, df_MW %>% mutate(Group = "All Monitoring Wells"))
        } 
        
        # Recent Sample Above Concentration Goal
        if (sum("Recent Sample Above Concentration Goal" %in% input$select_mw_group) > 0){
          req(input$conc_goal)
          
          x <- df_MW %>% group_by(WellID) %>%
            mutate(Group = ifelse(Concentration[which.max(Date)] > input$conc_goal,
                                  "Wells with Recent Samples Above Concentration Goal",
                                  "Wells with Recent Samples Below Concentration Goal")) %>% ungroup()
          
          cd <- bind_rows(cd, x)
        }
        
        # Manually Assigned Groups
        if (sum(unique(d_loc()$`Well Grouping`) %in% input$select_mw_group) > 0){
          req(d_loc(),
              length(unique(d_loc()$`Well Grouping`)) > 0)
          
          x <- left_join(df_MW, d_loc(), by = c("WellID" = "Monitoring Wells")) %>%
            filter(`Well Grouping` %in% input$select_mw_group) %>%
            select(WellID, Date, Concentration, Group = `Well Grouping`)
          
          cd <- bind_rows(cd, x)
        } 
        
        # Avg by Group
        if (ave_switch == 'Mean'){
          df_MW_group <- cd %>% group_by(Group, Date) %>%
            summarise(Concentration = mean(Concentration, na.rm=TRUE)) %>% ungroup()}
        
        if (ave_switch == 'Geomean'){
          df_MW_group <- cd %>% group_by(Group, Date) %>%
            summarise(Concentration = exp(mean(log(Concentration), na.rm=TRUE))) %>% ungroup()}
        
        df_group(df_MW_group)
      }) # end df_group()
      
      # Reactive Variables: MK by Well ----------------------
      MK_well <- reactiveVal()
      
      observe({
        req(df())
        MK_well(MannKendall_MAROS(d = df()))
      })
      
      # Reactive Variables: MK by Group ----------------------
      MK_group <- reactiveVal()
      
      observe({
        req(df_group())
        MK_group(MannKendall_MAROS(d = df_group()))
      })
      
      # Select Updates: Well Grouping --------------
      observe({
        req(nav() == "2a. Concentration Analysis")
        req(d_loc())
        
        choices <- c("All Monitoring Wells", "Recent Sample Above Concentration Goal", sort(unique(d_loc()$`Well Grouping`)))
        
        updatePickerInput(session, "select_mw_group",
                          choices = choices,
                          selected = "All Monitoring Wells")
      }) # end update well grouping selection
      
      
      # Grouped Results -------------------------
      output$group_results <- render_gt({
        validate(
          need(d_conc_long(), "Please enter data into Data Input tab (Step 1)."),
          need(input$select_mw_group, "Please select well groupings (Step 2)."),
          need(ifelse(sum("Recent Sample Above Concentration Goal" %in% input$select_mw_group) > 0, !is.na(input$conc_goal), T), 
               "Please enter concentration goal (Step 4)."))
        
        req(MK_group())
        cd <- MK_group() %>% 
          select(Group, Trend, MK.S, MK.CF, MK.CV, S.Slope)
        
        print(cd)
        
        gt(cd) %>%
          fmt_percent(columns = c("MK.CF"),
                      decimals = 0) %>%
          fmt_number(columns = c("MK.CV", "S.Slope"),
                     decimals = 3) %>%
          fmt_number(columns = c("MK.S"),
                     decimals = 0) %>%
          cols_label(Group = md("**Groups of Wells**"),
                     Trend = md("**Trend**"),
                     MK.S = md("*S Statistic*"),
                     MK.CF = md("*Confidence Factor*"),
                     MK.CV = md("*Coefficient of Variation*"),
                     S.Slope = md("*Sen's Slope*")) %>%
          tab_header(title = md("**OVERALL MANN-KENDALL TEST RESULTS**")) %>%
          tab_style(style = list(cell_borders(sides = c("bottom"),
                                              color = NULL,
                                              weight = NULL)),
                    locations = list(cells_body(rows = gt::everything())))
        
      }, align = "center") # grouped result table
      
      # Results by Well -------------------------
      output$well_results <- render_gt({
        validate(
          need(d_conc_long(), ""))
        
        req(MK_well())
        cd <- MK_well() %>% 
          select(Group, Trend, MK.S, MK.CF, MK.CV, S.Slope)
        
        print(cd)
        
        gt(cd) %>%
          fmt_percent(columns = c("MK.CF"),
                      decimals = 0) %>%
          fmt_number(columns = c("MK.CV", "S.Slope"),
                     decimals = 3) %>%
          fmt_number(columns = c("MK.S"),
                     decimals = 0) %>%
          cols_label(Group = md("**Monitoring Well**"),
                     Trend = md("**Trend**"),
                     MK.S = md("*S Statistic*"),
                     MK.CF = md("*Confidence Factor*"),
                     MK.CV = md("*Coefficient of Variation*"),
                     S.Slope = md("*Sen's Slope*")) %>%
          tab_header(title = md("**MANN-KENDALL TEST RESULTS BY WELL**")) %>%
          tab_style(style = list(cell_borders(sides = c("bottom"),
                                              color = NULL,
                                              weight = NULL)),
                    locations = list(cells_body(rows = gt::everything())))
        
      }, align = "center") # well result table
      
      # Conclusion Table ----------------------
      output$concl_table <- render_gt({
        req(MK_group())
        
        cd <- MK_group() %>% 
          mutate(expanding = ifelse(Trend %in% c("Decreasing", "Probably Decreasing", "Stable"), "No", "Yes")) %>%
          select(Group, expanding)
        
        gt(cd) %>%
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
        
      }) # end conclusion table
      
      # TS Plot ----------------------------------
      output$ts_plot <- renderPlotly({
        req(input$select_plot_group)
        req(input$log_linear)
        
        validate(
          need(d_conc_long(), "Please enter data into Data Input tab (Step 1)."),
          need(ifelse(input$select_plot_group == "Grouped Wells",
                      !is.null(input$select_mw_group), T), "Please select well groupings (Step 2)."))
        
        if(input$select_plot_group == "All Wells"){
          req(df())
          d <- df()
        }
        
        if(input$select_plot_group == "Grouped Wells"){
          req(df_group())
          d <- df_group()
        }
        
        graph_vis(d, log_flag = input$log_linear, vis_flag = "Concentration")

      }) # end TS plot

      
    }
  )
} # end Trend Server  