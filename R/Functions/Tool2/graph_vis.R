#%% ----- Function for generate graph for linear regression for all wells and downgradient wells

##------ INPUT
# two are required here 
# df__all: input data frame from df_series_tool2a output
# name: string either all or downgradient wells
# log_flag: user need to define whether linear or log axis to plot
# vis_flag: "Concentration" or "Mass" 

graph_vis <-function(df_all, log_flag, vis_flag,unit){
  
  # # --- filter data either all or downgradient well to plot
  # df_all <- df_MW_compiled%>%filter(WellID==name)

 
  # --- treatment of y axis label names
  tval <- sort(as.vector(sapply(seq(1,9), 
                                function(x) 
                                  x*10^seq(ceiling(log10(min(get(vis_flag, df_all),na.rm=TRUE))),
                                           ceiling(log10(max(get(vis_flag, df_all),na.rm=TRUE))))))) #generates a sequence of numbers in logarithmic divisions
  
  ttxt <- rep(" ",length(tval))  # no label at most of the ticks
  ttxt[seq(1,length(tval),9)] <- as.character(tval)[seq(1,length(tval),9)] # every 9th tick is labelled
  
  # -----plot figure of log scale or linear scale

  
  p<-plot_ly()
  
  
  p<-p%>%
    add_trace(data = df_all, x= ~Date,
              y = ~get(vis_flag, df_all),
              color = ~Group,
              name = ~Group,
              type = "scatter", 
              mode = 'markers',
              marker = list(size = 10),#marker_plotly(color='rgb(31,150,180)'),
              hovertemplate = ifelse(vis_flag =='Concentration',
                                     paste('<br>Date: %{x}', '<br>Concentration: %{y:.2f} ',unit,'<br>'),
                                     paste('<br>Date: %{x}', '<br>Dissolved Mass: %{y:.2f} kg<br>'))
    )
  
  # plot layer out for x axis
  p<-p%>%
    layout(
      title = ifelse(vis_flag =='Concentration', "Concentration of COC Over Time",
                     "Mass of COC Over Time"),
      xaxis = list(title="",
                   automargin = T,
                   showline=T,
                   mirror = "ticks",
                   linecolor = toRGB("black"),
                   linewidth = 2,
                   zeroline=F
      ))
      
  if (log_flag =='Log'){
    p<-p%>%
      layout(yaxis = list(title=ifelse(vis_flag=='Concentration',
                                       paste0("COC Concentration at <br> Monitoring Well (",unit,")",sep=''),
                                       "Dissolved Mass (kg)"
                                       ),
                 #automargin = T,
                 type ='log',
                 range = c(floor(log10(min(df_all$Concentration,na.rm=TRUE))),
                           ceiling(log10(max(df_all$Concentration,na.rm=TRUE)))),
                 tickvals=tval,
                 ticktext=ttxt,
                 showline=T,
                 mirror = "ticks",
                 linecolor = toRGB("black"),
                 linewidth = 2,
                 zeroline=F),
    showlegend = T,
    legend = list(orientation = 'h'),
    dragmode = "select", selectdirection = "h"
    )
  }else{
    p<-p%>%
      layout(yaxis = list(title=ifelse(vis_flag=='Concentration',
                                       paste0("COC Concentration at <br> Monitoring Well (",unit,")",sep=''),
                                       "Dissolved Mass (kg)"),
                          
                   #automargin = T,
                   range = c(floor((min(df_all$Concentration,na.rm=TRUE))),
                             ceiling((max(df_all$Concentration,na.rm=TRUE)))),
                   showline=T,
                   mirror = "ticks",
                   linecolor = toRGB("black"),
                   linewidth = 2,
                   zeroline=F),
      showlegend = T,
      legend = list(orientation = 'h'),
      dragmode = "select", selectdirection = "h"
      )
  }
  
  return (p)
}

