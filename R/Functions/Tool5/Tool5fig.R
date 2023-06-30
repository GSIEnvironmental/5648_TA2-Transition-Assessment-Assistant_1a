#############################################################################
#############################################################################


#%% ----- FUNCTION FOR FIGURE GENERATION for post remediation

#----- INPUT
# data base of average concentration from df_series function
# regression model for each averaged/geomean database from regression_fitness
# check the sliders
Tool5fig <- function(df_series, C_goal, Lsource1, Ltot, CI, State,eval_well,
                     unit_method,
                     sen = NULL,gwv=NULL,Rate_bio=NULL,projection_state=NULL){
  
  max_raw = max(10^ceiling(log10(df_series$Concentration)))
  min_raw = min(10^floor(log10(df_series$Concentration)))
  if (State!='Lab-Based'){
    # create y axis as log 
    # tval <- sort(as.vector(sapply(seq(1,9),
    #                               function(x)
    #                                 x*(seq(floor(min(C_goal,min(df_series$Concentration,na.rm=TRUE))),
    #                                        ceiling(max(df_series$Concentration,na.rm=TRUE)))))))#generates a sequence of numbers in logarithmic divisions
    # 
    # ttxt <- rep(" ",length(tval))  # no label at most of the ticks
    # ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
    # 

    pt_small <-min(min(df_series$Concentration,na.rm=TRUE),C_goal)
    
    # generate point of compliance and cleanup goal line
    p <- plot_ly(source = 'ts_selected')%>%
      add_segments(y = (C_goal), yend = (C_goal),
                   x = 0, xend = max(sen$model$Distance,df_series$Distance,Ltot,
                                     0, sen$model$Distance,Ltot,Ltot*2.9,
                                     (log10(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2]),
                                     rm.na=TRUE),
                   line = list(dash = "dash",color='black'), showlegend=FALSE)%>% #  CONCENTRATION GOAL
      add_trace(x= c(Ltot,Ltot),#10%
                y = c((min(df_series$Concentration,min_raw,na.rm = TRUE)), 
                      yend = max(predict(sen,data.frame(Distance = 0)),
                                 (max(df_series$Concentration,na.rm = TRUE))+1,
                                 C_goal,
                                 max_raw
                                 )),
                name = ' ',
                type = "scatter",
                mode = 'lines',
                line = list(shape = 'linear',color='rgba(185,103,239,0.8)'),
                showlegend = F,
                hovertemplate =  paste('<br>Point of Compliance <br> Distance: %{x} m')
      )  # point of Compliance
    
  }else{
    # generate point of compliance and cleanup goal line
    eval_series<-df_series%>%filter(WellID==eval_well)
    if (nrow(eval_series)==2){
      eval_series<-eval_series%>%filter(State=="PostRem")
    }
    p <- plot_ly(source = 'ts_selected')%>%
      add_segments(y = (C_goal), yend = (C_goal),
                   x = 0, xend = Ltot*1.2,
                   line = list(dash = "dash",color='black'), showlegend=FALSE)%>% #  CONCENTRATION GOAL
      add_trace(x= c(Ltot,Ltot),#10%
                y = c((min(1,Lsource1*0.5,C_goal*0.5,min_raw)), 
                      (max(1,Lsource1*1.5,C_goal*1.5,max_raw))) ,
                name = ' ',
                type = "scatter",
                mode = 'lines',
                line = list(shape = 'linear',color='rgba(185,103,239,0.8)'),
                showlegend = F,
                hovertemplate =  paste('<br>Point of Compliance <br> Distance: %{x} m')
      ) 
  }
  
  # plot data
  
  if (State =='Projected'){
    State1 =State
    dd = df_series
    p<-p%>%add_trace(data = dd,
                     x= ~Distance,
                     y = ~Concentration ,
                     name = ~State,#' ',
                     type = "scatter",
                     mode = 'markers',
                     text = ~Concentration,
                     marker = list(size=10),
                     color = ~as.factor(State),
                     customdata = ~I(WellID),
                     hovertemplate = paste('<br>Well ID: %{customdata}',
                                           '<br>Distance: %{x:.0f} m',
                                           '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
      # add_trace(x= 0,
      #                y = (Lsource1) ,
      #                name = 'Current Concentration for Source Well',
      #                type = "scatter",
      #                mode = 'markers',
      #                text = I(Lsource1),
      #                marker = marker_plotly(color='black'),
      #                hovertemplate = paste('<br>Distance: %{x} m',
      #                                      '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
    
    plot_df2 <-data.frame(x=c(0, 
                              sen$model$Distance,
                              Ltot,
                              Ltot*2.9,
                              (log10(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2])
                              ),
                          y=c(10^predict(sen,data.frame(Distance = 0)),
                              10^fitted(sen),
                              10^predict(sen,data.frame(Distance = Ltot)),
                              10^predict(sen,data.frame(Distance = Ltot*2.9)),
                              C_goal
                              )
                          )

    Esource1 = dd%>%filter(WellID==eval_well)
    
    if (nrow(Esource1)==2){
      Esource1 <- Esource1%>%
        filter(State==ifelse(projection_state=='Pre','PreRem','PostRem'))
    }
                           
    plot_df3<-data.frame(x=c(Esource1$Distance, 
                             max(dd$Distance),
                             Ltot,
                             Ltot*2.9
                             ),
                          y=c((Esource1$Concentration),
                              10^(log10(Esource1$Concentration) + as.numeric(sen$coefficients[2]*max(dd$Distance))),
                              10^(log10(Esource1$Concentration) + as.numeric(sen$coefficients[2]*Ltot)),
                              10^(log10(Esource1$Concentration) + as.numeric(sen$coefficients[2]*Ltot*2.9))
                              )
    )
    
    
  }else if(State=='Lab-Based'){
    # p<-p%>%add_markers(x= 0,
    #                    y = (Lsource1) ,
    #                    name = 'Current Concentration for Source Well',
    #                    type = "scatter",
    #                    mode = 'markers',
    #                    text =  I(Lsource1),
    #                    marker = marker_plotly(color='black'),
    #                    hovertemplate = paste('<br>Distance: %{x} m',
    #                                          '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
    # 

    dd = df_series
    p<-p%>%add_trace(data = dd,
                     x= ~Distance,
                     y = ~Concentration ,
                     name = ~State,#' ',
                     type = "scatter",
                     mode = 'markers',
                     text = ~Concentration,
                     marker = list(size=10),
                     color = ~as.factor(State),
                     customdata = ~I(WellID),
                     hovertemplate = paste('<br>Well ID: %{customdata}',
                                           '<br>Distance: %{x:.0f} m',
                                           '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
    Esource1 = dd%>%filter(WellID==eval_well)
    
    if (nrow(Esource1)==2){
      Esource1 <- Esource1%>%
        filter(State==ifelse(projection_state=='Pre','PreRem','PostRem'))
    }
    
    plot_df2 <-data.frame(x=c(eval_series$Distance, Ltot,C_goal*0.1*eval_series$Concentration*gwv/Rate_bio),
                          y=c((eval_series$Concentration),(eval_series$Concentration-Rate_bio/gwv*Ltot),C_goal*0.1)
    )
    plot_df2<-plot_df2%>%filter(y>=0)
  }else{
    State1 =State
    dd = df_series%>%filter(State==State1) #'PostRem'
    p<-p%>%add_trace(data = dd,
                     x= ~Distance,
                     y = ~Concentration ,
                     name = ~State,#' ',
                     type = "scatter",
                     mode = 'markers',
                     text = ~Concentration,
                     marker = marker_plotly(color='black'),
                     customdata = ~I(WellID),
                     hovertemplate = paste('<br>Well ID: %{customdata}',
                                           '<br>Distance: %{x:.0f} m',
                                           '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
    
    plot_df2 <-data.frame(x=c(0, sen$model$Distance,Ltot,Ltot*2.9,
                              (log10(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2])),
                          y=c(10^predict(sen,data.frame(Distance = 0)),
                              10^fitted(sen),
                              10^predict(sen,data.frame(Distance = Ltot)),
                              10^predict(sen,data.frame(Distance = Ltot*2.9)),C_goal))
  }
  
  
  
  
  plot_df2<-plot_df2%>%arrange(x)
  
  c_raw2 <- (plot_df2$y)
  
  
  
  
  # plot upper confidence interval line
  if (State =='Projected'){
    # add line for 80% confidence
    CIvalue1 = ifelse(CI=='80%',0.8,
                      ifelse(CI=='90%',0.9,
                             ifelse(CI=='95%',0.95,0.99)))

    p <- p%>%
      add_lines(data = plot_df2,
                x = ~x,
                y = ~y,
                text = c_raw2,
                line = list(color = '#4472C4',shape='spline'),
                name = ifelse(State=='Projected'|State=='Lab-Based',
                              paste0("Regression:Source",State),
                              paste0("Regression:",State,"ediation")),
                hovertemplate = ifelse(State=='PreRem',
                                       paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'),
                                       paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
      )%>%
      add_lines(data = plot_df2,
                x = ~x,
                y = ~10^(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                text = ~10^(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                name =paste0("Regression:",State,"ediation with confidence"),
                hovertemplate = ifelse(State=='PreRem',
                                       paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f}',unit_method,'<br>'),
                                       paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f}',unit_method,'<br>'))
      )%>%
      add_lines(data = plot_df3,
                x = ~x,
                y = ~y,
                text = plot_df3$y,
                line = list(color = '#BEBADA',shape='spline'),
                name = ifelse(State=='Projected'|State=='Lab-Based',
                              paste0("Regression:Evaluation Well ",State),
                              paste0("Regression:",State,"ediation")),
                hovertemplate = paste('<br>Evaluation Well<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'L<br>')
      )%>%
      add_lines(data = plot_df3,
                x = ~x,
                y = ~10^(log10(Esource1$Concentration)+confint(sen,level=CIvalue1*2-1)[[4]]*x-confint(sen,level=CIvalue1*2-1)[[4]]*plot_df3$x[1]),
                text = ~10^(log10(Esource1$Concentration)+confint(sen,level=CIvalue1*2-1)[[4]]*x-confint(sen,level=CIvalue1*2-1)[[4]]*plot_df3$x[1]),
                line = list(color = '#BEBADA',shape='spline',dash = 'dash'),
                name = ifelse(State=='Projected'|State=='Lab-Based',
                              paste0("Regression:Evaluation Well ",State," with confidence"),
                              paste0("Regression:Evaluation Well ",State,"ediation with confidence")),
                hovertemplate = paste('<br>Evaluation Well<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'L<br>')
      )
    
    
  }else if(State =='Lab-Based'){
    p <- p%>%
        add_lines(data = plot_df2,
                  x = ~x,
                  y = ~y,
                  text = c_raw2,
                  line = list(color = '#4472C4',shape='spline'),
                  name = ifelse(State=='Projected'|State=='Lab-Based',
                                paste0("Regression:",State),
                                paste0("Regression:",State,"ediation")),
                  hovertemplate = ifelse(State=='PreRem',
                                         paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'),
                                         paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
        )%>%add_lines(data = plot_df2,
                x = ~x,
                y = ~eval_series$Concentration-CI/gwv*x+CI/gwv*x[1],
                text = ~eval_series$Concentration-CI/gwv*x+CI/gwv*x[1],
                line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                name = paste0("Regression:",State, ' with Confidence'),
                hovertemplate = paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
    
  }else{
    CIvalue1 = ifelse(CI=='80%',0.8,
                      ifelse(CI=='90%',0.9,
                             ifelse(CI=='95%',0.95,0.99)))
    
    p <- p%>%
      add_lines(data = plot_df2,
                x = ~x,
                y = ~y,
                text = c_raw2,
                line = list(color = '#4472C4',shape='spline'),
                name = ifelse(State=='Projected'|State=='Lab-Based',
                              paste0("Regression:",State),
                              paste0("Regression:",State,"ediation")),
                hovertemplate = ifelse(State=='PreRem',
                                       paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'),
                                       paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
      )%>%
      add_lines(data = plot_df2,
                x = ~x,
                y = ~10^(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                text = ~10^(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                name =paste0("Regression:",State,"ediation with confidence"),
                hovertemplate = ifelse(State=='PreRem',
                                       paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f}',unit_method,'<br>'),
                                       paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f}',unit_method,'<br>'))
      )
    
    
  }
  
  
  # format the figure
  #browser()
  if (State=='Lab-Based'){
    p <- p %>%
      add_annotations(x = mean(Ltot*0.5,na.rm = TRUE),
                      y = (C_goal*1.3),
                      text = paste0("Cleanup Goal (",C_goal," ug/L)"),
                      xref = "x",
                      yref = "y",
                      font=list(size=15, color="black"),
                      showarrow=F)%>%
      add_annotations(x = Ltot,
                      y = (mean(C_goal*1.3,na.rm = TRUE)),
                      text = paste0("Point of<br>Compilance"),
                      xref = "x",
                      yref = "y",
                      xanchor = 'right',
                      font=list(size=15, color="purple"),
                      showarrow=T)%>%
      plotly::layout(
        title = title_plotly(paste0("<b>Concentration of COC in Identified Wells Over Distance</b>")
        ),
        #shapes = s,
        xaxis = list(title = list(text = "Distance (m)",font = list(size=18)),
                     tickfont = list(size = 18),
                     linecolor = toRGB("black"),
                     linewidth = 2,
                     showline=T,
                     mirror = "ticks",
                     range = c(0,Ltot*1.2)),
        yaxis = list(title = list(text = ifelse(unit_method =="µmole/L","COC Concentration (µmole/L)","COC Concentration (µg/L)"),
                                  font = list(size=18)),
                     tickfont = list(size = 18),
                     range = c(log10(min(1,Lsource1*0.5,C_goal*0.5)), log10(max(1,Lsource1*1.5,C_goal*1.5))),
                     #range=c(log10(Lsource1)-0.5, yend = log10(max(Lsource1)+1)),
                     linecolor = toRGB("black"),
                     linewidth = 2,
                     showline=T,
                     zeroline = FALSE,
                     type="log",
                     mirror = "ticks"),
        showlegend = TRUE,
        legend = list(orientation = 'h',title ='',y=-0.25,font = list(size = 18),itemwidth=100),
        margin = margin
      )
  }else{
    max_raw = max(10^ceiling(log10(dd$Concentration)))
    min_raw = min(10^floor(log10(dd$Concentration)))
    p <- p %>%
      add_annotations(x = ifelse(State=="projected",Ltot*1.2/2,
                                 mean(df_series$Distance*1.2,na.rm = TRUE)),
                      y = (C_goal*1.3),
                      text = paste0("Cleanup Goal (",C_goal," ug/L)"),
                      xref = "x",
                      yref = "y",
                      font=list(size=15, color="black"),
                      showarrow=F)%>%
      add_annotations(x = Ltot,
                      y = (mean(df_series$Concentration,na.rm = TRUE)),
                      text = paste0("Point of<br>Compilance"),
                      xref = "x",
                      yref = "y",
                      xanchor = 'right',
                      font=list(size=15, color="purple"),
                      showarrow=T)%>%
      plotly::layout(
        title = title_plotly(paste0("<b> Concentration of COC in Identified Wells Over Distance</b>")),
        #shapes = s,
        xaxis = list(title = list(text = "Distance (m)",font = list(size=18)),
                     tickfont = list(size = 18),
                     linecolor = toRGB("black"),
                     linewidth = 2,
                     showline=T,
                     mirror = "ticks",
                     range = ifelse(rep(State=='Projected'|State=='Lab-Based',2),
                                    c(0,max(Ltot*1.2,df_series$Distance,na.rm=TRUE)),
                                    c(0,max(sen$model$Distance*1.2,df_series$Distance*1.2,Ltot*1.2,max(df_series$Distance),rm.na=TRUE))
                     )
        ),
        yaxis = list(title = list(text = ifelse(unit_method =="µmole/L","COC Concentration (µmole/L)","COC Concentration (µg/L)"),
                                  font = list(size=18)),
                     tickfont = list(size = 18),
                     range=c(min(log10(min(df_series$Concentration,min_raw,na.rm = TRUE))), 
                             yend = log10(max(10^predict(sen,data.frame(Distance = 0)),
                               10^(predict(sen,data.frame(Distance = Ltot))),
                               max(df_series$Concentration,na.rm = TRUE),
                               max_raw
                               )
                             )),
                     linecolor = toRGB("black"),
                     linewidth = 2,
                     type="log",
                     showline=T,
                     zeroline = FALSE,
                     mirror = "ticks"
        ), 
        showlegend = TRUE,
        legend = list(orientation = 'h',title ='',y=-0.25,font = list(size = 18),itemwidth=100),
        margin = margin
      )
  }
  return(p)
}

