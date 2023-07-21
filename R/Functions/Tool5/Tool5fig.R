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
  
  max_raw = max(10^(ceiling(log10(df_series$Concentration))))
  min_raw = min(10^(floor(log10(df_series$Concentration))))
  max_dist = max(10^(ceiling(log10(df_series$Distance))))
  min_dist = min(10^(floor(log10(df_series$Distance))))
  if (State!='Lab-Based'){


    pt_small <-min(min(df_series$Concentration,na.rm=TRUE),C_goal)
    
    # generate point of compliance and cleanup goal line
    p <- plot_ly(source = 'ts_selected')%>%
      add_segments(y = (C_goal), yend = (C_goal),
                   x = 0, xend = max(sen$model$Distance,df_series$Distance,Ltot,
                                     0, sen$model$Distance,Ltot,Ltot*2.9,
                                     (log(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2]),
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
                     name = ~State_name,#' ',
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
                              (log(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2])
                              ),
                          y=c(exp(predict(sen,data.frame(Distance = 0))),
                              exp(fitted(sen)),
                              exp(predict(sen,data.frame(Distance = Ltot))),
                              exp(predict(sen,data.frame(Distance = Ltot*2.9))),
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
                             ))
    plot_df3$y = exp(log(Esource1$Concentration)+sen$coefficients[2]*plot_df3$x-sen$coefficients[2]*plot_df3$x[1])
                          # y=c((Esource1$Concentration),
                          #     exp(log(Esource1$Concentration) + as.numeric(sen$coefficients[2]*(max(dd$Distance)-Esource1$Distance))),
                          #     exp(log(Esource1$Concentration) + as.numeric(sen$coefficients[2]*(Ltot-Esource1$Distance))),
                          #     exp(log(Esource1$Concentration) + as.numeric(sen$coefficients[2]*(Ltot-Esource1$Distance)*2.9))
                          #     )
    #)
    
    
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
                     name = ~State_name,#' ',
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

    plot_df2 <-data.frame(x=c(eval_series$Distance, 
                              Ltot,
                              Ltot+eval_series$Distance,
                              exp(log((eval_series$Concentration-min_raw))*gwv/Rate_bio+eval_series$Distance)),
                          y=c((eval_series$Concentration),
                              exp(log(eval_series$Concentration)-((Rate_bio/gwv*(Ltot-eval_series$Distance)))),
                              exp(log(eval_series$Concentration)-((Rate_bio/gwv*Ltot))),
                              min_raw
                              )
    )
    plot_df2<-plot_df2%>%filter(y>=0)
  }else{
    State1 =State
    dd = df_series%>%filter(State==State1) #'PostRem'
    p<-p%>%add_trace(data = dd,
                     x= ~Distance,
                     y = ~Concentration ,
                     name = ~State_name,#' ',
                     type = "scatter",
                     mode = 'markers',
                     text = ~Concentration,
                     marker = marker_plotly(color='black'),
                     customdata = ~I(WellID),
                     hovertemplate = paste('<br>Well ID: %{customdata}',
                                           '<br>Distance: %{x:.0f} m',
                                           '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
    
    plot_df2 <-data.frame(x=c(0, sen$model$Distance,Ltot,Ltot*2.9,
                              (log(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2])),
                          y=c(exp(predict(sen,data.frame(Distance = 0))),
                              exp(fitted(sen)),
                              exp(predict(sen,data.frame(Distance = Ltot))),
                              exp(predict(sen,data.frame(Distance = Ltot*2.9))),C_goal))
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
                              paste0("Regression:",State),
                              paste0("Regression:",State,"ediation")),
                hovertemplate = ifelse(State=='PreRem',
                                       paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'),
                                       paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
      )%>%
      add_lines(data = plot_df2,
                x = ~x,
                y = ~exp(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                text = ~exp(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                name =paste0("Regression:",State," with confidence"),
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
                y = ~exp(log(Esource1$Concentration)+confint(sen,level=CIvalue1*2-1)[[4]]*x-confint(sen,level=CIvalue1*2-1)[[4]]*plot_df3$x[1]),
                text = ~exp(log(Esource1$Concentration)+confint(sen,level=CIvalue1*2-1)[[4]]*x-confint(sen,level=CIvalue1*2-1)[[4]]*plot_df3$x[1]),
                line = list(color = '#BEBADA',shape='spline',dash = 'dash'),
                name = ifelse(State=='Projected'|State=='Lab-Based',
                              paste0("Regression:Evaluation Well ",State," with confidence"),
                              paste0("Regression:Evaluation Well ",State,"ediation with confidence")),
                hovertemplate = paste('<br>Evaluation Well<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'L<br>')
      )
    
    
  }else if(State =='Lab-Based'){

    plot_df3 <-data.frame(x=c(eval_series$Distance, 
                              Ltot,
                              Ltot+eval_series$Distance,
                              exp(log((eval_series$Concentration-min_raw))*gwv/CI+eval_series$Distance)),
                          y=c((eval_series$Concentration),
                              exp(log(eval_series$Concentration)-((CI/gwv*(Ltot-eval_series$Distance)))),
                              exp(log(eval_series$Concentration)-((CI/gwv*Ltot))),
                              min_raw
                              )
                          )
    plot_df3<-plot_df3%>%filter(y>=0)
    plot_df3<-plot_df3%>%arrange(x)

    p <- p%>%
        add_lines(data = plot_df2,
                  x = ~x,
                  y = ~y,
                  text = c_raw2,
                  line = list(color = '#4472C4',shape='spline'),
                  name = ifelse(State=='Projected'|State=='Lab-Based',
                                paste0("Projection ",State),
                                paste0("Projection ",State,"ediation")),
                  hovertemplate = ifelse(State=='PreRem',
                                         paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'),
                                         paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ',unit_method,'<br>'))
        )%>%add_lines(data = plot_df3,
                x = ~x,
                y = ~y,
                text = ~y,
                line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                name = paste0("Projection ",State, ' with Confidence'),
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
                y = ~exp(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                text = ~exp(sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x),
                line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                name =paste0("Regression:",State,"ediation with confidence"),
                hovertemplate = ifelse(State=='PreRem',
                                       paste('<br>Pre Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f}',unit_method,'<br>'),
                                       paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f}',unit_method,'<br>'))
      )
    
    
  }
  
  
  # format the figure

  
  if (State=='Lab-Based'){

    p <- p %>%
      add_annotations(x = mean(Ltot*0.5,na.rm = TRUE),
                      y = log10(C_goal*1.3),
                      text = paste0("Cleanup Goal (",C_goal," ",unit_method,")"),
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
                     ticks="outside",
                     mirror = "ticks",
                     range = ifelse(rep(State=='Projected'|State=='Lab-Based',2),
                                    c(0,max(Ltot*1.2,df_series$Distance,na.rm=TRUE)),
                                    c(0,max(df_series$Distance*1.2,Ltot*1.2,max(df_series$Distance),rm.na=TRUE))
                                    )),#c(0,Ltot*1.2)),
        yaxis = list(title = list(text = ifelse(unit_method =="µmole/L","COC Concentration (µmole/L)","COC Concentration (µg/L)"),
                                  font = list(size=18)),
                     tickfont = list(size = 18),
                     range = c(min(log10(min(df_series$Concentration,min_raw,na.rm = TRUE))), 
                                     yend = log10(max(
                                                      max(df_series$Concentration,na.rm = TRUE),
                                                      max_raw
                                     )
                                     )),#c(log(min(1,Lsource1*0.5,C_goal*0.5)), log(max(1,Lsource1*1.5,C_goal*1.5))),
                     #range=c(log(Lsource1)-0.5, yend = log(max(Lsource1)+1)),
                     linecolor = toRGB("black"),
                     linewidth = 2,
                     showline=T,
                     zeroline = FALSE,
                     ticks="outside",
                     tickmode = 'linear',
                     dtick = 1,
                     tick0 = min(log10(min(df_series$Concentration,min_raw,na.rm = TRUE))),
                     #tickvals=tval,
                     #ticktext=ttxt,
                     exponentformat = "power",
                     type="log",
                     mirror = "ticks"),
        showlegend = TRUE,
        legend = list(orientation = 'h',title ='',y=-0.25,font = list(size = 18),itemwidth=100),
        margin = margin
      )
  }else{
    max_raw = max(10^(ceiling(log10(dd$Concentration))))
    min_raw = min(10^(floor(log10(dd$Concentration))))
    mmax = ceiling(log10(max(10^(predict(sen,data.frame(Distance = 0))),
                             10^(predict(sen,data.frame(Distance = Ltot))),
                             max(df_series$Concentration,na.rm = TRUE),
                             max_raw)))
    mmin = floor(min(log10(min(df_series$Concentration,min_raw,na.rm = TRUE))))
    p <- p %>%
      add_annotations(x = ifelse(State=="projected",Ltot*1.2/2,
                                 mean(df_series$Distance*1.2,na.rm = TRUE)),
                      y = log10(C_goal*1.3),
                      text = paste0("Cleanup Goal (",C_goal," ",unit_method,")"),
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
                     ticks="outside",
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
                             yend = log10(max(exp(predict(sen,data.frame(Distance = 0))),
                               exp(predict(sen,data.frame(Distance = Ltot))),
                               max(df_series$Concentration,na.rm = TRUE),
                               max_raw
                               )
                             )),
                     linecolor = toRGB("black"),
                     linewidth = 2,
                     type="log",
                     showline=T,
                     zeroline = FALSE,
                     ticks="outside",
                     tickmode = 'linear',
                     dtick = 1,
                     tick0 = mmin,
                     #tickvals=tval,
                     #ticktext=ttxt,
                     exponentformat = "power",
                     mirror = "ticks"
        ), 
        showlegend = TRUE,
        legend = list(orientation = 'h',title ='',y=-0.25,font = list(size = 18),itemwidth=100),
        margin = margin
      )
  }
  return(p)
}

