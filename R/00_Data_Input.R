# Cleanup Goals Modules -----------------------------

## UI -----------------------------------------
Data_Input_UI <- function(id, label = "Data_Input"){
  ns <- NS(id)
  
  tabPanel("Data Input",
           # Page Title ------
           fluidRow(style='border-bottom: 5px solid black',
             HTML("<h1><b>Input Data</h1></b>"),
             column(8,
                    HTML("<h3><i>Enter concentration and time data in the table below to be used in Tools 1, 2, and 5.</i></h3><br>"))
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
                                          HTML("Download Input File"), style = button_style4)),
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
                      tabPanel(HTML("2. Concentration and Time Data for Tool 5"), br(),
                               rHandsontableOutput(ns("conc_time_data_tool5"))
                               ), # end concentration and time table
                      tabPanel(HTML("3. Monitoring Well Information"), br(),
                               HTML("<b style='color: red;'>Important Note</b><br>
                                    If you possess either latitude/longitude coordinates 
                                    or northing/easting coordinates, you are obligated to
                                    provide EPSG information from this website 
                                    <a href='https://epsg.io/'>https://epsg.io/</a>.<br>
                                    However, 
                                    if you prefer to calculate latitude/longitude from 
                                    northing/easting coordinates independently, you can 
                                    utilize one of the following steps. 
                                    <ul>
                                      <li>Use surveying data from an official survey of the wells.</li>
                                      <li>Obtain a site map, georeferenced the map in an GIS system, 
                                      and obtain the lat/long data.</li>
                                      <li>Estimate monitoring locations in a Google Earth map, add 
                                      Placemarks and get lat/long in decimal degrees</li>
                                      <li>If you have data in degrees/min/sec, convert to decimal 
                                      degrees at  web sites like this: <br> 
                                      <a href='https://www.latlong.net/degrees-minutes-seconds-to-decimal-degrees'>
                                      https://www.latlong.net/degrees-minutes-seconds-to-decimal-degrees</a></li>
                                    </ul>
                                    It is 
                                    crucial to ensure that the wells utilized in tool 5 
                                    have consistent coordinate systems for northing/easting."),
                               rHandsontableOutput(ns("mw_data"))
                      ) # end concentration and time table
                    ), br()
                    )
           ) # end fluid row 
  ) # end tab panel
} # end Data Input UI  

