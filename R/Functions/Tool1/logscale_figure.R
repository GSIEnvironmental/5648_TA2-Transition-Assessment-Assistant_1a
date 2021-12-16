#############################################################################

#%% ----- FUNCTION FOR FIGURE GENERATION

#----- INPUT
# data base of average concentration from df_series function
# regression model for each averaged/geomean database from regression_fitness
# check the sliders
logscale_figure <- function(df_series,regression_fitness,date_slider1,date_slider2){
  
  # reassign the name of each data frame for all period, first period, and second period
  for (var in 1:length(names(df_series))){
    nam<-names(df_series)[var]
    assign(nam, (df_series[[var]]))
  }
  
  # reassign the name of each fitted regression line for all period, first period, and second period
  for (var in 1:length(names(regression_fitness))){
    nam<-names(regression_fitness)[var]
    assign(nam, (regression_fitness[[var]]))
  }
  
  print (ceiling(log10(max(df_MW$Concentration,na.rm=TRUE))))
  # create y axis as log
  tval <- sort(as.vector(sapply(seq(1,9), 
                                function(x) 
                                  x*10^seq(floor(log10(min(df_MW$Concentration,na.rm=TRUE))),
                                           ceiling(log10(max(df_MW$Concentration,na.rm=TRUE))))))) #generates a sequence of numbers in logarithmic divisions
  
  ttxt <- rep(" ",length(tval))  # no label at most of the ticks
  ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
  
  # -----generate the label for regression lines
  x_name = c(mean(df_1$Date)+365,mean(df_2$Date)+365)
  y_name = c(as.numeric(mean(fit1$fitted.values)),
             as.numeric(mean(fit2$fitted.values)))
  fit1_label = paste('y = ',
                      format(as.numeric(fit1$coefficients[2]),scientific=TRUE,digits=3),
                      'x',
                      ifelse(as.numeric(fit1$coefficients[1])>0,'+',''),
                      format(as.numeric(fit1$coefficients[1]),scientific=TRUE,digits=3),
                      '\n r-squared=',format(summary(fit1)$r.squared,digit=3),
                      sep='')
  fit2_label = paste('y = ',
                     format(as.numeric(fit2$coefficients[2]),scientific=TRUE,digits=3),
                     'x',
                     ifelse(as.numeric(fit2$coefficients[1])>0,'+',''),
                     format(as.numeric(fit2$coefficients[1]),scientific=TRUE,digits=3),
                     '\n r-squared=',format(summary(fit2)$r.squared,digit=3),
                     sep='')
  label_name = c(fit1_label,fit2_label)
  
  # -----plot figure of log scale - linear scale
  p<-plot_ly()
  
  
  p<-p%>%
    add_trace(data = df_1, x= ~Date,
              y = ~Concentration ,
              name = ' ',
              type = "scatter", 
              mode = 'markers',marker = list(color='rgb(31,150,180)'),
              hovertemplate = paste('<br>Date: %{x}', '<br>Concentration: %{y:.2f} ug/L<br>')
    )%>%add_lines( x= ~fit1$model$Date, y = 10^(fitted(fit1)),line=list(color='rgb(31,150,180)'))
  
  # generate linear regression line for the second period  
  if (missing(date_slider2)){
    print ('missing')
  }else{
    
    
    p<-p%>%
      add_trace(data = df_2, x= ~Date,
                y = ~Concentration ,
                name = ' ',
                type = "scatter", 
                mode = 'markers',marker = list(color='rgb(255,0,0)'),
                hovertemplate = paste('<br>Date: %{x}', '<br>Concentration: %{y:.2f} ug/L<br>')
      )%>%add_lines( x= ~fit2$model$Date, y = 10^(fitted(fit2)))
    
  }
  
  # format the figure
  p<-p%>%
    layout(
      xaxis = list(title="Year",
                   automargin = T,
                   showline=T,
                   mirror = "ticks",
                   linecolor = toRGB("black"),
                   linewidth = 2,
                   #range = c(input$Year_now, input$Year_now+as.numeric(results_list[6])),
                   zeroline=F
      ),
      yaxis = list(title="COC Concentration at <br> Monitoring Well (ug/L)",
                   #automargin = T,
                   type ='log',
                   range = c(floor(log10(min(df_MW$Concentration,na.rm=TRUE))),
                             ceiling(log10(max(df_MW$Concentration,na.rm=TRUE)))),
                   tickvals=tval,
                   ticktext=ttxt,
                   showline=T,
                   mirror = "ticks",
                   linecolor = toRGB("black"),
                   linewidth = 2,
                   zeroline=F),
      showlegend = FALSE,

      dragmode = "select", selectdirection = "h"
    )%>%
    add_annotations(x = x_name, 
                    y = y_name, 
                    text = label_name, 
                    xref = "x",
                    yref = "y",
                    showarrow = FALSE
                    )
  
  return(p)
}

##------ OUTPUT
# p: figure with linear regression