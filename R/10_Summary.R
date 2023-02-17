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
                                           from the other tools in this app, including a “Persistence Index” (Tool 10b) that reflects the relative 
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
             tabPanel(HTML("10b RTAI"),
                      HTML("<H1>Tool 10b. Design of Remediation Assessment Index (RTAI)</H1>"),
                      br(),
                      gt_output(ns("Table_B")),
                      br()
                      #fluidRow(includeMarkdown('./www/06_Matrix/Tool6b_v1.md'))
             ), 
             tabPanel(HTML("10c Checklists"),
                      fluidRow(style='border-bottom: 5px solid black; text-align:justify;text-justify: inter-word;',
                               HTML("<H1>Tool 10c.  Checklists</H1>"),
                               includeCSS("./www/style/style_flip.css"),
                      column(5,
                             HTML("
                           <h4>The National Research Council (2012) describes the various elements that should be 
                                  considered during a Transition Assessment.  The NRC approach focused on an evaluation of alternative 
                                  remedies or long-term management options after demonstrating that asymptotic conditions have occurred for the 
                                  current remedy. For the purposes of this tool, we have included the initial steps of documenting site conditions 
                                  and complexities, as well the quantitative assessment of asymptotic trends and plume stability, in the 
                                  Transition Assessment. This tool provides checklists for each of these key elements to ensure 
                                  that the user has gathered the necessary information to support a technically rigorous 
                                  site-specific transition assessment.  It also maps out how each of the other tools in 
                                  this app can be used to assist in the overall assessment </h4>")),
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
                      fluidRow(responsive=FALSE,
                               column(10,includeHTML('./www/10_Summary/Tool10c_v1.html')),#
                               tags$style("input[type=checkbox] {
                                          height:34px;
                                          width:34px;}"),
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
                               tags$style(".shiny-input-container {margin-bottom: 0;margin-top:0;outline:0px}"),
                               tags$style(".checkbox {margin-bottom: 0px;margin-top:4px;outline:0px}"),
                               includeCSS("./www/style/style_flip.css"),
                               checkseries(ns,button_style2),
                               helpseries(ns,button_style2)
                               ),
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
                          Q3_1a =input$`3_1a`,
                          Q3_2a =input$`3_2a`,
                          Q3_3a =input$`3_3a`,
                          Q3_4a =input$`3_4a`,
                          Q3_5a =input$`3_5a`,
                          Q3_6a =input$`3_6a`,
                          Q3_7a =input$`3_7a`,
                          Q3_1b =input$`3_1b`,
                          Q3_2b =input$`3_2b`,
                          Q3_3b =input$`3_3b`,
                          Q3_4b =input$`3_4b`,
                          Q3_5b =input$`3_5b`,
                          Q3_6b =input$`3_6b`,
                          Q3_7b =input$`3_7b`,
                          Q3_8b =input$`3_8b`,
                          Q3_9b =input$`3_9b`,
                          Q3_1c =input$`3_1c`,
                          Q3_2c =input$`3_2c`,
                          Q3_3c =input$`3_3c`,
                          Q3_4c =input$`3_4c`,
                          Q4_1a =input$`4_1a`,
                          Q4_2a =input$`4_2a`,
                          Q4_3a =input$`4_3a`,
                          Q4_4a =input$`4_4a`,
                          Q4_1b =input$`4_1b`,
                          Q4_2b =input$`4_2b`,
                          Q4_3b =input$`4_3b`,
                          Q4_4b =input$`4_4b`,
                          Q5_1 =input$`5_1`,
                          Q5_2 =input$`5_2`,
                          Q5_3 =input$`5_3`,
                          Q5_4 =input$`5_4`,
                          Q5_5 =input$`5_5`,
                          Q6_1 =input$`6_1`,
                          Q6_2 =input$`6_2`,
                          Q6_3 =input$`6_3`,
                          Q6_4 =input$`6_4`
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



