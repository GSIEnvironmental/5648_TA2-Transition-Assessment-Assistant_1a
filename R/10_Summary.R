## Summary Modules -----------------------------

## UI -------------------------------------------
SummaryUI <- function(id, label = "010_Summary"){
  ns <- NS(id)
  
  tabPanel("10. Summary",
           tabsetPanel(
             
             tabPanel(HTML("10a Step-by-Step Guide"),
                      fluidRow(style='border-bottom: 5px solid black; text-align:justify;text-justify: inter-word;',
                               HTML("<H1> Tool 10a.  Step-by-Step Guide for an MNA Transition Assessment</H1>"),
                               includeCSS("./www/style/style_flip.css"),
                               column(5,
                                      HTML("<h3><b>What Does this Tool Do?</b></h3>
                           <h4>This tool walks through the key steps that should be followed when conducting a site-specific transition assessment.  
                                           In this case, the primary objective is to determine if transitioning to MNA is appropriate based on site 
                                           conditions and/or the performance of on-going or prospective remedial measures.  It integrates information 
                                           from the other tools in this app, including a “Remediation Transition Assessment Index” (Tool 10b) that reflects the relative 
                                           persistence of contamination at the site due to matrix diffusion effects. </h4>")),
                               column(5,
                                      HTML("<h3><b>How Does it Work?</b></h3>
                           <h4><ol>
                           <li> Go through Steps 1 - 3 in order to perform a comprehensive site transition assessment <i>(click on buttons below or use menu to navigate to each tool)</i>.</li> 
                           <li> Copy or transcribe the supporting information for each step so that it can be included in a site transition assessment report.</li>
                                </ol></h4>"))
                               ),
                      br(),
                      
                      fluidRow(includeHTML('./www/10_Summary/Tool10a_v1.html'))
                               
             ), 
             tabPanel(HTML("10b Remediation Transition Assessment Index"),
                      fluidRow(style='border-bottom: 5px solid black; text-align:justify;text-justify: inter-word;',
                               HTML("<H1>Tool 10b. Remediation Transition Assessment Index (RTAI)</H1>"),
                               HTML("<h4>This portion of Tool 10 integrates information from several other tools 
                                    in this app into a Remediation Transition Assessment Index 'RTAI'.  This simple 
                                    metric reflects the relative persistence of contamination at a site due to matrix 
                                    diffusion and other site-specific considerations.  It summarizes the results from 
                                    each of the tools that have been completed by the user, and then assigns a RTAI value 
                                    to each of those results.  An RTAI of 5 indicates that the results suggest that the 
                                    site is a strong candidate for transitioning to MNA or enhanced attenuation approaches, 
                                    while an RTAI of 1 suggests that the site is a poor candidate.  Note that a user can 
                                    calculate an RTAI for their site without going through the other steps in Tool 10.  
                                    However, a decision to transition to MNA will likely require that the “bright line” 
                                    criteria described in Tool 10a have also been met, and that the relevant site 
                                    information described in the Tool 10c checklists has been adequately documented.</h4>"),
                               br()),
                      fluidRow(br(),
                               br(),
                               gt_output(ns("Table_B")),
                               br()
                               )
                      ), 
             tabPanel(HTML("10c Checklists"),
                      fluidRow(style='border-bottom: 5px solid black; text-align:justify;text-justify: inter-word;',
                               HTML("<H1>Tool 10c.  Checklists</H1>"),
                               includeCSS("./www/style/style_flip.css"),
                      column(5,
                             HTML("
                           <h4>a.	This portion of Tool 10 provides checklists to ensure that the user has gathered 
                                  the necessary information to support a technically rigorous site-specific Transition 
                                  Assessment.  It also further maps out how each of the other tools in this app can 
                                  be used to assist in the overall assessment. These checklists are based on three 
                                  key site-specific elements shown in the graphic to the right.  Note that the 
                                  National Research Council (2012) has previously described the various elements 
                                  that should be considered during a Transition Assessment, with a focus on an evaluation 
                                  of alternative remedies or long-term management options after demonstrating that 
                                  asymptotic conditions have occurred for the current remedy. For the purposes of this 
                                  tool, we have included the initial steps of documenting site conditions and 
                                  complexities, as well the quantitative assessment of asymptotic trends and plume 
                                  stability, in the Transition Assessment.</h4>")),
                      column(7,HTML("<img src = '10_Summary/Tool10a.png' width='100%' >")
                             )),
                      
                      br(),
                      fluidRow(column(4,
                                      HTML("Choose Input File"),
                                      fileInput(ns("file_Tool10"), label = "",
                                                multiple = F,
                                                accept = c("text/xlsx",
                                                           "text/comma-separated-values,text/plain",
                                                           ".xlsx"), 
                                                width = "200px")),
                               br(),
                               column(4, align = "center",
                                      fluidRow(actionButton(ns("update_inputs_Tool10"), 
                                                            HTML("Update Input Values<br>from Input File"), style = button_style)))),
                      br(),
                      br(),
                      #fluidRow(responsive=FALSE,
                               
                      HTML("<h2><b>1.  Describe site complexities and implications for achieving cleanup goals</b></h2>"),
                      checkbox_list(id = ns("1_1"), label =checkbox_doc()[1] ,
                                    help_id = ns('helpd1'),indents=checkbox_indent()[1]),
                      checkbox_list(id = ns("1_2"), label =checkbox_doc()[2] ,
                                    help_id = ns('helpd2'),indents=checkbox_indent()[2]),
                      checkbox_list(id = ns("1_3"), label =checkbox_doc()[3] ,
                                    help_id = ns('helpd3'),indents=checkbox_indent()[3]),
                      checkbox_list(id = ns("1_4"), label =checkbox_doc()[4] ,
                                    help_id = ns('helpd4'),indents=checkbox_indent()[4]),
                      checkbox_list(id = ns("1_5"), label =checkbox_doc()[5] ,
                                    help_id = ns('helpd5'),indents=checkbox_indent()[5]),
                      HTML("<h3>If a pump-and-treat system is in place:</h3>"),
                      checkbox_list(id = ns("1_6"), label =checkbox_doc()[6] ,
                                    help_id = ns('helpd6'),indents=checkbox_indent()[6]),
                      HTML("<h2><b>2. Perform quantitative assessment of concentration trends (e.g., “asymptotic” performance).</b></h2>"),
                      checkbox_list(id = ns("2_1"), label =checkbox_doc()[7] ,
                                    help_id = ns('helpd7'),indents=checkbox_indent()[7]),
                      checkbox_list(id = ns("2_2"), label =checkbox_doc()[8] ,
                                    help_id = ns('helpd8'),indents=checkbox_indent()[8]),
                      checkbox_list(id = ns("2_3"), label =checkbox_doc()[9] ,
                                    help_id = ns('helpd9'),indents=checkbox_indent()[9]),
                      checkbox_list(id = ns("2_4"), label =checkbox_doc()[10] ,
                                    help_id = ns('helpd10'),indents=checkbox_indent()[10]),
                      checkbox_list(id = ns("2_5"), label =checkbox_doc()[11] ,
                                    help_id = ns('helpd11'),indents=checkbox_indent()[11]),
                      checkbox_list(id = ns("2_6"), label =checkbox_doc()[12] ,
                                    help_id = ns('helpd12'),indents=checkbox_indent()[12]),
                      HTML("<h2><b>3a. Evaluate alternative approaches for managing the site (MNA).</b></h2>"),
                      checkbox_list(id = ns("3_1"), label =checkbox_doc()[13] ,
                                    help_id = ns('helpd13'),indents=checkbox_indent()[13]),
                      checkbox_list(id = ns("3_2"), label =checkbox_doc()[14] ,
                                    help_id = ns('helpd14'),indents=checkbox_indent()[14]),
                      checkbox_list(id = ns("3_3"), label =checkbox_doc()[15] ,
                                    help_id = ns('helpd15'),indents=checkbox_indent()[15]),
                      checkbox_list(id = ns("3_4"), label =checkbox_doc()[16] ,
                                    help_id = ns('helpd16'),indents=checkbox_indent()[16]),
                      checkbox_list(id = ns("3_5"), label =checkbox_doc()[17] ,
                                    help_id = ns('helpd17'),indents=checkbox_indent()[17]),
                      checkbox_list(id = ns("3_6"), label =checkbox_doc()[18] ,
                                    help_id = ns('helpd18'),indents=checkbox_indent()[18]),
                      checkbox_list(id = ns("3_7"), label =checkbox_doc()[19] ,
                                    help_id = ns('helpd19'),indents=checkbox_indent()[19]),
                      checkbox_list(id = ns("3_8"), label =checkbox_doc()[20] ,
                                    help_id = ns('helpd20'),indents=checkbox_indent()[20]),
                      checkbox_list(id = ns("3_9"), label =checkbox_doc()[21] ,
                                    help_id = ns('helpd21'),indents=checkbox_indent()[21]),
                      HTML("<h3>If a treatment is active at the site (e.g., a pump-and-treat system is in place) and the goal is to shut it off and transition to MNA:</h3>"),
                      checkbox_list(id = ns("3_10"), label =checkbox_doc()[22] ,
                                    help_id = ns('helpd22'),indents=checkbox_indent()[22]),
                      checkbox_list(id = ns("3_11"), label =checkbox_doc()[23] ,
                                    help_id = ns('helpd23'),indents=checkbox_indent()[23]),
                      checkbox_list(id = ns("3_12"), label =checkbox_doc()[24] ,
                                    help_id = ns('helpd24'),indents=checkbox_indent()[24]),
                      checkbox_list(id = ns("3_13"), label =checkbox_doc()[25] ,
                                    help_id = ns('helpd25'),indents=checkbox_indent()[25]),
                      checkbox_list(id = ns("3_14"), label =checkbox_doc()[26] ,
                                    help_id = ns('helpd26'),indents=checkbox_indent()[26]),
                      checkbox_list(id = ns("3_15"), label =checkbox_doc()[27] ,
                                    help_id = ns('helpd27'),indents=checkbox_indent()[27]),
                      checkbox_list(id = ns("3_16"), label =checkbox_doc()[28] ,
                                    help_id = ns('helpd28'),indents=checkbox_indent()[28]),
                      HTML("<h3>If a pump-and-treat system (or other active treatment system) is not in place:</h3>"),
                      checkbox_list(id = ns("3_17"), label =checkbox_doc()[29] ,
                                    help_id = ns('helpd29'),indents=checkbox_indent()[29]),
                      checkbox_list(id = ns("3_18"), label =checkbox_doc()[30] ,
                                    help_id = ns('helpd30'),indents=checkbox_indent()[30]),
                      checkbox_list(id = ns("3_19"), label =checkbox_doc()[31] ,
                                    help_id = ns('helpd31'),indents=checkbox_indent()[31]),
                      checkbox_list(id = ns("3_20"), label =checkbox_doc()[32] ,
                                    help_id = ns('helpd32'),indents=checkbox_indent()[32]),
                      HTML("<h2><b>3b. Evaluate alternative approaches for managing the site (Enhanced Attenuation / Active Remediation)</b></h2>"),
                      checkbox_list(id = ns("3b_1"), label =checkbox_doc()[33] ,
                                    help_id = ns('helpd33'),indents=checkbox_indent()[33]),
                      checkbox_list(id = ns("3b_2"), label =checkbox_doc()[34] ,
                                    help_id = ns('helpd34'),indents=checkbox_indent()[34]),
                      checkbox_list(id = ns("3b_3"), label =checkbox_doc()[35] ,
                                    help_id = ns('helpd35'),indents=checkbox_indent()[35]),
                      checkbox_list(id = ns("3b_4"), label =checkbox_doc()[36] ,
                                    help_id = ns('helpd36'),indents=checkbox_indent()[36]),
                      checkbox_list(id = ns("3b_5"), label =checkbox_doc()[37] ,
                                    help_id = ns('helpd37'),indents=checkbox_indent()[37]),
                      checkbox_list(id = ns("3b_6"), label =checkbox_doc()[38] ,
                                    help_id = ns('helpd38'),indents=checkbox_indent()[38]),
                      checkbox_list(id = ns("3b_7"), label =checkbox_doc()[39] ,
                                    help_id = ns('helpd39'),indents=checkbox_indent()[39]),
                      checkbox_list(id = ns("3b_8"), label =checkbox_doc()[40] ,
                                    help_id = ns('helpd40'),indents=checkbox_indent()[40]),
                      checkbox_list(id = ns("3b_9"), label =checkbox_doc()[41] ,
                                    help_id = ns('helpd41'),indents=checkbox_indent()[41]),
                      checkbox_list(id = ns("3b_10"), label =checkbox_doc()[42] ,
                                    help_id = ns('helpd42'),indents=checkbox_indent()[42]),
                      checkbox_list(id = ns("3b_11"), label =checkbox_doc()[43] ,
                                    help_id = ns('helpd43'),indents=checkbox_indent()[43]),
                      checkbox_list(id = ns("3b_12"), label =checkbox_doc()[44] ,
                                    help_id = ns('helpd44'),indents=checkbox_indent()[44]),
                      checkbox_list(id = ns("3b_13"), label =checkbox_doc()[45] ,
                                    help_id = ns('helpd45'),indents=checkbox_indent()[45]),
                      checkbox_list(id = ns("3b_14"), label =checkbox_doc()[46] ,
                                    help_id = ns('helpd46'),indents=checkbox_indent()[46]),
                      checkbox_list(id = ns("3b_15"), label =checkbox_doc()[47] ,
                                    help_id = ns('helpd47'),indents=checkbox_indent()[47]),
                      # HTML("<h2><b>1.  Describe site complexities and implications for achieving cleanup goals</b></h2>"),
                               # checkbox_list(id = "1_1", label = checkbox_doc[1],
                               #               help_id = 'helpd1', indents = checkbox_indent[1]),
                              
                               # checkbox_list(id = 'c', label = ,
                               #               help_id = 'c_help', indents = 1),
                               # checkbox_list(id = 'd', label = ,
                               #               help_id = 'd_help', indents = 2),
                               # checkbox_list(id = 'd', label = ,
                               #               help_id = 'd_help', indents = 3),
                               
                               
                               
                               
                               #column(10,HTML("<li>Do you have an existing CSM that identifies relevant site conditions, 
                              #                nature and extent of contamination, and relevant attenuation processes?</li>")),
                               #column(1,actionButton(ns("help1"), HTML("?"), style = button_style2)),
                               #column(1,tags$style(".shiny-input-container {margin-bottom: 0;margin-top:0;outline:0px}"),
                              #        tags$style(".checkbox {margin-bottom: 0px;margin-top:4px;outline:0px}"),
                              #        includeCSS("./www/style/style_flip.css"),checkboxInput(ns('1_1'), NULL, FALSE)),
                               # column(10,includeHTML('./www/10_Summary/Tool10c_v1.html')),#
                               # tags$style("input[type=checkbox] {
                               #            height:34px;
                               #            width:34px;}"),
                               #            white-space: normal;
                               #            position: fixed;
                               #            right:0;
                               #            bottom:0;
                               #            top:-0.1;
                               #            left:0;
                               #            background-color:#eee;
                               #            border-radius: 4px;
                               #            text-align:center;
                               #            height:34px;
                               #            width:34px;
                               #            font-size: 14px;
                               #            padding: 0px 0;
                               #            margin:0px;
                               #            }"),
                               # column(1,tags$style(".shiny-input-container {margin-bottom: 0;margin-top:0;outline:0px}"),
                               # tags$style(".checkbox {margin-bottom: 0px;margin-top:0px;outline:0px}"),
                               # includeCSS("./www/style/style_flip.css"),
                               # checkseries(ns,button_style2)),
                               # column(1,
                               # helpseries(ns,button_style2)
                               # )
                              #),
                      br(),
                      fluidRow(align = "center",
                               downloadButton(ns("checked_results"),
                                              HTML("Save Check Box"), style = button_style))
             ),
                     
                                 
                      
             
           )
           #tags$h1(tags$b("Tool 10. Summary and Plume Persistence Index.")),
           #("<h3><p style='color:red;'>This tool is currently under development.</h3></p>")
  )
} # end Summary UI         


## Server Module -----------------------------------------
SummaryServer <- function(id,LOE_asymp, MKresult, 
                          Cleantime, Presult, RTAI_EA) {
  moduleServer(
    id,
    
    function(input, output, session) {
     
      # Export Summary Table in Tab 10b  -------------------------
      output$Table_B <- render_gt({

        
        
        RTAI1 = checksilenterror(LOE_asymp$LOE_asymp())
        RTAI2 = checksilenterror(MKresult$MK_conc_well())
        RTAI3 = checksilenterror(Presult$results_table())
        RTAI4 = checksilenterror(Presult$EvalITRC())
        RTAI5 = checksilenterror(Cleantime$cleantime())
        RTAI6 = checksilenterror(RTAI_EA$RTAI_EA())

        #validate(need(RTAI1!='error', "Go to Tool 1 to run the analysis"))
        #validate(need(RTAI2!='error', "Go to Tool 2 to run the analysis"))
        #validate(need(RTAI3!='error', "Go to Tool 4 to run the analysis"))
        #validate(need(RTAI4!='error', "Go to Tool 4 third tab to put checkmarks"))
        #validate(need(RTAI5!='error', "Go to Tool 3 to run the analysis"))
        #validate(need(RTAI6!='error', "Go to Tool 7 fifth tab to check the relevant cell"))
        
        if (RTAI1!='error'){
          RTAI1 = LOE_asymp$LOE_asymp()
          RTAI1 = as.character(length(RTAI1$Met[RTAI1$Met=='TRUE']))
        }else{
          RTAI1 = 'NA'
        }
          
        if (RTAI2!='error'){
          RTAI2 = as.character(MKresult$MK_conc_well()$MapFlag)
        }else{
          RTAI2 = 'NA'
        }
        
        if (RTAI5!='error'){
          RTAI5 = as.character(ifelse(Cleantime$cleantime()$Time_Cleanup[1]<5, '<5',
                                      ifelse(Cleantime$cleantime()$Time_Cleanup[1]>=5&Cleantime$cleantime()$Time_Cleanup[1]<10,'5 to <10',
                                             ifelse(Cleantime$cleantime()$Time_Cleanup[1]>=10&Cleantime$cleantime()$Time_Cleanup[1]<25,'10 to <25',
                                                    ifelse(Cleantime$cleantime()$Time_Cleanup[1]>=25&Cleantime$cleantime()$Time_Cleanup[1]<50,'25 to <50',
                                                           ifelse(Cleantime$cleantime()$Time_Cleanup[1]>=50,'≥50'))))))
        }else{
          RTAI5 = 'NA'
        }
        
        if (RTAI4!='error'){
          RTAI4 = Presult$EvalITRC()
          RTAI4_H = nrow(RTAI4[RTAI4$High=='TRUE',])
          RTAI4_M = nrow(RTAI4[RTAI4$Moderate=='TRUE',])
          RTAI4_L = nrow(RTAI4[RTAI4$Low=='TRUE',])
          
          RTAI4 <- case_when(RTAI4_H>RTAI4_M&RTAI4_H>RTAI4_L ~ 'High',
                             RTAI4_H==RTAI4_M&RTAI4_H>RTAI4_L ~ 'High-Mod',
                             RTAI4_H<RTAI4_M&RTAI4_M>RTAI4_L ~ 'Moderate',
                             RTAI4_L==RTAI4_M&RTAI4_H<RTAI4_L ~ 'Mod-Low',
                             RTAI4_L>RTAI4_M&RTAI4_L>RTAI4_M ~ 'Low')
          requiredOoMs = log10(Presult$Tool4_Conc_site() - Presult$Tool4_Conc_goal())
          expectedOoMs = as.numeric(Presult$results_table()$Median_list[2])
          RTAI3 = ifelse(requiredOoMs/expectedOoMs<0.5, '<0.5',
                         ifelse(requiredOoMs/expectedOoMs>=0.5&requiredOoMs/expectedOoMs<0.75,'0.5 to <0.75',
                                ifelse(requiredOoMs/expectedOoMs>=0.75&requiredOoMs/expectedOoMs<1.25,'0.75 to <1.25',
                                       ifelse(requiredOoMs/expectedOoMs>=1.25&requiredOoMs/expectedOoMs<2,'1.25 to <2',
                                              ifelse(requiredOoMs/expectedOoMs>=2,'≥2')))))
        }else{
          RTAI4 = 'NA'
          RTAI3 = 'NA'
        }
        
        if (RTAI6!='error'){
          # update table with checkmark
          RTAI6 = RTAI_EA$RTAI_EA()
          RTAI6_ind = grep(RTAI6, colnames(Table10))
          Table10[6,RTAI6_ind] = 'checkmark'
          RTAI6 = 'checkmark'
        }else{
          RTAI6 = 'NA'
        }
        
  
        RTAI_tbl<-Table10%>%
          mutate("Poor Candidate RTAI = 1" = map(rank_chg(Table10$`Poor Candidate RTAI = 1`,
                                                          RTAI1,RTAI2,RTAI3,RTAI4,RTAI5,RTAI6),gt::html),
                 "Fair Candidate RTAI = 2" = map(rank_chg(Table10$`Fair Candidate RTAI = 2`,
                                                          RTAI1,RTAI2,RTAI3,RTAI4,RTAI5,RTAI6),gt::html),
                 "Typical Candidate RTAI = 3" = map(rank_chg(Table10$`Typical Candidate RTAI = 3`,
                                                             RTAI1,RTAI2,RTAI3,RTAI4,RTAI5,RTAI6),gt::html),
                 "Good Candidate RTAI = 4" = map(rank_chg(Table10$`Good Candidate RTAI = 4`,
                                                          RTAI1,RTAI2,RTAI3,RTAI4,RTAI5,RTAI6),gt::html),
                 "Strong Candidate RTAI = 5" = map(rank_chg(Table10$`Strong Candidate RTAI = 5`,
                                                            RTAI1,RTAI2,RTAI3,RTAI4,RTAI5,RTAI6),gt::html))
        
        countlargest = c(as.numeric(gsub(pattern = "<.*?>", replacement = "", x = RTAI_tbl[7,2][[1]][[1]])),
                         as.numeric(gsub(pattern = "<.*?>", replacement = "", x = RTAI_tbl[7,3][[1]][[1]])),
                         as.numeric(gsub(pattern = "<.*?>", replacement = "", x = RTAI_tbl[7,4][[1]][[1]])),
                         as.numeric(gsub(pattern = "<.*?>", replacement = "", x = RTAI_tbl[7,5][[1]][[1]])),
                         as.numeric(gsub(pattern = "<.*?>", replacement = "", x = RTAI_tbl[7,6][[1]][[1]])))

        RTAI_tbl%>%
          gt()%>%
          cols_width(
            starts_with("Rational") ~ px(400),
            starts_with("Tool") ~ px(280),
            everything() ~ px(125),
            
          )%>%
          sub_missing(columns = everything(),
                      rows = everything(),
                      missing_text = '')%>%
          tab_spanner(
            label = "RTAI",
            columns = colnames(Table10)[2:6]
          )%>%
          tab_style(style = style_body_tool10(),
                    locations = cells_body()) %>%
          tab_style(style = style_body_tool10_middle(),
                    locations = cells_body(columns=colnames(Table10)[2:6])) %>%
          tab_style(style = style_col_labels(),
                    locations = cells_column_spanners()) %>%
          tab_style(style = style_col_labels(),
                    locations = cells_column_labels()) %>%
          tab_style(
            style = list(
              cell_fill(color = "#FFFF99"),
              cell_text(weight = "bold")
            ),
            locations = cells_body(
              columns = `Poor Candidate RTAI = 1`,
              rows =  str_detect(`Poor Candidate RTAI = 1`,'red')|
                (str_detect(`Poor Candidate RTAI = 1`,as.character(max(countlargest)))&
                              str_detect(`Poor Candidate RTAI = 1`,'bold'))
            )
          ) %>%
          tab_style(
            style = list(
              cell_fill(color = "#FFFF99"),
              cell_text(weight = "bold")
            ),
            locations = cells_body(
              columns = `Fair Candidate RTAI = 2`,
              rows =  str_detect(`Fair Candidate RTAI = 2`,'red')|
                (str_detect(`Fair Candidate RTAI = 2`,as.character(max(countlargest)))&
                             str_detect(`Fair Candidate RTAI = 2`,'bold'))
            )
          ) %>%
          tab_style(
            style = list(
              cell_fill(color = "#FFFF99"),
              cell_text(weight = "bold")
            ),
            locations = cells_body(
              columns = `Typical Candidate RTAI = 3`,
              rows =  str_detect(`Typical Candidate RTAI = 3`,'red')|
                (str_detect(`Typical Candidate RTAI = 3`,as.character(max(countlargest)))&
                             str_detect(`Typical Candidate RTAI = 3`,'bold'))
            )
          ) %>%
          tab_style(
            style = list(
              cell_fill(color = "#FFFF99"),
              cell_text(weight = "bold")
            ),
            locations = cells_body(
              columns = `Good Candidate RTAI = 4`,
              rows =  str_detect(`Good Candidate RTAI = 4`,'red')|
                (str_detect(`Good Candidate RTAI = 4`,as.character(max(countlargest)))&
                             str_detect(`Good Candidate RTAI = 4`,'bold'))
            )
          ) %>%
          tab_style(
            style = list(
              cell_fill(color = "#FFFF99"),
              cell_text(weight = "bold")
            ),
            locations = cells_body(
              columns = `Strong Candidate RTAI = 5`,
              rows =  str_detect(`Strong Candidate RTAI = 5`,'red')|
                (str_detect(`Strong Candidate RTAI = 5`,as.character(max(countlargest)))&
                             str_detect(`Strong Candidate RTAI = 5`,'bold'))
            )
          ) %>%
          opt_table_outline() %>%
          # GT bug fix
          tab_options(table.additional_css = "th, td {padding: 5px 10px !important;	border: 1px solid white;}" )

         
      })
      
      
      #----- help function 
      lapply(
        X = 1:47,
        FUN = function(i){
          observeEvent(input[[paste0("helpd", i)]], {
            flname = HelpDoclist()[i*3]
            HelpDocFunction(flname)
          })
        }
      )
      
      # Export Model Results and Input Values  ---------------------------
      output$checked_results <- downloadHandler(
        filename = function(){
          paste("Tool10_Checked","xlsx",sep=".")
        },
        
        content = function(con){
          
          # Create empty excel file
          wb <- createWorkbook()
          
          # Add Results Tab
          addWorksheet(wb, "Tool10_Checked")
         
          # insertImage(wb, "Borden_Tool_Results", paste0("./plot.png"),
          #             startRow = 9, startCol = 2, heigh = 864, width = 1618, units = "px")
          
          #----- help function

          # Add Parameters Tab
          x <- data.frame(Q1_1 =input$`1_1`,
                          Q1_2 =input$`1_2`,
                          Q1_3 =input$`1_3`,
                          Q1_4 =input$`1_4`,
                          Q1_5 =input$`1_5`,
                          Q1_6 =input$`1_6`,
                          Q2_1 =input$`2_1`,
                          Q2_2 =input$`2_2`,
                          Q2_3 =input$`2_3`,
                          Q2_4 =input$`2_4`,
                          Q2_5 =input$`2_5`,
                          Q2_6 =input$`2_6`,
                          Q3_1a =input$`3_1`,
                          Q3_2a =input$`3_2`,
                          Q3_3a =input$`3_3`,
                          Q3_4a =input$`3_4`,
                          Q3_5a =input$`3_5`,
                          Q3_6a =input$`3_6`,
                          Q3_7a =input$`3_7`,
                          Q3_8a =input$`3_8`,
                          Q3_9a =input$`3_9`,
                          Q3_10a =input$`3_10`,
                          Q3_11a =input$`3_11`,
                          Q3_12a =input$`3_12`,
                          Q3_13a =input$`3_13`,
                          Q3_14a =input$`3_14`,
                          Q3_15a =input$`3_15`,
                          Q3_16a =input$`3_16`,
                          Q3_17a =input$`3_17`,
                          Q3_18a =input$`3_18`,
                          Q3_19a =input$`3_19`,
                          Q3_20a =input$`3_20`,
                          Q3_1b =input$`3b_1`,
                          Q3_2b =input$`3b_2`,
                          Q3_3b =input$`3b_3`,
                          Q3_4b =input$`3b_4`,
                          Q3_5b =input$`3b_5`,
                          Q3_6b =input$`3b_6`,
                          Q3_7b =input$`3b_7`,
                          Q3_8b =input$`3b_8`,
                          Q3_9b =input$`3b_9`,
                          Q3_10b =input$`3b_10`,
                          Q3_11b =input$`3b_11`,
                          Q3_12b =input$`3b_12`,
                          Q3_13b =input$`3b_13`,
                          Q3_14b =input$`3b_14`,
                          Q3_15b =input$`3b_15`
          )
          
          writeData(wb, sheet = "Tool10_Checked", x = x, startCol = 1, startRow = 1, colNames = T)
          
          saveWorkbook(wb, con)
          #saveRDS( reactiveValuesToList(input) , file = 'inputs.RDS')
        }
      )# end model_results
      
      # Update Values Based on Input Files, if given ---------------------------
      observeEvent(input$update_inputs_Tool10,{
        # If no file is loaded nothing happens 
        if(!is.null(input$file_Tool10)){
          file <- input$file_Tool10
          
          # Organize Parameters
          par_tool10 <- read_xlsx(file$datapath, sheet = "Tool10_Checked")

          count = 1
          for (j in str_replace(colnames(par_tool10),'Q','')){
            updateCheckboxInput(session,j,value = par_tool10[[count]])
            count = count + 1
          }
          
        }
      }) # end update_inputs button
      
    }
  )
} # end Summary Server 



