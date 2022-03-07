## Heterogeneity Modules -----------------------------

## UI -------------------------------------------
HeterogeneityUI <- function(id, label = "07_Heterogeneity"){
  ns <- NS(id)
  
  tabPanel("7. Heterogeneity",
           
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 7. Understand how much geologic heterogeneity there is at a site.</h1></b>"),
                    #HTML("<h3><p style='color:red;'>This tool is currently under development.</h3></p>"),
                    column(6,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4>The tool determines four key matrix diffusion variables such as the presence of aquitards and geologic
                           lenses or layers in contact with your  plume.  With these data, the impact of matrix diffusion on making
                           remediation more difficult and the impact of cleanup times can be categorized as being Low, Moderate or High.</h4>")),
                    column(6,
                           HTML("<h3><b>How Does it Work?</b></h3>
                           <h4>You use pick one of four aquitard configurations for where the plume is in contact with overlying
                           or underlying aquitards.  Then you enter data from boring logs at your site to determine the impact of
                           geologic low permeability lenses that are in contact with the plume.</h4>"))),
           fluidRow(br(),
                    column(7,style='border-right: 5px solid black',
                           HTML("<h2><b>Input Data </b></h2>"),
                           tabsetPanel(
                             tabPanel(HTML('1. Introduction'),
                                      fluidRow(
                                        column(11,
                                               HTML("<h3><p style='color:blue;'><b>Learn about how to distinguish between transmissive (T-Zone)
                                 and low-permeability  zones (T-Zone vs. Low-k Zones).</h3></p></b>"),
                                               HTML("<h4><b>What is the Difference Between Transmissive and Low-K Media? </b>
                           A simple rule of the thumb is matrix diffusion effects are likely important if
                           two different horizontal geologic units with a hydraulic conductivity contrast
                           of a factor of 10 or more are in contact.  The rationale is with everything else
                           being equal,  the length of any plume that entirely through the lower permeable media
                           will be 10 times shorter than the actual plume length at a site.  For more detailed
                           explanation, click on the button below:</h4>"),
                                               actionButton(ns("Detailed_Explanation"), HTML("See more detaild explanation"), style = button_style)
                                               )# column
                                      )#fluid row end
                             ),#tabpanel
                             tabPanel(HTML('2. Select Aquifer Setting'),
                                      fluidRow(column(11,
                                                      HTML("<h3><p style='color:blue;'><b>Any aquitards in contact with plume?</h3></p></b>"),
                                                      fluidRow(column(6,
                                                                      HTML("<h4>Select one of the four aquitard configurations to the right.</h4>")
                                                                      ),
                                                               column(1,
                                                                      actionButton(ns("help1"), HTML("?"), style = button_style2)),
                                                               #actionButton(ns("help1"), HTML("Upload Saved Data"), style = button_style)),
                                                               column(5, align = "left", style = "padding:10px;",
                                                                      radioButtons(ns("aquitard"), NULL,
                                                                                   choices = list("Setting 1: No Matrix Diffusion " = 'No Matrix Diffusion',
                                                                                                  "Setting 2: Matrix Diffusion in Underlying Low-K Units" = 'Matrix Diffusion in Underlying Low-K Units',
                                                                                                  "Setting 3: Matrix Diffusion in Overlying Low-K Units" = 'Matrix Diffusionin Overlying Low-K Units',
                                                                                                  "Setting 4: Matrix Diffusion in Under and Overlying Low-K Units" = 'Matrix Diffusion in Under and Overlying Low-K Units'),
                                                                                   selected = 'Matrix Diffusion in Underlying Low-K Units', inline = FALSE,width='100%')
                                                               )),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      fluidRow(img(src = "./07_Heterogeneity/FIG/Tool7_fig2.png",
                                                                   width = "1000px", height = "452px"))
                                      )# fluid row
                                      )#column
                                      ),#tabpanel
                             tabPanel(HTML('3. Enter Boring Logs'),
                               fluidRow(column(11,
                                               HTML("<h3><p style='color:blue;'><b>Enter data for layers/lenses within the plume.</h3></p></b>"),
                                               column(4,
                                                      HTML("<h4>Enter low permeability (“Low-k”) layer/Lens data from one or more boring
                                logs into the data entry screen below.</h4>"),
                                                      actionButton(ns("help1"), HTML("See Example"), style = button_style),
                                                      actionButton(ns("help1"), HTML("?"), style = button_style2)),
                                               column(8, align = "left", style = "padding:10px;",
                                                      fluidRow(column(4, align = "left",
                                                                      HTML("Step 1. Enter typical top of plume in transmissive media (e.g., gravels, sands)
                                                in meters below ground surface")),
                                                               column(8, align = "left",
                                                                      numericInput(ns("TOP"), NULL, value = 10, min = 0))),
                                                      br(),
                                                      fluidRow(column(4, align = "left",
                                                                      HTML("Step 2. Enter typical bottom of plume in transmissive media (e.g., gravels, sands)
                                                in meters below ground surface:")),
                                                               column(8, align = "left",
                                                                      numericInput(ns("Bottom"), NULL, value = 21, min = 0))),
                                                      br(),
                                                      fluidRow(column(4, align = "left",
                                                                      HTML("Step 3.   For each low-layer/lens within plume zone
                                                (don't include upper or lower aquitards) enter thickness in meters."),
                                                                      br(),
                                                                      HTML("More Details:<ol>
                                           <li>Enter layers/lens data for at least three and up to 10 representative boring logs in the plume.</li>
                                           <li>Most boring logs will only have a few layers/lenses, leave all other entries blank </li>
                                           <li>See Module 7 J27 to understand definition of a low permeability (low-k) unit.</li>
                                           <li>For detailed information:  see Appendix 6 of REMChlor-MD User's Manual.</li></ol>")),
                                                               column(8, align = "left",
                                                                      rHandsontableOutput(ns("boring"))
                                                               )
                                                      )
                                               )
                               ) #fluid row
                               )#column
                                        
                             )#tabpanel
                             
                           )#tabsetpanel
                           ),# column
                    column(5,
                           fluidRow(align="left", style='padding-left:50px;',
                                    tags$style(HTML(".shiny-output-error-validation {
                             color: #ff0000;
                             font-weight: bold;
                             font-size: 18pt;}")),
                                    HTML("<h2><b>View Results</b></h2>"),
                                    HTML("<h3><p style='color:blue;'><b>See how much heterogeneity your site has for purpose of
                    a Remediation Transition Assessment.</h3></p></b>"),
                                    HTML("<h4>The heterogeneity calculator provides the following information about
                           how much matrix diffusion could impact remediation and remediation timeframes:</h4>")),#fluid row end
                           
                           fluidRow(br(),
                                    column(11,
                                           fluidRow(
                                             column(8,align = "right",
                                                    actionButton(ns("help1"), HTML("See Example"), style = button_style)),#column
                                             column(4,align = "left", style = "padding:15px;",
                                                    actionButton(ns("help1"), HTML("?"), style = button_style2))
                                           ),#fluidrow
                                           br(),
                                           br(),
                                           fluidRow(align = "center",style='padding-left:50px;',
                                                  gt_output(ns("Table1")),
                                                  br(),
                                                  gt_output(ns("Table2")),
                                                  br(),
                                                  htmlOutput(ns("SummaryResult"))
                                                  )#fluid row
                                           
                                           )#column
                                    
                           )#fluid row end
                    )#column end
           
           
  )
  )
} # end Heterogeneity UI         


## Server Module -----------------------------------------
HeterogeneityServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      # Reactive Variables -------------------
      # Concentration/Time Dataframe
      d_conc <- reactiveVal()

      observeEvent(input$boring,{
        d_conc(hot_to_r(input$boring))
      })

      # Monitoring Well Information ----------

      output$boring <- renderRHandsontable({
        rhandsontable(temp_boring, rowHeaders = NULL, width = 1200, height = 600) %>%
          hot_cols(columnSorting = TRUE) %>%
          hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
      })

      
      # Return Dataframes ------------------
      
      #return(list(d_conc = reactive(d_conc())))
      
      #### CHEAT SHEET for the calculation

      # chose option of aquitard contacting plume, choose one

      # option = c('No Matrix Diffusion',
      #            'Matrix Diffusion in Underlying Low-K Units',
      #            'Matrix Diffusionin Overlying Low-K Units',
      #            'Matrix Diffusion in Under and Overlying Low-K Units')
      # 
      # aquitard = option[2]

      # low K layer thickness
      #df <- read_excel("./data/5648_Dummy_Borling.xlsx")

      # plug-in the depth to top and bottom of plume in tranmissive area in meters
      # Top = 10
      # Bottom = 21
      Result_table <- reactiveVal()
      observe({
        req(input$boring,
            input$TOP,
            input$Bottom,
            input$aquitard)

        Result_table<- heterofunction(temp_boring,input$TOP,input$Bottom,input$aquitard)
    
        Result_table(Result_table)
      })

      Table1_Matrix <- reactive({
        validate(need(!is.na(Result_table()),""))

        Result_table <-Result_table()
        for (var in 1:length(names(Result_table))){
          nam<-names(Result_table)[var]
          assign(nam, (Result_table[[var]]))
        }
        Table1<- data.frame(Key =("Number of Aquitard Interfaces"),
                            Value = N_aquitard,
                            MD = Impact_diffusion)
        Table1
      })

      Table2_Matrix <- reactive({
        validate(need(!is.na(Result_table()),""))

        Result_table <-Result_table()
        for (var in 1:length(names(Result_table))){
          nam<-names(Result_table)[var]
          assign(nam, (Result_table[[var]]))
        }

        Table2<- data.frame(Key =c('Percent of aquifer thickness (B) that is tranmissive','Numbers of Layer'),
                            Value = c(round(Percent_B,2),round(N_layer,1)),
                            MD = Impact_diffusion2)
        Table2
      })


      # Results Table

      output$Table1<-render_gt(align = "center", {
        validate(need(!is.na(Table1_Matrix()),""))
        
        Table1<-Table1_Matrix()

        Table1<-gt(Table1)%>%
          cols_align(align=c('center'))%>%
          cols_label(Key = HTML("Key Matrix Diffusion<br>Variable for Aquitard(s)"),
                     Value = "Values from Step 2",
                     MD = HTML("Impact on<br>Matrix Diffusion"))%>%
          tab_style(style = list(cell_borders(sides = "all",
                                              style = "solid",
                                              weight = px(2),
                                              color = "#D3D3D3"),
                                 cell_text(align = "center",
                                           v_align = "middle")),
                    locations = cells_body())%>%
          cols_width(vars(Key) ~ px(350),
                     vars(MD) ~ px(150),
                      everything() ~ px(120)
                    )

        
        opt_table_outline(Table1)
      })




      output$Table2<-render_gt(align = "center", {
        validate(need(!is.na(Table2_Matrix()),""))

        Table2<-Table2_Matrix()

        Table2<- gt(Table2)%>%
          cols_align(align=c('center'))%>%
          cols_label(Key = HTML("Key Matrix Diffusion<br>Variable for Layers/Lenses(s)"),
                     Value = "Values from Step 3",
                     MD = HTML("Impact on<br>Matrix Diffusion"))%>%
          fmt_number(columns = c(2), rows = c(2), decimals = 0, use_seps=FALSE)%>%
          tab_style(style = list(cell_borders(sides = "all",
                                              style = "solid",
                                              weight = px(2),
                                              color = "#D3D3D3"),
                                 cell_text(align = "center",
                                           v_align = "middle")),
                    locations = cells_body())%>%
          cols_width(vars(Key) ~ px(350),
                     vars(MD) ~ px(150),
                     everything() ~ px(120)
          )
        opt_table_outline(Table2)
      })


      ## Export title of plotly ---------------------
      output$SummaryResult <- renderText({ 
        
        validate(need(!is.na(Table2_Matrix()),""),
                 need(!is.na(Table1_Matrix()),""),
                 need(!is.na(Result_table()),""))
        
        Table1<-Table1_Matrix()
        Table2<-Table2_Matrix()
        
        Result_table = Result_table()

        
        glue("<H3>","Combined step 2 and 3,","</H3>",
             "<H3>","overall impact on matrix diffusion is ",
             "<font color=\"#ff0000\"><b>", Result_table$Overall,
             "</b></font>",".","</H3>"
          )

        
        
      })
      #----- help function 
      observeEvent(input$Detailed_Explanation,
                   {Helpboxfunction('FIG/Tool7_fig3.png','"./07_Heterogeneity/',619,693)}
                   )
      

    
      
      
      
    }
  )
} # end Heterogeneity Server 



