#############################################################################

#%% ----- FUNCTION FOR FIGURE GENERATION

#----- INPUT
# data base of average concentration from df_series function
# regression model for each averaged/geomean database from regression_fitness
# check the sliders
logscale_figure <- function(df_series, sen = NULL, bp = NULL){
  
  # create y axis as log
  tval <- sort(as.vector(sapply(seq(1,9), 
                                function(x) 
                                  x*10^seq(floor(log10(min(df_series$Concentration,na.rm=TRUE))),
                                           ceiling(log10(max(df_series$Concentration,na.rm=TRUE))))))) #generates a sequence of numbers in logarithmic divisions
  
  ttxt <- rep(" ",length(tval))  # no label at most of the ticks
  ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
  
  # ----- plot figure of log scale - linear scale
  p <- plot_ly(source = 'ts_selected') %>%
    add_trace(data = df_series,
              x= ~Date,
              y = ~Concentration ,
              name = ' ',
              type = "scatter",
              mode = 'markers',
              marker = marker_plotly(color='rgb(31,150,180)'),
              hovertemplate = paste('<br>Date: %{x}', '<br>Concentration: %{y:.2f} ug/L<br>'))
  
  # Add Breakpoint if available 
  s <- list()
  if(!is.null(bp)){
    s <- c(s, vline_plotly(x = bp))
  }
  
  # Add Regression Lines 
  # For time periods, if bp is available
  if(sum(names(sen) %in% c("Period 1", "Period 2")) == 2 & !is.null(bp)){
    p <- p %>%
      add_lines(x = as.Date(sen[["Period 1"]]$model$Date, '1970-01-01'), y = 10^(fitted(sen[["Period 1"]])),
                line = list(color = 'rgb(31,150,180)'),
                name = "Period 1")
    
    p <- p %>%
      add_lines(x = as.Date(sen[["Period 2"]]$model$Date, '1970-01-01'), y = 10^(fitted(sen[["Period 2"]])),
                line = list(color = 'rgb(31,150,180)'),
                name = "Period 2")
  }else{
    p <- p %>%
      add_lines(x = as.Date(sen[["Entire Record"]]$model$Date, '1970-01-01'), y = 10^(fitted(sen[["Entire Record"]])),
                line = list(color = 'rgb(31,150,180)'),
                name = "Entire Record")
  }

  # format the figure
  p <- p %>%
    layout(
      title = title_plotly("<b>Average Concentration of COC in Selected Wells Over Time</b>"),
      shapes = s,
      xaxis = x_axis_fmt(title = "Year"),
      yaxis = y_axis_fmt(title = "COC Concentration<br>(ug/L)", type = "log",
                         tval = tval, ttxt = ttxt),
      showlegend = FALSE,
      margin = margin)
  
  return(p)
}

##------ OUTPUT
# p: figure with linear regression