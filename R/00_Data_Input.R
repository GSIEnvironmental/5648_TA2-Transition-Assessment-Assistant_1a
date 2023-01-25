# Cleanup Goals Modules -----------------------------

## UI -----------------------------------------
Data_Input_UI <- function(id, label = "Data_Input"){
  ns <- NS(id)
  
  tabPanel("Data Input",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
             HTML("<h1><b>Input Data</h1></b>"),
             column(8,
                    HTML("<h3><i>Enter concentration and time data in the table below to be used in Tools 1 and 2.</i></h3><br>"))
           ), # end Page Title
           fluidRow(br(), 
             column(3, 
                    includeMarkdown("./www/00_Data_Input/Data_Input_Instructions.Rmd")),
             column(9,
                    fluidRow(# Buttons ---------------------
                      column(6, align = "right",
                             # actionButton(ns("instr_data"),
                             #              HTML("Additional Instructions"), style = button_style),
                             downloadButton(ns("save_data"),
                                          HTML("Save Data"), style = button_style4)),
                      # column(1, align = "right",
                      #        # actionButton(ns("instr_data"),
                      #        #              HTML("Additional Instructions"), style = button_style),
                      #        downloadButton(ns("save_location_data"),
                      #                       HTML("Save Location Data"), style = button_style4)),
                      column(6, style = "padding:21px;",
                             tags$style(HTML("
                             .shiny-input-container {
                               height: 31px;}")),
                             fileInput(ns("input_file"), label = NULL,  multiple = F,
                                       buttonLabel = "Upload Saved Data",
                                       accept = c("text/xlsx",
                                                  "text/comma-separated-values,text/plain",
                                                  ".xlsx"), width = "100%"))),
                    tabsetPanel(
                      # Tables -----------------
                      tabPanel(HTML("1. Concentration and Time Data"), br(),
                               rHandsontableOutput(ns("conc_time_data"))
                               ), # end concentration and time table
                      tabPanel(HTML("2. Monitoring Well Information"), br(),
                               rHandsontableOutput(ns("mw_data"))
                      ) # end concentration and time table
                    ), br()
                    )
           ) # end fluid row 
  ) # end tab panel
} # end Data Input UI  

## Server -------------------------------------
Data_Input_Server <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      # Reactive Variables -------------------
      # Concentration/Time Dataframe
      
      # check whether data is uploaded or not
      observeEvent(input$input_file,{
        # If no file is loaded nothing happens 
        if(!is.null(input$input_file)){
         
          file <- input$input_file
          temp_data <- read.xlsx(file$datapath, sheet = "Concentration_Time_Data", startRow = 2,
                                 check.names = F,detectDates=T)
          
          temp_data<-temp_data%>%
            mutate(Event = as.integer(Event))%>%
            #rename(Date = `Date.(Month/Day/Year)`)%>%
            mutate(Date = as.Date(temp_data$Date,origin="1900-01-01",tryFormats = c("%Y-%m-%d", "%Y/%m/%d","%m/%d/%Y","%m-%d-%Y")))
            
          
          temp_mw_info <- read.xlsx(file$datapath, sheet = "Monitoring_Well_Information", startRow = 2,
                                    check.names = F, sep.names = " ")
          
          d_conc <- reactiveVal(temp_data)
          
          d_loc <- reactiveVal(temp_mw_info)
          
          temp_data2<-temp_data%>%
            rename(`Date (Month/Day/Year)`=Date)
          
          output$conc_time_data <- renderRHandsontable({
            rhandsontable(temp_data2, rowHeaders = NULL, width = 1200, height = 600) %>%
              hot_cols(columnSorting = TRUE) %>%
              hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
          })
          
          output$mw_data <- renderRHandsontable({
            rhandsontable(temp_mw_info, rowHeaders = NULL, width = 1200, height = 600) %>%
              hot_cols(columnSorting = TRUE) %>%
              hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)
          })
          
        }
      })
      
      
      d_conc <- reactiveVal(temp_data)
      
      observeEvent(input$conc_time_data,{
        d_conc(hot_to_r(input$conc_time_data))
      })
      
      # Monitoring Well Information ----------
      d_loc <- reactiveVal(temp_mw_info)
      
      observeEvent(input$mw_data,{
        d_loc(hot_to_r(input$mw_data))
      })
      
         temp_data2<-temp_data%>%
           rename(`Date (Month/Day/Year)`=Date)
      
      
      output$conc_time_data <- renderRHandsontable({
        rhandsontable(temp_data2, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
        })
      
      output$mw_data <- renderRHandsontable({
        rhandsontable(temp_mw_info, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)
      })
      
      
      # Save Dataframes --------------------
      output$save_data <- downloadHandler(
        
        filename = function() {
          paste0("Concentration_Data", ".xlsx")
        },
        content = function(file) {
          
          if (is.null(input$mw_data)){
            list_of_datasets<-list(
            "Concentration_Time_Data" = hot_to_r(input$conc_time_data),
            "Location" = temp_mw_info
          )
          }else{
            list_of_datasets<-list(
              "Concentration_Time_Data" = hot_to_r(input$conc_time_data),
              "Location" = input$mw_data
            )
          }
          
          
          write.xlsx(list_of_datasets, file)
          
         
        }
        
      )
      
      # # Save Dataframes --------------------
      # output$save_location_data <- downloadHandler(
      #   
      #   filename = function() {
      #     paste0("MW_Data", ".xlsx")
      #   },
      #   content = function(file) {
      #     if(is.null(input$mw_data)){
      #       write.xlsx(temp_mw_info, file)
      #     }else{
      #       write.xlsx(hot_to_r(input$mw_data), file)
      #     }
      #     
      #   }
      #   
      # )
      # observeEvent(input$save_data,
      #              {if (!is.null(input$conc_time_data))
      #              {#Convert to R object
      #                
      #                if (is.null(input$mw_data)){
      #                  y<- temp_mw_info
      #                }else{
      #                  y <- hot_to_r(input$mw_data)
      #                }
      #                }
      #                content = function(x,y){
      #                    file.copy('Concentration_Data.xlsx',x)
      #                    file.copy('MW_Data.xlsx',y)
      #                  }
      #                  
      #                  content(x,y)
      #                  #write.xlsx(x, file = 'Concentration_Data.xlsx')
      #                  #write.xlsx(y, file = 'MW_Data.xlsx')
      #                  }
      #              )
      # 
      
      # Return Dataframes ------------------
      
      return(list(
        d_conc = reactive({
          req(d_conc())
          data_long(d_conc())}),
        d_loc = reactive({
          req(d_loc())
          data_mw_clean(d_loc())})))
    }
  )
} # end Data Input Server 
