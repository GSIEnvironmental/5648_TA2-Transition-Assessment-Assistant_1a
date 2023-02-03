## Matrix Diffusion Modules -----------------------------

## UI Module --------------------------------------
EnhanceMNAUI <- function(id, label = "07_EnhanceMNA"){
  ns <- NS(id)
  
  tabPanel("7. EA",
           #tags$h1(tags$b("Tool 5. Model a groundwater plume and account for matrix diffusion.")),
           tabsetPanel(
             
             tabPanel(HTML("7a Introduction"),
                      HTML("<H2>Tool 7a. How to enhance Monitored Natural Attenuation processes</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7a.md'))
             ), 
             tabPanel(HTML("7b EA for Sources"),
                      HTML("<H2>Tool 7b. Source Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7b.md'))
             ), 
             tabPanel(HTML("7c EA for Plumes"),
                      HTML("<H2>Tool 7c. Plume Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7c.md'))
                      ), 
             tabPanel(HTML("7d EA for Discharges"),
                      HTML("<H2>Tool 7d. Discharge Enhacement Zone (ITRC, 2008)</H2>"),
                      br(),
                      fluidRow(includeMarkdown('./www/07_MNA/Tool7d.md'))
             ), 
             tabPanel(HTML("7e EA Decision Chart"),
                      HTML("<H2>Tool 7e. EA Decision Chart</H2>"),
                      br(),
                      DT::dataTableOutput(ns("my_data_table")),
                      br(),
                      textOutput(ns("myText"))  
                      
             )
             
           ))
} # end Matrix Diffusion UI         


## Server Module -----------------------------------------
EnhanceMNAServer <- function(id, data_input, nav) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      # Table of Evaluation Criteria -------------------
      browser
      output$Evaluation <- renderRHandsontable({
        rhandsontable(RemPotential)
        
      })
      
      # return RTAI value
      myValue <- reactiveValues()
      
      # function for shinyInput
      shinyInput <- function(FUN, len, row, id, label,...) {
        browser()
        inputs <- character(len)
        for (i in seq_len(len)) {
          
          inputs[i] <- as.character(FUN(paste0(id, i,'_',row), label[i],...))
        }
        inputs
      }

      # generate table
      my_data_table <- reactive({
        tibble::tibble(
          `<30 ft` = shinyInput(actionButton, 3, 1,
                                'button_',
                                label =  Table7_EA$`<30 ft`,#"Fire",
                                onclick = paste0('Shiny.onInputChange( \"select_button\" , this.id)')) ,
          `30-60 ft` = shinyInput(actionButton, 3, 2,
                                  'button_',
                                  label =  Table7_EA$`30-60 ft`,#"Fire",
                                  onclick = paste0('Shiny.onInputChange( \"select_button\" , this.id)')) ,
          `>60 ft` = shinyInput(actionButton, 3, 3,
                                'button_',
                                label =  Table7_EA$`>60 ft`,#"Fire",
                                onclick = paste0('Shiny.onInputChange( \"select_button\" , this.id)')
          ),
          rowname = Table7_EA$...1
        )
      })
      
      # generate table
      output$my_data_table <- renderDataTable({
        tibble::column_to_rownames(my_data_table(),var = "rowname")
      }, escape = FALSE,options = list(searching = FALSE,paging=FALSE,info=FALSE))
      
      
      # extract RTAI from select button
      observeEvent(input$select_button, {
        browser()
        selectedRow <- as.numeric(strsplit(input$select_button, "_")[[1]][2])
        selectedcol <- as.numeric(strsplit(input$select_button, "_")[[1]][3])
        RTAI = strsplit(my_data_table()[selectedRow,selectedcol][[1]],"[</>]")[[1]][3]
        myValue$check <<- paste('click on ',RTAI)
        
      })
      
      # value for checking
      output$myText <- renderText({
        myValue$check
      })
      
      # Return Dataframes ------------------
      
      return(list(
        RTAI_EA = reactive({
          req(myValue$check)
          myValue$check})
      ))
      
    }
  )
} # end Matrix Diffusion Server 

