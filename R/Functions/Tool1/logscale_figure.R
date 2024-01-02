#############################################################################

#%% ----- FUNCTION FOR FIGURE GENERATION

#----- INPUT
# data base of average concentration from df_series function
# regression model for each averaged/geomean database from regression_fitness
# check the sliders
logscale_figure <- function(df_series, name,sen = NULL, bp = NULL,fit,CI,unit){
  
  
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
              hovertemplate = paste('<br>Date: %{x}', '<br>Concentration: %{y:.2f} ',unit,'<br>'))
  
  # Add Breakpoint if available 
  s <- list()
  if(!is.null(bp)){
    s <- c(s, vline_plotly(x = bp))
  }
  
  # Add Regression Lines 
  # For time periods, if bp is available
  if(sum(names(sen) %in% c("Period 1", "Period 2")) == 2 & !is.null(bp)){
    est_period1 = calculate_CI(fit$`Period 1`,CI)
    est_period2 = calculate_CI(fit$`Period 2`,CI)
    p <- p %>%
      add_lines(x = as.Date(sen[["Period 1"]]$model$Date, '1970-01-01'), y = 10^(fitted(sen[["Period 1"]])),
                line = list(color = 'rgb(31,150,180)'),
                name = "Period 1")%>%
      add_lines(x = as.Date(sen[["Period 1"]]$model$Date, '1970-01-01'),
                y = 10^(fitted(sen[["Period 1"]])[1]+
                           (sen[["Period 1"]]$model$Date-sen[["Period 1"]]$model$Date[1])*
                          est_period1["UCL"]),
                line = list(color = 'rgb(31,150,180)', widthh=0.5, dash="dot"),
                name = paste0(as.character(CI*100),"% CI",sep=''))#%>%
      # add_lines(x = as.Date(sen[["Period 1"]]$model$Date, '1970-01-01'), 
      #           y = 10^(fitted(sen[["Period 1"]])[1]+
      #                     (sen[["Period 1"]]$model$Date-sen[["Period 1"]]$model$Date[1])*
      #                     est_period1["LCL"]),
      #           line = list(color = 'rgb(31,150,180)', widthh=0.5, dash="dot"),
      #           name = paste0(as.character(100-CI*100),"% CI",sep=''))
    
    p <- p %>%
      add_lines(x = as.Date(sen[["Period 2"]]$model$Date, '1970-01-01'), y = 10^(fitted(sen[["Period 2"]])),
                line = list(color = 'rgb(31,150,180)'),
                name = "Period 2")%>%
      add_lines(x = as.Date(sen[["Period 2"]]$model$Date, '1970-01-01'),
                y = 10^(fitted(sen[["Period 2"]])[1]+
                          (sen[["Period 2"]]$model$Date-sen[["Period 2"]]$model$Date[1])*
                          est_period2["UCL"]),
                line = list(color = 'rgb(31,150,180)', widthh=0.5, dash="dot"),
                name = paste0(as.character(CI*100),"% CI",sep=''))#%>%
      # add_lines(x = as.Date(sen[["Period 2"]]$model$Date, '1970-01-01'), 
      #           y = 10^(fitted(sen[["Period 2"]])[1]+
      #                     (sen[["Period 2"]]$model$Date-sen[["Period 2"]]$model$Date[1])*
      #                     est_period2["LCL"]),
      #           line = list(color = 'rgb(31,150,180)', widthh=0.5, dash="dot"),
      #           name = paste0(as.character(100-CI*100),"% CI",sep=''))
  }else{
    est = calculate_CI(fit$`Entire Record`,0.95)
    p <- p %>%
      add_lines(x = as.Date(sen[["Entire Record"]]$model$Date, '1970-01-01'), y = 10^(fitted(sen[["Entire Record"]])),
                line = list(color = 'rgb(31,150,180)'),
                name = "Entire Record")%>%
      add_lines(x = as.Date(sen[["Entire Record"]]$model$Date, '1970-01-01'),
                y = 10^(fitted(sen[["Entire Record"]])[1]+
                          (sen[["Entire Record"]]$model$Date-sen[["Entire Record"]]$model$Date[1])*
                          est["UCL"]),
                line = list(color = 'rgb(31,150,180)', widthh=0.5, dash="dot"),
                name = paste0(as.character(CI*100),"% CI",sep=''))#%>%
      # add_lines(x = as.Date(sen[["Entire Record"]]$model$Date, '1970-01-01'), 
      #           y = 10^(fitted(sen[["Entire Record"]])[1]+
      #                     (sen[["Entire Record"]]$model$Date-sen[["Entire Record"]]$model$Date[1])*
      #                     est["LCL"]),
      #           line = list(color = 'rgb(31,150,180)', widthh=0.5, dash="dot"),
      #           name = paste0(as.character(100-CI*100),"% CI",sep=''))
  }

  # format the figure
  p <- p %>%
    plotly::layout(
      title = title_plotly(paste0("<b>",name," Concentration of COC in Selected Wells Over Time</b>")),
      shapes = s,
      xaxis = x_axis_fmt(title = "Year"),
      yaxis = y_axis_fmt(title = paste0("COC Concentration<br>(",unit,")",sep=''), type = "log",
                         tval = tval, ttxt = ttxt),
      showlegend = FALSE,
      margin = margin)
  
  return(p)
}

##------ OUTPUT
# p: figure with linear regression