## Server -------------------------------------
Data_Input_Server <- function(id,Plume,nav) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      # Reactive Variables -------------------
      # Concentration/Time Dataframe
      mw_Tb5 = checksilenterror(Plume$Plume())
      if (mw_Tb5 != 'error'){
        temp_mw_info <-Plume$Plume()
      }
      # check whether data is uploaded or not
      observeEvent(input$input_file,{
        # If no file is loaded nothing happens 
        if(!is.null(input$input_file)){
         
          file <- input$input_file
          
          # tool 1 and 2 database
          temp_data <- read.xlsx(file$datapath, sheet = "Concentration_Time_Data", startRow = 1,
                                 check.names = F,detectDates=T)
          
          temp_data<-temp_data%>%
            mutate(Event = as.integer(Event))%>%
            #rename(Date = `Date.(Month/Day/Year)`)%>%
            mutate(Date = as.Date(temp_data$Date,origin="1900-01-01",tryFormats = c("%Y-%m-%d", "%Y/%m/%d","%m/%d/%Y","%m-%d-%Y")))
          
          # tool 5 database  
          temp_data_tool5 <- read.xlsx(file$datapath, sheet = "Tool5_Concentration_Time_Data", startRow = 1,
                                 check.names = F,detectDates=T)
          
          temp_data_tool5<-temp_data_tool5%>%
            mutate(Event = as.integer(Event))%>%
            #rename(Date = `Date.(Month/Day/Year)`)%>%
            mutate(Date = as.Date(temp_data_tool5$Date,origin="1900-01-01",tryFormats = c("%Y-%m-%d", "%Y/%m/%d","%m/%d/%Y","%m-%d-%Y")))
          
          temp_mw_info <- read.xlsx(file$datapath, sheet = "Monitoring_Well_Information", startRow = 1,
                                    check.names = F, sep.names = " ")
          
          # populate lat/long if data is missing
          for (j in 1:nrow(temp_mw_info)){
            if (is.na(temp_mw_info$Latitude[j])||is.na(temp_mw_info$Longitude[j])){
              clip_mw_info <- temp_mw_info[,c("Easting","Northing")][j,1:2]
              coordinates(clip_mw_info) <- ~ Easting  + Northing
              proj4string(clip_mw_info) <- CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j]))
              clip_mw_info <- spTransform(clip_mw_info, CRS("+init=epsg:4326"))
              temp_mw_info$Latitude[j] = clip_mw_info@coords[2]
              temp_mw_info$Longitude[j] = clip_mw_info@coords[1]
            }
            if (is.na(temp_mw_info$Easting[j])||is.na(temp_mw_info$Northing[j])){
              clip_mw_info <- temp_mw_info[,c("Longitude","Latitude")][j,1:2]
              coordinates(clip_mw_info) <- ~ Longitude  + Latitude
              proj4string(clip_mw_info) <- CRS("+init=epsg:4326")
              clip_mw_info <- spTransform(clip_mw_info, CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j])))
              temp_mw_info$Northing[j] = clip_mw_info@coords[2]
              temp_mw_info$Easting[j] = clip_mw_info@coords[1]
            }
            source_coord = temp_mw_info%>%filter(`Monitoring Wells`=='Source Well')
            temp_mw_info <- temp_mw_info%>%
              mutate(`Distance from Source (m)` = ifelse(`Monitoring Wells`%in%colnames(temp_data_tool5)[6:ncol(temp_data_tool5)],
                                                         sqrt((Easting-source_coord$Easting)^(2)+
                                                                (Northing-source_coord$Northing)^(2)),NA)
              )
          }
          
          d_conc <- reactiveVal(temp_data)
          
          d_conc_tool5 <- reactiveVal(temp_data_tool5)
          
          d_loc <- reactiveVal(temp_mw_info)
          
          temp_data2<-temp_data%>%
            rename(`Date (Month/Day/Year)`=Date)
          
          temp_data2_tool5<-temp_data_tool5%>%
            rename(`Date (Month/Day/Year)`=Date)
          
          output$conc_time_data <- renderRHandsontable({
            rhandsontable(temp_data2, rowHeaders = NULL, width = 1200, height = 600) %>%
              hot_cols(columnSorting = TRUE) %>%
              hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
          })
          
          output$conc_time_data_tool5 <- renderRHandsontable({
            rhandsontable(temp_data2_tool5, rowHeaders = NULL, width = 1200, height = 600) %>%
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
      

      # Reactive Variables -------------------
      d_conc <- reactiveVal(temp_data)
      
      observeEvent(input$conc_time_data,{
        d_conc(hot_to_r(input$conc_time_data))
      })
      
      d_conc_tool5 <- reactiveVal(temp_data_tool5)
      
      observeEvent(input$conc_time_data_tool5,{
        d_conc_tool5(hot_to_r(input$conc_time_data_tool5))
      })
      

      # Monitoring Well Information ----------

      
      
      # for (j in 1:nrow(temp_mw_info)){
      #   if (is.na(temp_mw_info$Latitude[j])||is.na(temp_mw_info$Longitude[j])){
      #     clip_mw_info <- temp_mw_info[,c("Easting","Northing")][j,1:2]
      #     coordinates(clip_mw_info) <- ~ Easting  + Northing
      #     proj4string(clip_mw_info) <- CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j]))
      #     clip_mw_info <- spTransform(clip_mw_info, CRS("+init=epsg:4326"))
      #     temp_mw_info$Latitude[j] = clip_mw_info@coords[2]
      #     temp_mw_info$Longitude[j] = clip_mw_info@coords[1]
      #   }
      #   
      #   if (is.na(temp_mw_info$Easting[j])||is.na(temp_mw_info$Northing[j])){
      #     clip_mw_info <- temp_mw_info[,c("Longitude","Latitude")][j,1:2]
      #     coordinates(clip_mw_info) <- ~ Longitude  + Latitude
      #     proj4string(clip_mw_info) <- CRS("+init=epsg:4326")
      #     clip_mw_info <- spTransform(clip_mw_info, CRS(paste0("+init=epsg:",temp_mw_info$EPSG[j])))
      #     temp_mw_info$Northing[j] = clip_mw_info@coords[2]
      #     temp_mw_info$Easting[j] = clip_mw_info@coords[1]
      #   }
      #   source_coord = temp_mw_info%>%filter(`Monitoring Wells`=='Source Well')
      # 
      #   temp_mw_info <- temp_mw_info%>%
      #     mutate(`Distance from Source (m)` = ifelse(`Monitoring Wells`%in%colnames(temp_data_tool5)[6:ncol(temp_data_tool5)],
      #                                                sqrt((Easting-source_coord$Easting)^(2)+
      #                                                       (Northing-source_coord$Northing)^(2)),NA)
      #     )
      # }
      

      d_loc <- reactiveVal(temp_mw_info)

      # eventReactive(id,{
      #   mw_Tb5 = checksilenterror(Plume$Plume())
      #   if (mw_Tb5 != 'error'){
      #     temp_mw_info <-Plume$Plume()
      #   }
      #   browser()
      #   d_loc(temp_mw_info)
      # })
      
      observeEvent({
        input$mw_data
        nav()
        },{
          req(nav()=='Data Input')
        mw_Tb5 = checksilenterror(Plume$Plume())
        if (mw_Tb5 != 'error'){
          temp_mw_info <-Plume$Plume()
        }
       
          if (!is.null(input$mw_data$changes$source)){
            temp_mw_info<-hot_to_r(input$mw_data)
          }else{
            temp_mw_info = temp_mw_info
          }
          
        # }
        d_loc(temp_mw_info)
      })
      
      temp_data2<-temp_data%>%
           rename(`Date (Month/Day/Year)`=Date)
      
      temp_data2_tool5<-temp_data_tool5%>%
           rename(`Date (Month/Day/Year)`=Date)
      
      
         
      output$conc_time_data <- renderRHandsontable({
        rhandsontable(temp_data2, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
        })
      
      output$conc_time_data_tool5 <- renderRHandsontable({
        rhandsontable(temp_data2_tool5, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
      })
      
      output$mw_data <- renderRHandsontable({
        rhandsontable(d_loc(), rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)
      })
      

      # Save Dataframes --------------------
      output$save_data <- downloadHandler(
        
        filename = function() {
          paste0("Concentration_Data", ".xlsx")
        },
        content = function(file) {
          
          
          if (is.null(input$mw_data)&is.null(input$conc_time_data_tool5)){
            conc_time_data_export <-hot_to_r(input$conc_time_data)%>%
              rename(Date=`Date (Month/Day/Year)`)
            
            list_of_datasets<-list(
            "Concentration_Time_Data" = conc_time_data_export,
            "Tool5_Concentration_Time_Data" = temp_data_tool5,
            "Monitoring_Well_Information" = temp_mw_info
          )
          }else if (is.null(input$mw_data)){
            conc_time_data_export <-hot_to_r(input$conc_time_data)%>%
              rename(Date=`Date (Month/Day/Year)`)
            
            conc_time_data_tool5_export<-hot_to_r(input$conc_time_data_tool5)%>%
              rename(Date=`Date (Month/Day/Year)`)
            
            list_of_datasets<-list(
              "Concentration_Time_Data" = conc_time_data_export,
              "Tool5_Concentration_Time_Data" = conc_time_data_tool5_export,
              "Monitoring_Well_Information" = temp_mw_info
            )
          }else{
            conc_time_data_export <-hot_to_r(input$conc_time_data)%>%
              rename(Date=`Date (Month/Day/Year)`)
            
            conc_time_data_tool5_export<-hot_to_r(input$conc_time_data_tool5)%>%
              rename(Date=`Date (Month/Day/Year)`)
            
            list_of_datasets<-list(
              "Concentration_Time_Data" = conc_time_data_export,
              "Tool5_Concentration_Time_Data" = conc_time_data_tool5_export,
              "Monitoring_Well_Information" = hot_to_r(input$mw_data)
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
        d_conc_tool5 = reactive({
          req(d_conc_tool5())
          data_long(d_conc_tool5(),con_name = "Concentration_org")}),
        d_loc = reactive({
          req(d_loc())
          data_mw_clean(d_loc())})))
    }
  )
} # end Data Input Server 
