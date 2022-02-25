## Heterogeneity Modules -----------------------------

## UI -------------------------------------------
HeterogeneityUI <- function(id, label = "07_Heterogeneity"){
  ns <- NS(id)
  
  tabPanel("7. Heterogeneity",
           
           fluidRow(style='border-bottom: 5px solid black',
                    HTML("<h1><b>Tool 7. Understand how much geologic heterogeneity there is at a site.</h1></b>"),
                    HTML("<h3><p style='color:red;'>This tool is currently under development.</h3></p>"))
                    # column(6,
                    #        HTML("<h3><b>What Does this Tool Do?</b></h3>
                    #        <h4>The tool determines four key matrix diffusion variables such as the presence of aquitards and geologic 
                    #        lenses or layers in contact with your  plume.  With these data, the impact of matrix diffusion on making 
                    #        remediation more difficult and the impact of cleanup times can be categorized as being Low, Moderate or High.</h4>")),
                    # column(6,
                    #        HTML("<h3><b>How Does it Work?</b></h3>
                    #        <h4>You use pick one of four aquitard configurations for where the plume is in contact with overlying 
                    #        or underlying aquitards.  Then you enter data from boring logs at your site to determine the impact of 
                    #        geologic low permeability lenses that are in contact with the plume.</h4>"))),
           # fluidRow(br(),
           #          HTML("<h3><p style='color:blue;'><b>Step 1.  Learn about how to distinguish between transmissive (T-Zone) 
           #               and low-permeability  zones (T-Zone vs. Low-k Zones).</h3></p></b>"),
           #          column(10,
           #                 HTML("<h4><b>What is the Difference Between Transmissive and Low-K Media? </b>
           #                 A simple rule of the thumb is matrix diffusion effects are likely important if  
           #                 two different horizontal geologic units with a hydraulic conductivity contrast 
           #                 of a factor of 10 or more are in contact.  The rationale is with everything else 
           #                 being equal,  the length of any plume that entirely through the lower permeable media 
           #                 will be 10 times shorter than the actual plume length at a site.  For more detailed
           #                 explanation, click on the button below:</h4>")),
           #          column(2, align = "left", style = "padding:10px;",
           #                 actionButton(ns("help1"), HTML("See more detaild explanation"), style = button_style))
           #          ),
           # fluidRow(br(),
           #          HTML("<h3><p style='color:blue;'><b>Step 2 Any aquitards in contact with plume?</h3></p></b>"),
           #          column(3,
           #                 HTML("<h4>Select one of the four aquitard configurations to the right.</h4>"),
           #                 actionButton(ns("help1"), HTML("?"), style = button_style2),
           #                 actionButton(ns("help1"), HTML("Upload Saved Data"), style = button_style)),
           #          column(9, align = "left", style = "padding:10px;",
           #                 radioButtons(ns("aquitard"), NULL,
           #                              choices = list("Setting 1: No Matrix Diffusion " = 'No Matrix Diffusion',
           #                                             "Setting 2: Matrix Diffusion in Underlying Low-K Units" = 'Matrix Diffusion in Underlying Low-K Units',
           #                                             "Setting 3: Matrix Diffusionin Overlying Low-K Units" = 'Matrix Diffusionin Overlying Low-K Units',
           #                                             "Setting 4: Matrix Diffusion in Under and Overlying Low-K Units" = 'Matrix Diffusion in Under and Overlying Low-K Units'),
           #                              selected = 'Matrix Diffusion in Underlying Low-K Units', inline = TRUE))
           #          ),
           # fluidRow(br(),
           #          HTML("<h3><p style='color:blue;'><b>Step 3: Enter data for layers/lenses within the plume.</h3></p></b>"),
           #          column(3,
           #                 HTML("<h4>Enter low permeability (“Low-k”) layer/Lens data from one or more boring 
           #                      logs into the data entry screen below.</h4>"),
           #                 actionButton(ns("help1"), HTML("?"), style = button_style2),
           #                 actionButton(ns("help1"), HTML("See Example"), style = button_style)),
           #          column(9, align = "left", style = "padding:10px;",
           #                 fluidRow(column(4, align = "left", 
           #                                 HTML("Step 1. Enter typical top of plume in transmissive media (e.g., gravels, sands) 
           #                                      in meters below ground surface")),
           #                          column(8, align = "left",
           #                                 numericInput(ns("TOP"), NULL, value = 10, min = 0))),
           #                 br(),
           #                 fluidRow(column(4, align = "left", 
           #                                 HTML("Step 2. Enter typical bottom of plume in transmissive media (e.g., gravels, sands) 
           #                                      in meters below ground surface:")),
           #                          column(8, align = "left",
           #                                 numericInput(ns("Bottom"), NULL, value = 21, min = 0))),
           #                 br(),
           #                 fluidRow(column(4, align = "left", 
           #                                 HTML("Step 3.   For each low-layer/lens within plume zone 
           #                                      (don't include upper or lower aquitards) enter thickness in meters."),
           #                                 br(),
           #                                 HTML("More Details:<ol>
           #                                 <li>Enter layers/lens data for at least three and up to 10 representative boring logs in the plume.</li>
           #                                 <li>Most boring logs will only have a few layers/lenses, leave all other entries blank </li>
           #                                 <li>See Module 7 J27 to understand definition of a low permeability (low-k) unit.</li>
           #                                 <li>For detailed information:  see Appendix 6 of REMChlor-MD User's Manual.</li></ol>")),
           #                          column(8, align = "left",
           #                                 rHandsontableOutput(ns("boring"))
           #                                 ))
           # 
           #                 )
           #          ),
           # fluidRow(br(),
           #          HTML("<h3><p style='color:blue;'><b>Step 4.  See how much heterogeneity your site has for purpose of 
           #          a Remediation Transition Assessment.</h3></p></b>"),
           #          column(3,
           #                 HTML("<h4>The heterogeneity calculator provides the following information about
           #                 how much matrix diffusion could impact remediation and remediation timeframes:</h4>"),
           #                 actionButton(ns("help1"), HTML("?"), style = button_style2),
           #                 actionButton(ns("help1"), HTML("See Example"), style = button_style)),
           #          column(9,align = "center",
           #                 gt_output(ns("Table1")),
           #                 br(),
           #                 gt_output(ns("Table2")))
           #          )
  )
} # end Heterogeneity UI         


