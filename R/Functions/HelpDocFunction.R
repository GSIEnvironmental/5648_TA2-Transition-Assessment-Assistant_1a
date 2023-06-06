HelpDocFunction<-function(text1){

  
  showModal(modalDialog(
    title = "Help Box",
    size = 'l',
    text1,
    easyClose = TRUE,
    footer = NULL
  ))
}

HelpDoclist<-function(){
  
  c(
  # question 1
  tags$div("Developing an accurate Conceptual Site Model is a necessary 
  component of site management, and it is a particularly critical part of the 
  transition assessment process.  The NRC (2013) said: “The decision to transition
  a site from active remediation to long-term management requires a thorough 
  understanding of the geologic framework, history of contamination events, 
  the current location and phase distribution of contaminants, temporal processes
  that affect groundwater flow and chemical migration, and interactions at 
  hydrogeologic and compliance boundaries.  The combined understanding of 
  these factors…supports the development of specific management tools such 
  as the conceptual site model.”  The NRC went on to say that “…an accurate
  and suitably detailed site conceptualization is an important component of
  addressing future management challenges at these sites, including the 
  transition to long-term management. In effect, it is not practical to 
  proceed with a transition assessment in the absence of a CSM.",
  tags$br(),
  tags$br(),
  "The TA",tags$sup(2),"Tool provides a number of modules that can help refine 
                   and improve an existing CSM.  There are also many references 
                   that can help users in building a CSM if one does not already 
                   exist for a site.",
tags$br(),
tags$br(),
"References:",
tags$br(),
tags$li("ASTM, 2022. Standard Guide for Developing Conceptual Site Models for Contaminated Sites.  E1689-20.",
tags$a(href="https://www.astm.org/e1689-20.html","https://www.astm.org/e1689-20.html")),
tags$li("ITRC (Interstate Technology & Regulatory Council), 2017. Remediation Management of Complex Sites. RMCS-1. Washington, D.C.: Interstate Technology & Regulatory Council, Remediation Management of Complex Sites Team.",
tags$a(href="https://rmcs-1.itrcweb.org","https://rmcs-1.itrcweb.org")),
tags$li("NRC, 2013. Alternatives for Managing the Nation’s Complex Contaminated Groundwater Sites.  National Research Council, The National Academies Press, Washington, D.C."),
tags$li("USACE, 2012.  Environmental Quality - Conceptual Site Models.  United States Army Corps of Engineers, Manual No. 200-1-12.",
tags$a(href="https://www.publications.usace.army.mil/portals/76/publications/engineermanuals/em_200-1-12.pdf",
       "https://www.publications.usace.army.mil/portals/76/publications/engineermanuals/em_200-1-12.pdf")),
tags$li("USEPA. 2011a. Cleanup Best Management Practices: Effective Use of the Project Life Cycle Conceptual Site Model."),
tags$li("USEPA, 2023.  Key Optimization Components: Conceptual Site Model.",
tags$a(href="https://clu-in.org/optimization/components_csm.cfm","https://clu-in.org/optimization/components_csm.cfm"))
),
#question 2
tags$div("Tool 8 lets the user enter the site-specific geologic conditions, such as the presence of aquitards and other 
       low-permeability lenses or layers in contact with your plume. With this information, the likely impact of matrix diffusion on 
       remediation performance and the time to achieve cleanup goals can be categorized as being Low, Moderate or High.  
       Sites categorized as “High” tend to be highly heterogeneous and less likely to see benefits from performing additional 
       remediation due to the effects of matrix diffusion."),
  # question 3
  tags$div("Tool 4 provides extensive data on how different remedial technologies have performed at several hundred contaminated sites.  
  The data help the user forecast what type of performance might be expected at their site for a given contaminant type and technology.  
  This is important for setting expectations on whether a given technology typically achieves the degree of concentration reductions 
  that might be required at the site being assessed.  This tool also walks the user through several questions designed to assess if
  remediation objectives are likely to be met within a reasonable timeframe.  This “Remediation Potential Assessment” is based on a 
  framework originally developed by ITRC (2017).",
 tags$br(),
 tags$br(),
 "References:",
 tags$br(),

tags$li("ITRC (Interstate Technology & Regulatory Council), 2017. 
Remediation Management of Complex Sites. RMCS-1. Washington, D.C.: 
Interstate Technology & Regulatory Council, Remediation Management of Complex Sites Team.", 
tags$a(href="https://rmcs-1.itrcweb.org","https://rmcs-1.itrcweb.org"))),

#question 4
  tags$div("Tool 3 provides a simple quantitative approach for estimating how complete source removal will impact the remediation timeframe.  
  It provides an estimate of the number of years it will take to reduce the concentration in a plume monitoring well 
  by 90%, 99%, or 99.9% after complete source removal has been implemented. The Tool was developed by Dr. Bob Borden 
  (Borden and Cha, 2021) and is based on the REMChlor-MD model.",
           tags$br(),
           tags$br(),

"The data from Tool 3 can also be used to support the “Remediation Potential Assessment” portion of Tool 4.
"),

#question 5 - 14
  tags$div("This portion of Tool 10 integrates information from several other tools in this app into a “Remediation Transition Assessment Index (RTAI)”.  This simple metric reflects the relative persistence of contamination at a site due to matrix diffusion and other site-specific considerations.  It summarizes the results from each of the tools that have been completed by the user, and then assigns a RTAI value to each of those results.  An RTAI of 5 indicates that the results suggest that the site is a strong candidate for transitioning to MNA or enhanced attenuation approaches, while an RTAI of 1 suggests that the site is a poor candidate.  Note that a user can calculate an RTAI for their site without going through the other steps in Tool 10.  However, a decision to transition to MNA will likely require that the “bright line” criteria described in Tool 10a have also been met."),
  tags$div("Sites with pump-and-treat systems are prime candidates for a transition assessment for both long-term cost and performance reasons.  A rebound study—where concentration trends are monitored after a pump-and-treat system has been temporary shutoff—may provide valuable information on whether concentration goals can be met under natural conditions.  In cases where the concentration rebounds significantly due to the change in aquifer dynamics once pumping is halted, it may be more difficult to achieve concentration-based cleanup goals at a downgradient point of compliance.  Note that Tool 5 can help users with these types of projections of concentration with distance, and the post-rebound concentration at a source well can serve as a starting point for the projection."),
  tags$div("Tool 1 allows the user to calculate a rate constant for any well that represents how fast the concentration is changing over time.  The rate constant can be used to project the remediation timeframe."),
  tags$div("Tool 1 calculates the remediation timeframe (time to clean) for a well (or set of wells) using the rate constant for that well.  The time to reach cleanup goals across the site are generally most dependent on the rate constants for the source area wells"),
  tags$div("Tool 1 performs a series of five tests that serve as lines of evidence that the contaminant concentrations are becoming asymptotic over time.  If the collective results are consistent with asymptotic conditions, then this serves as a technical justification for performing a transition assessment. "),
  tags$div("Tool 2 will estimate the concentration trend for individual wells or groups of wells using the concentration vs. time data.   A site-wide trend can be established by selecting all wells, and a stable or decreasing site-wide trend suggests that the plume is attenuating."),

  tags$div("Tool 2 will estimate the concentration trend for individual wells or groups of wells using the concentration vs. time data.   A stable or decreasing trend for individual downgradient wells, or the entire group of downgradient wells, suggests that attenuation within the plume is contributing to a stable or shrinking plume footprint.  This is a primary line of evidence for natural attenuation when MNA is used as a remedy and/or as a risk management strategy."),
  tags$div("Tool 2 will estimate the mass trend for groups of wells using the concentration vs. time data and the representative areas for the wells.   A site-wide trend can be established by selecting all wells, and a stable or decreasing site-wide trend suggests that the plume is attenuating.  "),
  tags$div("For sites that are being managed under CERCLA, MNA is typically considered a remedy like any other remedy.  In other words, the expectation is that the concentration(s) of regulated contaminants across the entire site are below a specific cleanup goal within a reasonable time frame.  Consequently, the monitoring locations with high concentrations, such as those in the source area, are likely to be the driver for whether the goal concentration(s) can be achieved, and the rate at which the source is attenuating will control how long the contaminants will be present.  "),
  tags$div("The estimated timeframe to reach the goal concentration(s) based on natural attenuation alone can be estimated using Tool 1 for relevant well(s), preferably using a rate for source attenuation estimated using data collected prior to any major remediation efforts.  If the timeframe is considered “reasonable” based on applicable regulatory standards, then MNA may be the most appropriate alternative for managing the site.  The user should still confirm that concentration goals at any relevant downgradient locations will also be met, which can be examined by projecting the plume concentrations with distance in Tool 5 (see next step).  Under this scenario, the plume is expected to shrink due solely to natural attenuation (in the absence of any additional remedial efforts).",
           tags$br(),
           tags$br(),
           "If the timeframe calculated using Tool 1 is not considered “reasonable” under a natural attenuation scenario, then other alternatives besides MNA should be evaluated (see step 3b). "),
  
  #question 15
  tags$div("The tab labeled “Use Pre-Remediation Rate Constant” in Tool 5 lets the user project concentrations with distance based on a rate constant that is derived from the pre-remediation period.   It first plots the logarithm of the concentration of contaminants from the period before active treatment began against the distance from the source well.  Ideally, the data from the plume centerline should plot near a straight line.  The user edits the data to exclude low concentrations that are obviously not along the plume centerline.  The tool then fits a linear regression to the natural logarithm of concentrations of contaminants on distance from the source.  The slope of the regression is the rate constant for natural attenuation in concentrations with distance from the source.  This rate constant includes the contributions of degradation and dispersion.",
           tags$br(),
           tags$br(),
"This rate constant can be used to forecast the concentration with distance from the well of concern after the end of active treatment.  This graph showing this projection is also included on this Tool 5 tab, and it uses the well locations and data selected by the user.  To allow the user to address uncertainty in the rate constant, Tool 5 will calculate the slower one-tailed confidence interval on the rate constant for attenuation at a level of uncertainty selected by the user.  The user can then see how the slower confidence interval impacts the projected concentrations along the flow path on the same graph.
"),

  #question 16 
  tags$div("The tab labeled “Use Lab-Based Rate Constant” in Tool 5 lets the user project concentrations with distance based on degradation rates obtained from lab-scale testing.  Relevant lab-based studies could include a conventional microcosm study, a 14C assay of degradation, or the abundance of biomarkers for biodegradation of the contaminants in groundwater from the site.  These laboratory rate constants have the units of reciprocal time.  The user inputs data on hydraulic conductivity, hydraulic gradient, and effective porosity, and Tool 5 estimates a seepage velocity.  It then divides the lab-based rate constant by the seepage velocity to calculate a rate constant for degradation with distance along the flow path.  This tab in Tool 5 then uses the rate constant for degradation to forecast concentrations of the contaminants along the flow path, which is provided in graphical form.  The user also has the option to use pre-determined lower confidence interval for the lab-based rate constant."),
  
  #question 17
  tags$div("The tab labeled “Use Post-Remediation Rate Constant” in Tool 5 lets the user project concentrations with distance based on a rate constant that is derived from data collected after active remediation has stopped and steady state conditions have been established.  In these cases, active treatment began at the site before the full extent of the plume was characterized, and there are not adequate data on concentrations before treatment to determine a rate constant for attenuation with distance.  After the transition, the hydrology of the site should establish a new steady state.  If the water table elevations have achieved a new steady state and any rebound in concentrations have reached a steady state, the concentrations after transition and reestablishment of a steady state can be used in this tab as Tool 5 as the basis for extracting the rate constant for attenuation with distance.",
           tags$br(),
           tags$br(),
           "This rate constant can be used to do additional forecasting of the concentration with distance from the well of concern during the post-remediation period.  This graph showing this projection is also included on this Tool 5 tab, and it uses the well locations and data selected by the user.  To allow the user to address uncertainty in the rate constant, Tool 5 will calculate the slower one-tailed confidence interval on the rate constant for attenuation at a level of uncertainty selected by the user.  The user can then see how the slower confidence interval impacts the projected concentrations along the flow path on the same graph.
"),
  tags$div("Rate constants can be estimated from single monitoring events, or from averaging of results from multiple events.  If data from multiple events are available, it is advisable to check if they provide similar estimates of the rate constant.  The variability in the rate constants can be used to as a line of evidence that the rates being generated are representative.  Rate constants that are shifting over time can be used to understand if post-remediation conditions (i.e., after a transition from an active treatment to MNA) have reached a steady state."),
  tags$div("For cases where sufficient pre-remediation and post-remediation data are available to estimate rate constants for each period, a comparison between these rate constant estimates may be valuable.  This assumes that steady state conditions have been achieved in the post-remediation period.  For example, lower rate constants during the post-remediation period could signal that changes in site conditions have occurred.  These may need to be further investigated and/or incorporated into the transition assessment."),
  tags$div("For cases where rate constants have been estimated using lab-based studies as well as from site data, a comparison between these different rate constants may be valuable.  In the case where the rate constant was derived from post-remediation data, it is assumed that steady state conditions have been achieved.  Rate constants from lab-based studies may not account for all attenuation processes that can occur during contaminant transport (e.g., dispersion), so lower rate constants from lab-based studies do not necessarily mean that field-based rate constants are inaccurate.  Similarly, lab-based studies may rely on site samples from one or more discrete locations, so some differences with field-based rates (which are calculated across a plume transect) could be observed."),
  tags$div("The process of estimating attenuation rate constants from monitoring data can highlight gaps in a monitoring network.  For example, some sites may not have enough monitoring wells located along the plume centerline due to various reasons (e.g., shifting understanding of the groundwater flow direction).  These limitations may be able to be addressed by installing additional wells in key portions of the plume where data are sparse and/or highly variable."),
  tags$div("Tool 5 is specifically intended to use estimated rate constants to examine site monitoring data and determine whether contaminants in groundwater can migrate beyond the site boundary (or other point of compliance) at concentrations that exceed acceptable levels.  Consequently, both the acceptable concentration level (cleanup goal) and the location where this clean-up goal must be achieved should be established in advance of any transition assessment."),
  tags$div("At sites where the current plume footprint does not extend to the property boundary or other downgradient point of compliance, it is helpful to understand if there is area available for potential plume expansion.  Such plume expansion could occur if active treatment measures are discontinued, such as shutting off the farthest downgradient extraction well for a pump and treat system.  In these cases, the presence of a downgradient area that can be used as for further attenuation of the plume is helpful, particularly if active treatment was being used to provide plume containment.  This area serves as a plume assimilative capacity zone that allows concentrations to further decline prior to ultimately reaching the downgradient point of compliance."),
  tags$div("The primary goal of Tool 5 is to determine if attenuation rate is sufficient to ensure that the concentration cleanup goal will be achieved at the downgradient point of compliance distance from the well of concern after the end of active treatment.  This forecast can be made with one or more of the rate constants that can be estimated using this tool, including pre-remediation data, lab-based data, or post-remediation data.  Based on the type of rate constant that was selected, the tabs within the Tool 5 contain graphs that show the projected concentration with distance during the post-remediation period from any well of interest.  The concentration at the downgradient point of compliance is then compared to the user-specified cleanup goal."),
  tags$div("For sites where active treatment has been used or is currently being used, a rebound test can provide valuable information for understanding how concentrations will respond if treatment systems are shut down (Truex et al., 2017).  This could include a temporary halt for pump-and-treat systems, during which concentrations at the extraction well(s) and nearby wells are monitored for a “rebound” in concentrations.  Rebound testing can also be done for SVE systems that are in place to prevent migration of contaminants to groundwater.",
           tags$br(),
           tags$br(),
           "References:",
           tags$br(),
tags$li("Truex, M., Johnson, C., Macbeth, T., Becker, D., Lynch, K., Giaudrone, D., Frantz, A. and Lee, H., 2017. Performance assessment of pump‐and‐treat systems. Groundwater Monitoring & Remediation, 37(3), pp.28-44"
)),
  tags$div("Concentrations may rebound when treatment systems are shut off due to a variety of factors.  This could include shifts in the rate of mass transfer of contaminants to groundwater from different phases (NAPL) or matrices (desorption, matrix diffusion).  It could also result from changes in the flow paths for contaminants when pumping wells are no longer active, such that contaminants are diluted to a lesser degree when they reach the extraction well.  To the extent practical, a rebound test should be conducted for a sufficient duration to allow contaminant concentrations to equilibrate (level off)."),
  tags$div("The concentration measured during a post-rebound period is likely to be more representative of concentrations under natural conditions.  Consequently, it is also likely to be a more appropriate starting concentration when performing projections of the concentration with distance in a plume following a transition to monitored natural attenuation.  If available, the user should enter this type of post-rebound data in Tool 5 to help understand if natural attenuation will reduce concentrations to the cleanup goal by the time groundwater reaches the downgradient point of compliance."),
  tags$div("Tool 1 can be used to estimate the first-order rate constants that describe the attenuation of contaminant concentrations over time at individual wells.   This procedure can be also used to estimate the rate at which contaminants being captured by extraction well(s) is changing over time.  If the rate constant associated with a representative pumping well is similar to the rate constant(s) for monitoring wells obtained using pre-pumping data, then this indicates that pumping from that well has not affected the remediation timeframe.  In other words, the rate at which contaminants naturally attenuate is the primary factor that influences the time to achieve the site-specific cleanup goal.  This type of comparison serves as a line of evidence that MNA is a suitable alternative to an existing pump-and-treat system."),
  tags$div("Tool 2 will estimate the concentration trend for individual wells or groups of wells using the concentration vs. time data.   A stable or decreasing trend for individual downgradient wells, or the entire group of downgradient wells, suggests that attenuation within the plume is contributing to a stable or shrinking plume footprint.  This should be coupled with a general documentation that the plume footprint is not increasing in size over time.  These data serve as a primary line of evidence that natural attenuation is occurring and supports a further evaluation of whether MNA can be used to meet site-specific remedial objectives.  "),
  tags$div("In some cases, changes in environmental conditions may influence plume stability, so evaluating the appropriateness of MNA at a particular site should also consider the sustainability of conditions and processes at that site. There are several approaches that can be used to assess the sustainability of natural attenuation processes.  This can include assessing long-term geochemical data (e.g., dissolved oxygen, oxidation-reduction potential) from wells located upgradient and within the plume to document that geochemical conditions that promote (or reflect) the desired reactions are not changing over time.  Within the TA2 Tool, Tool 2 can be used to determine rate constants for subsets of the monitoring period, and this may help support a sustainability assessment.  For example, the rate constant obtained for a recent monitoring period can be compared to the rate constant for the entire monitoring period (or an earlier monitoring period) to better understand if the attenuation rates are slowing down over time.  "),
  tags$div("MNA is unlikely to be an appropriate alternative for sites where a potential risk to receptors has been identified.  At such sites, MNA may still be useful as a part of a treatment train approach for portions of the plume."),
  tags$div("Establishing the remediation timeframe—the time required for concentrations to decline below pre-determined concentration goals—is a critical remediation objective at most sites.  Importantly, it is generally a pre-requisite for using MNA as an alternative remedy to active treatment at sites where a goal concentration must be met at all monitoring locations (including source area monitoring wells).  Tool 1 calculates the remediation timeframe (time to clean) for a well (or set of wells) using the rate constant for that well.  The time to reach cleanup goals across the site are generally most dependent on the rate constants for the source area wells.  In this type of evaluation, the rate constant should represent the attenuation rate that is expected in the absence of other active treatment measures.  The time to reach the cleanup goal should then be evaluated based on an understanding of what is considered “reasonable” under the applicable regulatory framework.",
           tags$br(),
           tags$br(),

"If the timeframe calculated using Tool 1 is considered “reasonable” under a natural attenuation scenario and there is no apparent risk, then MNA may be an appropriate remedy or risk management strategy for the site.",
           tags$br(),
           tags$br(),
"If the timeframe calculated using Tool 1 is not considered “reasonable” under a natural attenuation scenario where MNA is being used as a remedy, then other alternatives besides MNA should be evaluated (see step 3b)."),
  tags$div("For sites that are being managed under CERCLA, MNA is typically considered a remedy like any other remedy.  In other words, the expectation is that the concentration(s) of regulated contaminants across the entire site are below a specific cleanup goal within a reasonable time frame.  Consequently, the monitoring locations with high concentrations, such as those in the source area, are likely to be the driver for whether the goal concentration(s) can be achieved, and the rate at which the source is attenuating will control how long the contaminants will be present.  If the estimated timeframe to reach the goal concentrations based on natural attenuation alone is not considered “reasonable” (using Tool 1), then the benefits of additional source remediation can be examined using Tool 3."),
  tags$div("At sites where further active source remediation is being considered, Tool 3 provides an easy way to examine the relative benefits of removing the source completely.  The user can estimate the time required to achieve the goal concentration in the source area (with confidence intervals) after inputting the current concentration in the source area and other site-specific data.  The resulting remediation timeframe can then be evaluated against regulatory requirements to determine if it is “reasonable”.  "),
  tags$div("Tool 3 is designed to estimate the relative impact of complete source removal on the remediation timeframe.  However, it can also be used to provide a rough estimate the amount of natural attenuation of the source that would need to occur in order for any subsequent source remediation efforts to achieve the goal concentration in a reasonable timeframe.  In this case, the starting concentration (“Concentration of COC Before Source Removed at Monitoring Well”) in Tool 3 could be adjusted downward, and then the impact on the remediation timeframe is evaluated.  The resulting timeframe must still be adjusted to account for the time that it would take natural attenuation to achieve the new starting concentration (see next step).  "),
  tags$div("In the previous step, the user has entered a new starting concentration in Tool 3 for the source area monitoring well that is the driver for remediation timeframe estimates.  The time to achieve this new starting concentration via natural attenuation of the source can be estimated in Tool 1.  It is based on historical concentration vs. time data at that source area monitoring well, and it represents the rate of natural attenuation of the source.  The time estimate from this step must still be added to the time estimate from the previous step to determine the overall remediation timeframe. ",
           tags$br(),tags$br(),
"This exercise may provide useful information for sites where natural attenuation appears to be reducing the source concentrations at a steady rate, such that the benefits of immediate source remediation can be compared to the relative benefits of implementing source remediation after a period of continued natural attenuation. Note that this is a very rough approximation that may not adequately account for matrix diffusion effects in the pre-remediation (natural attenuation) period.
"),
  tags$div(""),
  tags$div(" "),
  tags$div(" "),
  tags$div("For sites that are being managed under many state regulatory programs or RCRA, MNA can often be used as part of a risk management strategy.  In these cases, the overall goal is to prevent a plume from exceeding a specified goal concentration at a downgradient point of compliance.   words, the expectation is that the concentration(s) of regulated contaminants across the entire site are below a specific cleanup goal within a reasonable time frame.  Consequently, the monitoring locations with high concentrations, such as those in the source area, are likely to be the driver for whether the goal concentration(s) can be achieved, and the rate at which the source is attenuating will control how long the contaminants will be present.  If the estimated timeframe to reach the goal concentrations based on natural attenuation alone is not considered “reasonable” (using Tool 1), then the benefits of additional source remediation can be examined using Tool 3."),
  tags$div("If a plume is already stable or shrinking, then this serves as a key line of evidence that natural attenuation processes are active at a site, even if the site-specific remedial objectives are not expected to be achieved with natural attenuation alone.  Consequently, MNA could be evaluated as part of treatment train approach for risk management at these sites, where MNA is coupled with enhanced attenuation strategies or active remediation.  "),
  tags$div("If concentrations at source area wells are decreasing over time, particularly in areas where no on-going remediation is occurring, then this serves as another line of evidence that natural attenuation processes are active at a site.  Even if the site-specific remedial objectives are not expected to be achieved with natural attenuation alone, MNA can evaluated as part of treatment train approach for risk management at these sites (see next step).  "),
  tags$div("At sites where further source remediation is being considered to help reduce contaminant concentrations before groundwater reaches a downgradient receptor, Tool 5 can be used to way to estimate the relative benefits of source remediation.  The user can enter a new source well concentration in any of the Tool 5 tabs to represent the concentration in the initial post-remediation period.  The remediation performance data from Tool 4 can be used to support the selection of a new source well concentration, if needed. The tool then projects to plume concentration over distance from this source well using whichever rate constant is selected by the user.",
     tags$br(),
           tags$br(),
"For example, if the user chooses the “Use Pre-Remediation Rate Constant” option, then the tool will project the concentration from the source well (using the concentration entered by the user as a starting point) to the downgradient point of compliance using this rate constant.  The user can then iteratively change the source well concentration until the tool projects that the goal concentration will be achieved at the downgradient point of compliance.  The ratio of this source well concentration to the current source well concentration represents the required reduction in source concentration that remediation must achieve.  Assuming the reduction is achieveable, MNA could then be used as part of a risk management strategy in the post-remediation period to ensure that the goal concentration was met at the downgradient point of compliance.
"),
  tags$div("Source attenuation rates can be estimated in Tool 1 using concentration vs. time data for a source well, preferably from the period prior to any active remediation.  This rate can be used within Tool 1 to determine how long natural attenuation would take to achieve the source well concentration estimated in the previous step.  This time should be compared to the time it would take for active remediation to achieve the same concentration (i.e., the implementation and O&M period for active remediation).  If MNA can achieve this source concentration in a similar period, then there is less need to implement active remediation. "),
  tags$div(" "),
  tags$div(" "),
  tags$div(" ")
    
    
    
    
    
    
  )
  
}