## Performance Modules -----------------------------

## UI Module ------------------------------------------
PerformanceUI <- function(id, label = "04_Performance"){
  ns <- NS(id)
  
  tabPanel("4. Performance",
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 4. What level of performance can I expect from an in-situ source remediation project?</h1></b>"),
                    column(6,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4><ol>This tool leverages the extensive ESTCP investment in understanding what has happened at 
                           remediation sites to create a semi-quantitative forecasting tool for understanding what level 
                           of performance might be achieved at a particular site.  This is then used to predict whether 
                           the selected technology would be able to obtain the concentration reduction needed to achieve
                           a site-specific cleanup goal.</ol></h4>")),
                    column(6,
                           HTML("<h3><b>How Does it Work?</b></h3>
                           <h4><ol>
                           <li> Select variables for contaminant type, maximum concentration range, and technologies in Steps 1-3.</li> 
                           <li> Input a site-specific cleanup goal and starting concentration in Steps 4-5.</li>
                           <li> Use the table at the right of the chart to see how close you will get to the site-specific 
                           cleanup goal based on the expected performance of the selected technology.</li>
                           <li> See data from the selected remediation projects using the “Data” tab.</li>
                           <li> Go through the “Remediation Potential Assessment” tab to answer more questions related to 
                           site-specific expectations of remediation performance</li></ol></h4>"))
                    ),

           fluidRow(br(),
                    column(3,
                           fluidRow(column(10,
                                           fluidRow(column(10,
                                                           HTML("<h4><b>Step 1.</b> Select sites with these constituents of concern (COCs)</h4>"),
                                                           fluidRow(align = "center",
                                                                      radioButtons(ns("select_group_type"), label = NULL,
                                                                                   choices = c("Chlorinated Solvents" = "C",
                                                                                               "Benzene" = "B"),
                                                                                   inline = T),
                                                                      conditionalPanel(
                                                                        condition = "input.select_group_type=='C'", ns = ns,
                                                                        #HTML("<h4><b><i>For Be:</i></b></h4>"),
                                                                        fluidRow(pickerInput(ns("COC"),label = NULL,
                                                                                             choices = c('All Chlorinated Solvents',unique(df_tool4$`Parent CVOC`)[1:5]),
                                                                                             selected = "All Chlorinated Solvents", multiple = T)
                                                                                 ),br()))),
                                                      # column(2, align = "left", style = "padding:10px;",
                                                      #        actionButton(ns("help1"), HTML("?"), style = button_style2))
                                                    ), br())),
                    fluidRow(column(10,
                                    fluidRow(column(10,
                                                    HTML("<h4><b>Step 2.</b> Select Sites with These Pre-Remediation Maximum Concentrations</h4>"),
                                                    fluidRow(align = "center",
                                                             pickerInput(ns("maxC"),label = NULL,
                                                                         choices = site_max,
                                                                         selected = "All Sites", multiple = T))),
                                             # column(2, align = "left", style = "padding:10px;",
                                             #        actionButton(ns("help1"), HTML("?"), style = button_style2))
                                             ), br())),
                    fluidRow(column(10,
                                    fluidRow(column(10,
                                                    HTML("<h4><b>Step 3.</b> Select an in-situ remediation source treatment  technologies(COCs)</h4>"),
                                                    fluidRow(align = "center",
                                                             conditionalPanel(
                                                               condition = "input.select_group_type=='B'", ns = ns,
                                                               #HTML("<h4><b><i>For Be:</i></b></h4>"),
                                                               fluidRow(pickerInput(ns("Rem"),label = NULL,
                                                                                     choices = c('All Technologies',BRemlist),
                                                                                     selected = "All Technologies", multiple = T),
                                                                          br()
                                                                          )
                                                                 ),
                                                             conditionalPanel(
                                                               condition = "input.select_group_type=='C'", ns = ns,
                                                               fluidRow(pickerInput(ns("Rem2"),label = NULL,
                                                                                    choices = c('All Technologies',CRemlist),
                                                                                    selected = "All Technologies", multiple = T),
                                                                        br()
                                                               )
                                                             )
                                                             
                                                             )
                                                    ),
                                             # column(2, align = "left", style = "padding:10px;",
                                             #        actionButton(ns("help2"), HTML("?"), style = button_style2)
                                             #        )
                                             ),br())
                             ),
                    fluidRow(column(10,
                                    fluidRow(column(10,
                                                    HTML("<h4><b>Step 4.</b> Input Cleanup Goal (ug/L) </h4>"),
                                                    numericInput(ns("Conc_goal"), NULL, value = 5, min = 0, step = 0.1)
                                                    ),
                                             column(2, align = "left", style = "padding:10px;",
                                                    actionButton(ns("help4_1"), HTML("?"), style = button_style2)
                                                    )
                                             
                                             ),br(),
                                    )
                             ),
                    fluidRow(column(10,
                                    fluidRow(column(10,
                                                    HTML("<h4><b>Step 5.</b> Input Concentration at the Site (ug/L) </h4>"),
                                                    numericInput(ns("Conc_site"), NULL, value = 20, min = 0, step = 1)
                                                    ),
                                             column(2, align = "left", style = "padding:10px;",
                                            actionButton(ns("help4_2"), HTML("?"), style = button_style2)
                                            )
                                            ),br())
                    ),
                    ),
                    
                    column(9,
                           tabsetPanel(
                             tabPanel("Results", br(),
                                      column(12,
                                             fluidRow(column(8,# Overall Results
                                                             HTML("<h2><b> Remediation Chart</b></h2>"),
                                                             plotlyOutput(ns('ts_plot1'), height = "800px")
                                                             #HTML("<hr class='featurette-divider'>"),
                                                             #HTML("<h2><b>Overall Results</b></h2>"),
                                                             #gt_output(ns("rates_table"))
                                                             ),
                                             column(4,
                                                    HTML("<h2><b> Forecasting Results</b></h2>"),
                                                    br(),
                                                    fluidRow(align = "center",htmlOutput(ns("Rem_num"))),
                                                    br(),
                                                    gt_output(ns("rates_table"))
                                                    )
                                             
                                             )
                                             ),# FluidRow
                                      br(),
                                      fluidRow(
                                        column(10,fluidRow(includeMarkdown('./www/04_Performance/Tool4_v1.md'), br()))
                                        )
                                      ),
                             tabPanel("Data",br(),
                                      HTML("TA2 ESTCP Remediation Performance Database"), br(),
                                      rHandsontableOutput(ns("Rem_data"),width = 550, height = 300)
                                      ),
                             tabPanel("Remediation Potential Assessment",br(),
                                      HTML("Likelihood of Achieving Remediation Objectives"),
                                      fluidRow(br()),
                                      fluidRow(rHandsontableOutput(ns("Evaluation"), width = 550, height = 550)),
                                      fluidRow(htmlOutput(ns('Tchecked'))),

                                      fluidRow(
                                        column(10,fluidRow(includeMarkdown('./www/04_Performance/Tool4_v3.md'), br()))
                                      )
                                      )
                             ),
                           fluidRow(align = "center",
                                    downloadButton(ns("save_results"),HTML("Save Data and Analysis"), style = button_style),
                                    downloadButton(ns("database"),HTML("Download Entire Database"), style = button_style)
                                    ), br()
                           )# column 9
                           
                    )
           )
  
} # end Performance UI         


## Server Module -----------------------------------------
PerformanceServer <- function(id,nav) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      
      # RV: Series Avg Data ---------------
      filtered_table <- reactiveVal()
      
      observe({
        req(input$select_group_type,
            input$COC,
            input$maxC,
            input$Rem,
            input$Rem2)
        
        ave_switch <- input$group_method
        
        BorC = input$select_group_type
        
        if (input$select_group_type=='B'){
          COC_flag = 'Benzene'
        }else{
          COC_flag = input$COC
        }

        Con_flag = input$maxC
       
        
        if (input$select_group_type=='B'){
          Tech_flag = input$Rem
        }else{
          Tech_flag = input$Rem2
        }
        
        validate(need(df_tool4,'Data was unable to read in.'))
        filtered_table <- summary_table(df_tool4,BorC,COC_flag,Con_flag,Tech_flag)
        filtered_table(filtered_table)
      }) # end df()
      # #generate filtered table
      # filtered_table <- summary_table(df,COC_flag,Con_flag,Tech_flag)
      # 
      # # reassign the name of each data frame for
      # # df_filter: filtered dataframe remediation performance
      # # Num_Proj: number of project
      # # df_VOC: dataframe for VOC
      # # df_Benz dataframe for Benzene
      # 

      # generate figure for VOC and Benzene
      
      # Plot 1 ------------------
      fig_tool4 <-reactiveValues()
      observeEvent(filtered_table(),{
        
        
        for (var in 1:length(names(filtered_table()))){
          nam<-names(filtered_table())[var]
          assign(nam, (filtered_table()[[var]]))
        }
        print (input$COC)
        if (!'All Chlorinated Solvents'%in%input$COC&length(input$COC)==1|input$select_group_type=='B'){
          
          if (input$select_group_type=='B'){
            MCL_val <- MCL%>%filter(Chem=='Benzene')
          }else{
            MCL_val <- MCL%>%filter(Chem==input$COC)
          }
          
          
          if (input$select_group_type=='B'){
            Rem_Perf_fig_vis <- Rem_Perf_fig(df_filter,linear_df_Benzene,"Benzene",0.001,5000,MCL_val$`MCL (ug/L)`)
          }else{
            Rem_Perf_fig_vis <- Rem_Perf_fig(df_filter,linear_df,"Chlorinated Solvents",0.1,10000000,MCL_val$`MCL (ug/L)`)
          }
          
        }else{
          if (input$select_group_type=='B'){
            Rem_Perf_fig_vis <- Rem_Perf_fig(df_filter,linear_df_Benzene,"Benzene",0.001,5000)
          }else{
            Rem_Perf_fig_vis <- Rem_Perf_fig(df_filter,linear_df,"Chlorinated Solvents",0.1,10000000)
          }
        }
        
        
        #png("./plot.png", width=1000, height=1000, units="px")
        #print(Rem_Perf_fig_vis)
        #dev.off()
        
        fig_tool4$Rem_Perf_fig_vis <-Rem_Perf_fig_vis
      })
      
      output$ts_plot1 <- renderPlotly({
        validate(need(fig_tool4,FALSE))
        fig_tool4$Rem_Perf_fig_vis
        
        #browser()
        # ggplotly(Rem_Perf_fig_vis)%>%
        #   layout(legend = list(orientation = 'v',x=0.001,y=1))%>%
        #   add_annotations(
        #     data =linear_df%>%filter(After>=10),
        #     x=data$Before-1000,
        #     y = data$After,
        #     text = data$Label,
        #     xref = "x",
        #     yref = "y"
        #     #showarrow = TRUE,
        #     #arrowhead = 4,
        #     #arrowsize = .5
        #     )
      })
      
      # Attenuation Rates Table -------------------------
      results_table <- reactiveVal()
      observeEvent({filtered_table()
                   input$Conc_goal
                   input$Conc_site},
                   {
        
        validate(need(filtered_table(),FALSE))
        
        for (var in 1:length(names(filtered_table()))){
          nam<-names(filtered_table())[var]
          assign(nam, (filtered_table()[[var]]))
        }
        
        # if(!'All Chlorinated Solvents'%in%input$COC&length(input$COC)==1|input$select_group_type=='B'){
        Conc_goal = input$Conc_goal
        # }else{
        #   Conc_goal = NULL
        # }
        
        Conc_site = input$Conc_site
        
        #generate the list of data middle range, low range, and high range
        # c(% reduction, OoM reduction, after remediation forecast % reduction, OoM, % to reach)
        Result_table <- ForecastResults(df_filter,Conc_goal,Conc_site)

        if (!is.null(Conc_goal)){
          Result_table <-as.data.frame(Result_table)%>%
          mutate(Info = c('% reduction', 
                          'OoM reduction', 
                          'Forecast % reduction still needed', 
                          'OoM reduction still needed', 
                          '% way to reach criteria (based on OoMs)'),
                 group = c("Empirical Remediation Performance Stats",
                           "Empirical Remediation Performance Stats",
                           "After In-Situ Remediation is Performed, How Much Closer to the Cleanup Goal Will You Get?",
                           "After In-Situ Remediation is Performed, How Much Closer to the Cleanup Goal Will You Get?",
                           "After In-Situ Remediation is Performed, How Much Closer to the Cleanup Goal Will You Get?"
                 ))%>%
          select(Info,group,Median_list,Low_list,High_list)
        
        #validate(need(length(df()$Concentration) > 2, "Insufficent data to calculate rate. Make sure at least 2 data points are present."))
        #validate(need(input$conc_goal > 0, "Please select a valid concentration goal (Step 4)"))
        results_table(Result_table)
        Result_table<-Result_table%>%
          gt(rowname_col="Info",
             groupname_col = 'group')%>%
          cols_align(align = c("center"),
                     columns=c('Median_list','Low_list','High_list'
                     ))%>%
          cols_width("Info"~ px(100),
                     ends_with("list") ~px(80)) %>%
          cols_label(Info = " ",
                     Median_list = "Middle Range",
                     Low_list = "Low Range",
                     High_list = "High Range")%>%
          tab_style(locations=cells_row_groups(),
                    style = list(cell_text(weight='bold')))%>%
          tab_style(locations=cells_column_labels(everything()),
                    style = cell_text(weight='bold'))%>%
          tab_options(table.font.size = 12)
        
        fig_tool4$Result_table<-Result_table
        
        }else{
          Result_table <-as.data.frame(Result_table)%>%
            mutate(Info = c('% reduction', 
                            'OoM reduction'),
                   group = c("Empirical Remediation Performance Stats",
                             "Empirical Remediation Performance Stats"
                   ))%>%
            select(Info,group,Median_list,Low_list,High_list)
          
          #validate(need(length(df()$Concentration) > 2, "Insufficent data to calculate rate. Make sure at least 2 data points are present."))
          #validate(need(input$conc_goal > 0, "Please select a valid concentration goal (Step 4)"))
          results_table(Result_table)
          Result_table<-Result_table%>%
            gt(rowname_col="Info",
               groupname_col = 'group')%>%
            cols_align(align = c("center"),
                       columns=c('Median_list','Low_list','High_list'
                       ))%>%
            cols_width("Info"~ px(100),
                       ends_with("list") ~px(80)) %>%
            cols_label(Info = " ",
                       Median_list = "Middle Range",
                       Low_list = "Low Range",
                       High_list = "High Range")%>%
            tab_style(locations=cells_row_groups(),
                      style = list(cell_text(weight='bold')))%>%
            tab_style(locations=cells_column_labels(everything()),
                      style = cell_text(weight='bold'))%>%
            tab_options(table.font.size = 12)
          
          fig_tool4$Result_table<-Result_table
          
          
        }
        
      })
      
      output$rates_table <- render_gt({
        req(input$Conc_goal,
            input$Conc_site)
        
        fig_tool4$Result_table})
      
      ## Export remediation project numbers ---------------------
      output$Rem_num <- renderText({ 
        validate(need(filtered_table(),FALSE))
        req(filtered_table())
        
        for (var in 1:length(names(filtered_table()))){
          nam<-names(filtered_table())[var]
          assign(nam, (filtered_table()[[var]]))
        }
        #validate(need(error() != "Check Inputs", "Please Check Input Values"))
        
        
        # if (len_MC<700){
        #   paste("<H3>","MC Number of Realizations:", "<b>", round(len_MC,0),"</b></font>"," out of 1,000",
        #         "<BR>","MC Results will be Biased. No Results.","</H3>")
        # }else{
        
        paste("<H4>","Number of Remediation Projects:", "<font color=\"#ff0000\"><b>", Num_Proj,"</b></font></H4>")
        # }
        
      })
      
      #---------export database
      output$database <- downloadHandler(
        
        filename = function(){
          paste("Tool4_RemediationPerformance_database_download","xlsx",sep=".")
          },
        content = function(file){
          write.xlsx(df_tool4,file)
          }
      )# end database
      
      
      # Export Model Results and Input Values  ---------------------------
      output$save_results <- downloadHandler(
        
       
        for (var in 1:length(names(filtered_table()))){
          nam<-names(filtered_table())[var]
          assign(nam, (filtered_table()[[var]]))
        },
        
        filename = function(){
          paste("Tool4_Performance_Results","xlsx",sep=".")
        },
        
        content = function(con){
          # Model Results

          # Create empty excel file
          wb <- createWorkbook()
          
          # Add Results Tab
          addWorksheet(wb, "Remediation Data")
          writeData(wb, sheet = "Remediation Data", x = df_filter, 
                    startCol = 1, startRow = 1, colNames = T)
          
          #addWorksheet(wb, "Remediation Chart")
          #insertImage(wb, "Remediation Chart", paste0("./plot.png"),
          #             startRow = 2, startCol = 2, heigh = 2000, width = 2000, units = "px")
          
          addWorksheet(wb, "Forecasting Results")
          writeData(wb, sheet = "Forecasting Results", x = fig_tool4$Result_table, 
                    startCol = 1, startRow = 1, colNames = T)
          saveWorkbook(wb, con)
          
        }
      )# end model_results
      
      #----- help function 
      lapply(
        X = 1:2,
        FUN = function(i){
          observeEvent(input[[paste0("help4_", i)]], {
            flname <-as.character(figure_list_4[i])
            Helpboxfunction(flname,Y='"./04_Performance/')
          })
        }
      )
      
      # Data -------------------
      output$Rem_data <- renderRHandsontable({
        validate(
          need(df_filter, "Please Do Not Remove Remediation Database."))
        for (var in 1:length(names(filtered_table()))){
          nam<-names(filtered_table())[var]
          assign(nam, (filtered_table()[[var]]))
        }
        rhandsontable(df_filter, readOnly = T, rowHeaders = NULL, width = 2000, height = 600) %>%
          hot_cols(columnSorting = TRUE)
      })
      
      # Table of Evaluation Criteria -------------------
      output$Evaluation <- renderRHandsontable({
      rhandsontable(RemPotential,rowHeaders=NULL,width = 1200,allowedTags = "<span><i>")%>%
        hot_cols(columnSorting = TRUE) %>%
          hot_col(2:5,valign='htCenter')%>%
          hot_col(5, renderer = "html") %>%
          hot_col(5, renderer = htmlwidgets::JS("safeHtmlRenderer"))%>%
          hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)%>%
          hot_cols(colWidths = c(500, 80,100,80,80)) %>%
          htmlwidgets::onRender("function() {$('[data-toggle=tooltip]').tooltip()}")
      })
     
      EvalITRC <- reactiveVal()
      
      observeEvent(input$Evaluation,{
        EvalITRC<- hot_to_r(input$Evaluation)
        EvalITRC(EvalITRC)
      })
      
      output$Tchecked <-renderText({ 
        DF<- hot_to_r(input$Evaluation)
        paste("<H3>","Total Checked:", "<b> High: ", sum(DF$High),",</b></font>",
              "<b> Moderate: ", sum(DF$Moderate),",</b></font>",
              "<b> Low: ", sum(DF$Low),"</b></font>","</H3>")
        })
      
      
      # Return Dataframes ------------------
      
      return(list(
        results_table = reactive({
          req(results_table())
          results_table()}),
        EvalITRC = reactive({
          req(EvalITRC())
          EvalITRC()}),
        Tool4_Conc_goal = reactive({
          input$Conc_goal}),
        Tool4_Conc_site = reactive({
          input$Conc_site})
      ))
      
      }
  )
} # end Performance Server 