## Server Module -----------------------------------------
HeterogeneityServer <- function(id) {
  moduleServer(
    id,
    
    function(input, output, session) {
      
      # Reactive Variables -------------------
      # Concentration/Time Dataframe
      # d_conc <- reactiveVal()
      # 
      # observeEvent(input$boring,{
      #   d_conc(hot_to_r(input$boring))
      # })
      # 
      # # Monitoring Well Information ----------
      # 
      # output$boring <- renderRHandsontable({
      #   rhandsontable(temp_boring, rowHeaders = NULL, width = 1200, height = 600) %>%
      #     hot_cols(columnSorting = TRUE) %>%
      #     hot_context_menu(allowRowEdit = TRUE, allowColEdit = TRUE)
      # })
      # 
      
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
      # 
      # # low K layer thickness
      # df <- read_excel("./data/5648_Dummy_Borling.xlsx")
      # 
      # # plug-in the depth to top and bottom of plume in tranmissive area in meters
      # Top = 10
      # Bottom = 21
      # Result_table <- reactiveVal()
      # observe({
      #   req(input$boring,
      #       input$TOP,
      #       input$Bottom,
      #       input$aquitard)
      #   
      #   Result_table<- heterofunction(temp_boring,input$TOP,input$Bottom,input$aquitard)
      #   
      #   Result_table(Result_table)
      # })
      # 
      # Table1_Matrix <- reactive({
      #   validate(need(!is.na(Result_table()),""))
      # 
      #   Result_table <-Result_table()
      #   for (var in 1:length(names(Result_table))){
      #     nam<-names(Result_table)[var]
      #     assign(nam, (Result_table[[var]]))
      #   }
      #   
      #   Table1<- data.frame(Key =html("Number of Aquitard Interfaces"),
      #                       Value = N_aquitard,
      #                       MD = Impact_diffusion)
      #   Table1
      # })
      # 
      # Table2_Matrix <- reactive({
      #   validate(need(!is.na(Result_table()),""))
      #   
      #   Result_table <-Result_table()
      #   for (var in 1:length(names(Result_table))){
      #     nam<-names(Result_table)[var]
      #     assign(nam, (Result_table[[var]]))
      #   }
      #   
      #   Table2<- data.frame(Key =c('Percent of aquifer thickness (B) that is tranmissive','Numbers of Layer'),
      #                       Value = c(round(Percent_B,2),round(N_layer,1)),
      #                       MD = Impact_diffusion2)
      #   Table2
      # })
      # 
      # 
      # # Results Table
      # 
      # output$Table1<-render_gt(align = "center", {
      #   validate(need(!is.na(Table1_Matrix()),""))
      #   browser()
      #   Table1<-Table1_Matrix()
      #   
      #   Table1<-gt(Table1)%>%
      #     cols_label(Key = html("Key Matrix Diffusion<br>Variable for Aquitard(s)"),
      #                Value = "Values from Step 2",
      #                MD = html("Impact on<br>Matrix Diffusion"))%>%
      #     tab_style(style = list(cell_borders(sides = "all",
      #                                         style = "solid",
      #                                         weight = px(2),
      #                                         color = "#D3D3D3"),
      #                            cell_text(align = "center",
      #                                      v_align = "middle")),
      #               locations = cells_body())
      #   
      #   
      #   opt_table_outline(Table1)
      # })
      # 
      # 
      # 
      #   
      # output$Table2<-render_gt(align = "center", {
      #   validate(need(!is.na(Table2_Matrix()),""))
      #   
      #   Table2<-Table2_Matrix()
      #   
      #   Table2<- gt(Table2)%>%
      #     cols_label(Key = html("Key Matrix Diffusion<br>Variable for<br>Layers/Lenses(s)"),
      #                Value = "Values from Step 3",
      #                MD = html("Impact on<br>Matrix Diffusion"))%>%
      #     fmt_number(columns = c(2), rows = c(2), decimals = 0, use_seps=FALSE)%>%
      #     tab_style(style = list(cell_borders(sides = "all",
      #                                         style = "solid",
      #                                         weight = px(2),
      #                                         color = "#D3D3D3"),
      #                            cell_text(align = "center",
      #                                      v_align = "middle")),
      #               locations = cells_body())
      #   opt_table_outline(Table2)
      # })
      # 

      
      
      
    }
  )
} # end Heterogeneity Server 



