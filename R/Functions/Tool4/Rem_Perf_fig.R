#################################################################

#%% ----- Function for generating the figure

##------ INPUT
# three inputs are required here 
# df: input database for either df_VOC or df_Benz
# linear_df: input linear function of each OoM in the second sheet
# name: either Chlorinated Solvents or Benzene


Rem_Perf_fig<-function(df,linear_df,name,min_num,max_num,Conc_goal=NULL){
  
  
  if (max_num==10000000){
    label_tx =c('0.1','1','10','100','1,000','10,000','100,000','1,000,000','10,000,000')
  }else{
    label_tx =c('0.001','0.01','0.1','1','10','100','1,000')
  }
  
  
  # count how many technology in the database
  df_count = df%>%group_by(Technology)%>%
    summarise(count = n())%>%
    mutate(label = paste0(Technology,' (n=',as.character(count),')',sep=''))
  
  # put counts next to the list
  df<- df%>%left_join(df_count, by='Technology')
  
  # generate figure
 
  p<- ggplot()+
    geom_point(data = df,aes(x=`Parent Maximum Before, ug/L` ,
                             y=`Parent Maximum After, ug/L`,
                             color = label,
                             group = label),size =5
    )
  if (!is.null(Conc_goal)){
    p<-p+
      geom_hline(yintercept = Conc_goal,linetype = 'dashed',
                 color='#4472C4',size=2)+
      geom_text(aes(min_num,Conc_goal,label = 'MCL', 
                    vjust = -1),
                color = '#4472C4',
                size = 6)
  }
  p <- p+
    geom_line(data =linear_df, 
              aes(x = Before,y = After,group = Label),
              linetype = "dashed",
              size = 1,
              color='grey',
              show.legend = FALSE)+
    # geom_text(data =linear_df%>%filter(row_number() %% 2 == 0),
    #           aes(x = Before,y = After,label = Label),
    #           angle = 45,
    #           hjust = 0,
    #           size = 6)+
    scale_x_continuous(trans='log10',
                       limits = c(min_num,max_num),
                       # tickvals=tval,
                       # ticktext=ttxt,
                       breaks = c(1 %o% 10^(log10(min_num):log10(max_num))),
                       labels = label_tx
    )+
    scale_y_continuous(trans='log10',
                       limits = c(min_num,max_num),
                       breaks = c(1 %o% 10^(log10(min_num):log10(max_num))),
                       labels = label_tx
    )+
    labs(x = "Maximum Concentration Before Treatment (ug/L)", 
         y = 'Maximum Concentration After Treatment (ug/L)', 
         title = paste0("Remediation Performance: ",name,sep=''))+
    theme(legend.title = element_blank(), 
          legend.position = "bottom",# c(0.2,0.85), 
          legend.box = "horizontal",
          legend.text = element_text(color="black", size=12, hjust = 0.5), 
          legend.spacing.y = unit(0, "char"),
          plot.margin = unit(c(1, 1, 1, 1), "lines"),
          axis.text.x = element_text(size=14),
          axis.text.y = element_text(size=14),
          axis.title = element_text(size=16),
          plot.title = element_text(size=18)
          )+
    coord_cartesian(clip="off")
  
  p
  if (max(linear_df$Before)==1000){
    label_df<-linear_df%>%filter(Before==1000)
  }else{
    label_df<-linear_df%>%filter(Before==1000000)
  }
  
  
  
  # convert to plotly
  p2<-ggplotly(p)
  p2<-p2%>%layout(legend = list(orientation = 'h',title ='',y=-0.25),
                  xaxis=list(tickangle=45))%>%
    add_annotations(x = log10(label_df$Before),
                    y = log10(label_df$After),
                    text = label_df$Label,
                    xref = "x",
                    yref = "y",
                    showarrow = TRUE,
                    arrowhead = 4,
                    arrowsize = .5,
                    textangle=-35,
                    #ax = 20,
                    #ay = -40,
                    # Styling annotations' text:
                    font = list(color = 'black',
                                size = 14))
    
  p2
 
  return(p2)
}