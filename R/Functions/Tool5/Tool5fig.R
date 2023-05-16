#############################################################################


#%% ----- FUNCTION FOR FIGURE GENERATION for post remediation

#----- INPUT
# data base of average concentration from df_series function
# regression model for each averaged/geomean database from regression_fitness
# check the sliders
Tool5fig <- function(df_series, C_goal, Lsource1, Ltot, CI, State,group_method1,
                     sen = NULL,gwv=NULL,Rate_bio=NULL){


    if (State!='Lab-Based'){
      # create y axis as log 
      tval <- sort(as.vector(sapply(seq(1,9),
                                    function(x)
                                      x*(seq(floor(log10(min(C_goal,min(df_series$Concentration,na.rm=TRUE)))),
                                             ceiling(log10(max(df_series$Concentration,na.rm=TRUE))))))))#generates a sequence of numbers in logarithmic divisions
      
      ttxt <- rep(" ",length(tval))  # no label at most of the ticks
      ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
      
      
      pt_small <-log10(min(min(df_series$Concentration,na.rm=TRUE),C_goal))
      
      # generate point of compliance and cleanup goal line
      p <- plot_ly(source = 'ts_selected')%>%
        add_segments(y = log10(C_goal), yend = log10(C_goal),
                     x = 0, xend = max(sen$model$Distance,df_series$Distance,Ltot,
                                       0, sen$model$Distance,Ltot,Ltot*2.9,
                                         (log10(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2]),
                                       rm.na=TRUE),
                     line = list(dash = "dash",color='black'), showlegend=FALSE)%>% #  CONCENTRATION GOAL
        add_trace(x= c(Ltot,Ltot),#10%
                  y = c(log10(min(df_series$Concentration,na.rm = TRUE))-0.5, 
                              yend = log10(max(df_series$Concentration,na.rm = TRUE))+1),
                  name = ' ',
                  type = "scatter",
                  mode = 'lines',
                  line = list(shape = 'linear',color='rgba(185,103,239,0.8)'),
                  showlegend = F,
                  hovertemplate =  paste('<br>Point of Compliance <br> Distance: %{x} m')
        )  
      
    }else{
      # generate point of compliance and cleanup goal line
      p <- plot_ly(source = 'ts_selected')%>%
        add_segments(y = log10(C_goal), yend = log10(C_goal),
                     x = 0, xend = Ltot*1.2,
                     line = list(dash = "dash",color='black'), showlegend=FALSE)%>% #  CONCENTRATION GOAL
        add_trace(x= c(Ltot,Ltot),#10%
                  y = c(log10(min(1,Lsource1*0.5,C_goal*0.5)), log10(max(1,Lsource1*100,C_goal*100))) ,
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
      
      p<-p%>%add_trace(x= 0,
                       y = log10(Lsource1) ,
                       name = 'Current Concentration for Source Well',
                       type = "scatter",
                       mode = 'markers',
                       text = log10(Lsource1),
                       marker = marker_plotly(color='black'),
                       hovertemplate = paste('<br>Distance: %{x} m',
                                             '<br>Concentration: %{text:.2f} ug/L<br>'))
      
      plot_df2 <-data.frame(x=c(0, Ltot),
                            y=c(log10(Lsource1),log10(Lsource1) + as.numeric(sen$coefficients[2]*Ltot))
                            )
      
      
    }else if(State=='Lab-Based'){
      p<-p%>%add_trace(x= 0,
                       y = log10(Lsource1) ,
                       name = 'Current Concentration for Source Well',
                       type = "scatter",
                       mode = 'markers',
                       text =  Lsource1,
                       marker = marker_plotly(color='black'),
                       hovertemplate = paste('<br>Distance: %{x} m',
                                             '<br>Concentration: %{text:2f} ug/L<br>'))
      
      plot_df2 <-data.frame(x=c(0, Ltot),
                            y=c(log10(Lsource1),log10(Lsource1-Rate_bio/gwv*Ltot))
      )
    }else{
      State1 =State
      dd = df_series%>%filter(State==State1) #'PostRem'
      p<-p%>%add_trace(data = dd,
                       x= ~Distance,
                       y = ~log10(Concentration) ,
                       name = ~State,#' ',
                       type = "scatter",
                       mode = 'markers',
                       text = ~Concentration,
                       marker = marker_plotly(color='black'),
                       hovertemplate = paste('<br>Distance: %{x} m',
                                             '<br>Concentration: %{text:.2f} ug/L<br>'))
      
      plot_df2 <-data.frame(x=c(0, sen$model$Distance,Ltot,Ltot*2.9,
                                (log10(C_goal)-as.numeric(sen$coefficients[1]))/as.numeric(sen$coefficients[2])),
                            y=c(predict(sen,data.frame(Distance = 0)),
                                fitted(sen),
                                predict(sen,data.frame(Distance = Ltot)),
                                predict(sen,data.frame(Distance = Ltot*2.9)),log10(C_goal)))
    }
    
    
      

      plot_df2<-plot_df2%>%arrange(-x)
      
      c_raw2 <- 10^(plot_df2$y)
      
      #plot regression line
      p <- p%>%
        add_lines(data = plot_df2,
                  x = ~x,
                  y = ~y,
                  text = c_raw2,
                  line = list(color = '#4472C4',shape='spline'),
                  name = ifelse(State=='Projected'|State=='Lab-Based',
                                paste0("Regression:",State),
                                paste0("Regression:",State,"ediation")),
                  hovertemplate = paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ug/L<br>'))
      
      
      
      # plot upper confidence interval line
      if (State =='Projected'){
        # add line for 80% confidence
        CIvalue1 = ifelse(CI=='80%',0.8,
                        ifelse(CI=='90%',0.9,
                               ifelse(CI=='95%',0.95,0.99)))
        p <- p%>%
          add_lines(data = plot_df2,
                    x = ~x,
                    y = ~log10(Lsource1)+confint(sen,level=CIvalue1*2-1)[[4]]*x,
                    text = c_raw2,
                    line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                    name = ifelse(State=='Projected'|State=='Lab-Based',
                                  paste0("Regression:",State," with confidence"),
                                  paste0("Regression:",State,"ediation with confidence")),
                    hovertemplate = paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{y:.2f} ug/L<br>'))
        
        
      }else if(State =='Lab-Based'){
        p <- p%>%
          add_lines(data = plot_df2,
                    x = ~x,
                    y = ~log10(Lsource1-CI/gwv*x),
                    text = c_raw2,
                    line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                    name = paste0("Regression:",State, ' with Confidence'),
                    hovertemplate = paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{y:.2f} ug/L<br>'))
        
      }else{
        CIvalue1 = ifelse(CI=='80%',0.8,
                          ifelse(CI=='90%',0.9,
                                 ifelse(CI=='95%',0.95,0.99)))
        p <- p%>%
          add_lines(data = plot_df2,
                    x = ~x,
                    y = ~sen$coefficients[1]+confint(sen,level=CIvalue1*2-1)[[4]]*x,
                    text = c_raw2,
                    line = list(color = '#4472C4',shape='spline',dash = 'dash'),
                    name =paste0("Regression:",State,"ediation with confidence"),
                    hovertemplate = paste('<br>Post Rem<br>Distance: %{x:.0f} m', '<br>Concentration: %{text:.2f} ug/L<br>'))
        
        
      }
      
    
    # format the figure
    #browser()
      if (State=='Lab-Based'){
        p <- p %>%
          add_annotations(x = mean(Ltot*0.5,na.rm = TRUE),
                          y = log10(C_goal*1.3),
                          text = paste0("Cleanup Goal (",C_goal," ug/L)"),
                          xref = "x",
                          yref = "y",
                          font=list(size=15, color="black"),
                          showarrow=F)%>%
          add_annotations(x = Ltot,
                          y = log10(mean(C_goal*1.3,na.rm = TRUE)),
                          text = paste0("Point of<br>Compilance"),
                          xref = "x",
                          yref = "y",
                          xanchor = 'right',
                          font=list(size=15, color="purple"),
                          showarrow=T)%>%
          plotly::layout(
            title = title_plotly(paste0("<b>",group_method1,
                                        " Concentration of COC in Selected Wells Over Distance</b>")
                                 ),
            #shapes = s,
            xaxis = list(title = "Distance (m)",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         showline=T,
                         mirror = "ticks",
                         range = c(0,Ltot*1.2)),
            yaxis = list(title = "log10 [COC Concentration (ug/L)]",
                         range = c(log10(min(1,Lsource1*0.5,C_goal*0.5)), log10(max(1,Lsource1*1.5,C_goal*1.5))),
                         #range=c(log10(Lsource1)-0.5, yend = log10(max(Lsource1)+1)),
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         showline=T,
                         zeroline = FALSE,
                         mirror = "ticks"),
            showlegend = TRUE,
            legend = list(orientation = 'h',title ='',y=-0.25,font = list(size = 18),itemwidth=100),
            margin = margin
            )
      }else{
        p <- p %>%
          add_annotations(x = mean(df_series$Distance*1.2,na.rm = TRUE),
                          y = log10(C_goal*1.3),
                          text = paste0("Cleanup Goal (",C_goal," ug/L)"),
                          xref = "x",
                          yref = "y",
                          font=list(size=15, color="black"),
                          showarrow=F)%>%
          add_annotations(x = Ltot,
                          y = log10(mean(df_series$Concentration,na.rm = TRUE)),
                          text = paste0("Point of<br>Compilance"),
                          xref = "x",
                          yref = "y",
                          xanchor = 'right',
                          font=list(size=15, color="purple"),
                          showarrow=T)%>%
          plotly::layout(
            title = title_plotly(paste0("<b>",group_method1," Concentration of COC in Selected Wells Over Distance</b>")),
            #shapes = s,
            xaxis = list(title = "Distance (m)",
                         linecolor = toRGB("black"),
                         linewidth = 2,
                         showline=T,
                         mirror = "ticks",
                         range = ifelse(State=='Projected'|State=='Lab-Based',
                                        c(0,Ltot*1.2),
                                        c(0,max(sen$model$Distance*1.2,df_series$Distance*1.2,Ltot*1.2,rm.na=TRUE))
                         )
            ),
            yaxis = list(title = "log10 [COC Concentration (ug/L)]",
                         range=c(log10(min(df_series$Concentration,na.rm = TRUE))-0.5, 
                                 yend = log10(max(df_series$Concentration,na.rm = TRUE))+1),
                         linecolor = toRGB("black"),
                         linewidth = 2,
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