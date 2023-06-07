checkbox_list <- function(id, label, help_id, indents) {
  fluidRow(tags$style("input[type=checkbox] {
                                        height:34px;
                                         width:34px;}"),
                      #span{margin-left:50px; display: inline-block}"),
    column(10,
           div(
             style = "span{margin-left:50px; display: inline-block}",
             checkboxInput2(id, label = label,
                           width = '100%',
                           style=paste0("margin-left: ",indents * 60 ,"px; margin-top:25px"))
           )
    ),
    column(2, 
           actionButton(help_id, '?', style = button_style2))
    
  )
}

checkboxInput2<-function (inputId, label, value = FALSE, width = NULL,...)
{
  value <- restoreInput(id = inputId, default = value)
  inputTag <- tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  div(class = "form-group shiny-input-container", style = css(width = validateCssUnit(width)),
      div(class = "checkbox", 
          tags$label(inputTag, tags$span(label,style = "margin-left:50px; display: inline-block")),...
          )
      )
}



checkbox_doc<-function(){
  c(
    "Do you have an existing CSM that identifies relevant site conditions, nature and extent of contamination, and relevant attenuation processes?",
    "Have you established the Geologic Heterogeneity at your site (Tool 8)?",
    "How does the performance of past source remediation efforts at your site compare to the typical performance at other sites (Tool 4)?",
    "Have you estimated the impact of additional source remediation on remediation timeframe (Tool 3)?",
    "Have you estimated the Remediation Transition Assessment Index (RTAI) for your site (Tool 10b)?",
    "Has a rebound test been performed that suggests concentrations increase significantly after shutting off pump(s)?",
    "What is the current rate of source attenuation over time (based on max. concentration well or site-wide range) (Tool 1)?",
    "What is the projected remediation timeframe at the current rate of source attenuation (Tool 1)?",
    "Are there lines of evidence that the performance of current remedial measures (e.g., pump-and-treat system) is asymptotic (based on concentration vs. time) (Tool 1)?",
    "Are the plume concentrations stable or decreasing (based on a site-wide assessment of wells) (Tool 2)?",
    "Is the plume footprint stable or decreasing (based on an evaluation of downgradient wells) (Tool 2)?",
    "Is the site-wide mass decreasing over time (Tool 2)?",
    "Are the site cleanup objectives based on achieving a goal concentration within the source area and/or across the entire site?",
    "If the goal concentration must be met across the entire site, will this concentration be achieved within a reasonable timeframe with natural attenuation (Tool 1)?",
    "Can you establish the bulk natural attenuation rate within the plume using concentration vs. distance data from the plume centerline during the pre-remediation period (Tool 5, tab “Use Pre-Remediation Rate Constant”)?",
    "Can you establish the natural attenuation rate within the plume using degradation rates from lab assays or other site-specific data (Tool 5, tab “Use Lab-Based Rate Constant)?",
    "Can you establish the current bulk natural attenuation rate within the plume using concentration vs. distance data from the plume centerline during the post-remediation period (Tool 5, tab “Use Post-Remediation Rate Constant)?",
    "Has this attenuation rate been consistent over time (i.e., compare rates using concentration vs. distance data from different events) (Tool 5, tab “Use Post-Remediation Rate Constant)?",
    "Is this rate comparable to the attenuation rate constant estimated using the Pre-Remediation data?",
    "Is this rate comparable to the attenuation rate estimated using lab-based studies?",
    "If data are not available, can you install additional monitoring wells along the plume centerline to generate the necessary data?",
    "Has the downgradient point of compliance been established (e.g., the property boundary or other regulatory-based location)?",
    "Can the plume be allowed to migrate beyond its current footprint?",
    "Does the bulk attenuation rate constant within the plume indicate that the goal concentration will be met at the downgradient point of compliance?",
    "Has a rebound test has been performed?",
    "Did concentrations increase in the relevant extraction well(s) during the rebound test?",
    "If the maximum concentration after rebound is used to recalculate the bulk attenuation rate within the plume, does this new rate still indicate that the goal concentration will be met at the downgradient point of compliance?",
    "Is the rate of contaminant capture at the extraction well(s) (based on concentration vs. time) similar to the rate of attenuation observed in monitoring wells prior to pumping (Tool 1)?",
    "Is the plume stable (Tool 2)?",
    "Is there evidence to suggest that processes contributing to plume stability are sustainable over a long period of time?",
    "Does the potential for risk to receptors require implementing remediation or other measures that would preclude the use of MNA?",
    "Is the estimated remediation timeframe for the site (based on applicable standards) using MNA considered reasonable (Tool 1)?",
    "Are the site cleanup objectives based on achieving a goal concentration within the source area and/or across the entire site?",
    "Is source remediation predicted to achieve the goal concentration in the source area within a reasonable timeframe (Tool 3)?",
    "What amount of source attenuation would be needed such the source remediation would be needed to reach the goal concentration within a reasonable timeframe (Tool 3 – enter new value for starting concentration)?",
    "When would this source concentration be reached based on the current source attenuation rates (Tool 1)?",
    "Have you evaluated enhanced attenuation processes for the source area that are potentially feasible for the site (Tool 7)",
    "Have you identified options for reducing contaminant loading (Tool 7b)?",
    "Have you identified options for increasing attenuation capacity (Tool 7b)?",
    "Are the site cleanup objectives based on achieving a goal concentration at a downgradient point of compliance?",
    "Is the plume already stable or shrinking? (Tool 2)",
    "Is the concentration in source area wells decreasing over time (Tool 1 or Tool 2)?",
    "What reduction in the source concentration would need to be achieved to allow natural attenuation in the plume to reach the goal concentration at the downgradient point of compliance (absent any further source attenuation) (Tool 5)?",
    "When would this source concentration be reached based on the current source attenuation rates (Tool 1)?",
    "Have you evaluated enhanced attenuation processes for the source, plume, or discharge area that are potentially feasible for the site (Tool 7)",
    "Have you identified options for reducing contaminant loading (Tool 7b, 7c, Tool 7d)?",
    "Have you identified options for increasing attenuation capacity (Tool 7b, Tool 7c, Tool 7d)?"

  )
}

checkbox_indent<-function(){
  c(0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,2,2,0,1,1,1,2,1,1,1)
}