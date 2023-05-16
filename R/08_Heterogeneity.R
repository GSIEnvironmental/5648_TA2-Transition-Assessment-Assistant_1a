## Heterogeneity Modules -----------------------------

## UI -------------------------------------------
HeterogeneityUI <- function(id, label = "08_Heterogeneity"){
  ns <- NS(id)
  
  tabPanel("8. Heterogeneity",
           
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 8. Understand how much geologic heterogeneity there is at a site.</h1></b>"),
                    #HTML("<h3><p style='color:red;'>This tool is currently under development.</h3></p>"),
                    column(6,
                           HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4>This tool defines key site-specific features 
                                that contribute to matrix diffusion, including the presence of 
                                aquitards and the distribution of low-permeability layers and 
                                lenses within your plume. With this information, the impact of 
                                matrix diffusion on remediation performance and cleanup times 
                                can be categorized as Low, Moderate, or High.</h4>")),
                    column(6,
                           HTML("<h3><b>How Does it Work?</b></h3>
                           <h4>You pick one of the four Aquifer Settings that is most 
                                representative of the geologic conditions for the plume 
                                at your site (“Select Aquifer Settings” tab).  Then you 
                                enter data from borings logs from your site to determine 
                                the distribution of low permeability layers/lenses that 
                                are in contact with the plume (“Enter Boring Logs” tab).  
                                The data from these two tabs are used to establish the 
                                geologic heterogeneity at the site and its potential 
                                impact on remediation.  The impact is based on modeling 
                                simulations performed using the REMChlor-MD model 
                                (see Borden and Cha, 2021 and Farhat et al., 2018).</h4>"))
                    ),
           fluidRow(br(),
                    column(7,#style='border-right: 5px solid black',
                           HTML("<h2><b>Input Data </b></h2>"),
                           tabsetPanel(
                             tabPanel(HTML('1. Introduction'),
                                      fluidRow(
                                        column(11,
                                               HTML("<h3><p style='color:#337ab7;'><b>Learn how to distinguish between transmissive (T-Zone)
                                 and low-permeability  zones (Low-k Zones).</h3></p></b>"),
                                               HTML("<h4>What is the difference between transmissive and low-K media? A simple rule of thumb 
                                                    is that matrix diffusion effects are likely important when two geologic units that are in 
                                                    contact with each other have horizontal hydraulic conductivity values that differ by an order 
                                                    of magnitude (factor of 10) or more.  The rationale is that—with everything else being equal—
                                                    the length a plume that is entirely in the lower-K zone will be 10 times shorter than the 
                                                    plume length if contamination was entirely in the higher-k zone.  For a more detailed 
                                                    explanation, click on the button below:</h4>"),
                                               HTML("<h3><b>References</b></h3>"),
                                               HTML("<h4>Borden, R.C. and Cha, K.Y., 2021. Evaluating the impact of back diffusion on groundwater cleanup time. 
                                               Journal of Contaminant Hydrology, 243, p.103889.</h4>"),
                                               HTML("<h4>Farhat, S.K., C.J. Newell, R.W. Falta, and K. Lynch, 2018. REMChlor-MD User’s Manual, 
                                               developed for the Environmental Security Technology Certification Program (ESTCP) by GSI Environmental Inc., 
                                               Houston, Texas and Clemson University, Clemson, South Carolina.</h4>"),
                                               br(),
                                               actionButton(ns("Detailed_Explanation"), HTML("See more detailed explanation"), style = button_style)
                                               )# column
                                        )#fluid row end
                                      ),#tabpanel
                             tabPanel(HTML('2. Select Aquifer Setting'),
                                      fluidRow(column(11,
                                                      HTML("<h3><p style='color:#337ab7;'><b>Any aquitards in contact with plume?</h3></p></b>"),
                                                      fluidRow(column(7,
                                                                      HTML("<h4>Select which one of the four aquifer settings that 
                                                                           is most representative of your site.</h4>")
                                                                      ),
                                                               column(5, align = "left", style = "padding:10px;",
                                                                      radioButtons(ns("aquitard"), NULL,
                                                                                   choices = list("Setting 1: No Matrix Diffusion " = 'No Matrix Diffusion',
                                                                                                  "Setting 2: Matrix Diffusion in Underlying Low-K Units" = 'Matrix Diffusion in Underlying Low-K Units',
                                                                                                  "Setting 3: Matrix Diffusion in Overlying Low-K Units" = 'Matrix Diffusionin Overlying Low-K Units',
                                                                                                  "Setting 4: Matrix Diffusion in Under and Overlying Low-K Units" = 'Matrix Diffusion in Under and Overlying Low-K Units'),
                                                                                   selected = 'Matrix Diffusion in Underlying Low-K Units', inline = FALSE,width='100%')
                                                                      )
                                                               ),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      br(),
                                                      fluidRow(img(src = "./08_Heterogeneity/FIG/Tool8_fig2.png",
                                                                   width = "1000px", height = "452px"))
                                                      )# column
                                               )#fluidrow
                                      ),#tabpanel
                             tabPanel(HTML('3. Enter Boring Logs'),
                               fluidRow(column(12,
                                               HTML("<h3><p style='color:#337ab7;'><b>Enter data for layers/lenses within the plume.</h3></p></b>"),
                                               
                                               fluidRow(align = "left", style = "padding:10px;",
                                                        
                                                        fluidRow(column(10,align ='center',
                                                               actionButton(ns("help1"), HTML("See Example"), style = button_style)
                                                               ),
                                                        br(),
                                                        fluidRow(column(10, align = "left",
                                                                      HTML("<b>Step 1</b>. Enter typical depth of top of plume in 
                                                                      transmissive media (e.g., gravels, sands) in meters below ground surface")
                                                                      ),
                                                                 column(2, align = "left",
                                                                      numericInput(ns("TOP"), NULL, value = 10, min = 0)
                                                                      )
                                                                 ),
                                                        br(),
                                                        fluidRow(column(10, align = "left",
                                                                      HTML("<b>Step 2</b>. Enter typical depth of bottom 
                                                                      of plume in transmissive media (e.g., gravels, sands) in meters below ground surface:")
                                                                      ),
                                                                 column(2, align = "left",
                                                                      numericInput(ns("Bottom"), NULL, value = 21, min = 0)
                                                                      )
                                                                 ),
                                                        br(),
                                                        fluidRow(
                                                          column(10, align = "left",
                                                                      HTML("<b>Step 3</b>. Enter low permeability (“Low-k”) 
                                                                      layer/lens data from one or more boring logs 
                                                                      into the data entry screen below.For <u>each</u> 
                                                                      low-K layer/lens within the plume zone enter thickness 
                                                                      in meters. Do not include upper or lower aquitards."),
                                                                      br(),
                                                                      br(),
                                                                      HTML("More Details:<ol>
                                                                      <li>Enter layers/lens data for at least 3 and up to 10 
                                                                      representative boring logs in the plume.</li>
                                                                      <li>Most boring logs will only have a few layers/lenses; leave 
                                                                      all other entries blank </li><li>For detailed information:  see Appendix 6 
                                                                           of REMChlor-MD User's Manual.</li></ol>")
                                                                 )
                                                          ),
                                                        br(),
                                                        br(),
                                                        # fluidRow( #<li>See Module 7 J27 to understand definition of a low permeability (low-k) unit.</li>
                                                        #        column(10, align = "right",
                                                        #               HTML("<br>     </br>Low-K layer/lens (m thick)"))
                                                        #        ),
                                                        fluidRow(
                                                          column(2,),
                                                          column(10,align = "left",
                                                                        rHandsontableOutput(ns("boring"))
                                                                        )
                                                                 )
                                                                   
                                                        )#fluidRow
                                               )#column
                                        ) #fluid row
                                        )#tabpanel
                               )#tabsetpanel
                             ),# column
                           ),
                    column(5,
                           fluidRow(align="left", style='padding-left:10px;',
                                    tags$style(HTML(".shiny-output-error-validation {
                             color: #ff0000;
                             font-weight: bold;
                             font-size: 18pt;}")),
                                    HTML("<h2><b>View Results</b></h2>"),
                                    HTML("<h3><p style='color:#337ab7;'><b>See how much heterogeneity your site has for purposes of
                    a Remediation Transition Assessment.</h3></p></b>"),
                                    HTML("<h4>The heterogeneity calculator provides the following information about
                           how much matrix diffusion could impact remediation and remediation timeframes:</h4>")),#fluid row end
                           
                           fluidRow(br(),
                                    column(11,
                                           fluidRow(
                                             column(8,align = "right",
                                                    actionButton(ns("help1"), HTML("See Example"), style = button_style))
                                             
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
        
        rhandsontable(temp_boring,rowHeaders = NULL, width  = 1200, height = 600) %>%
          hot_col(col = colnames(temp_boring)[2],columnSorting = TRUE,colWidths = 150) %>%
          hot_col(col = colnames(temp_boring)[3],columnSorting = TRUE,colWidths = 150) %>%
          hot_col(col = colnames(temp_boring)[4],columnSorting = TRUE,colWidths = 150) %>%
          hot_col(col = colnames(temp_boring)[5],columnSorting = TRUE,colWidths = 150) %>%
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

        Table2<- data.frame(Key =c('Percent of aquifer thickness (B) that is transmissive','Number of layers'),
                            Value = c(signif(Percent_B,2),round(N_layer,1)),
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
                     Value = "# of Aquitards",
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
          cols_label(Key = HTML("Key Matrix Diffusion<br>Variable for Layers/Lenses"),
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

        
        glue("<H3>","Combining values from all steps,","</H3>",
             "<H3>","the overall impact on matrix diffusion is expected to be ",
             "<font color=\"#ff0000\"><b>", Result_table$Overall,
             "</b></font>",".","</H3>"
          )

        
        
      })
      #----- help function 
      observeEvent(input$Detailed_Explanation,
                   {Helpboxfunction('FIG/Tool8_fig3.png','"./08_Heterogeneity/',864,843)}
                   )
      

    
      
      
      
    }
  )
} # end Heterogeneity Server 



