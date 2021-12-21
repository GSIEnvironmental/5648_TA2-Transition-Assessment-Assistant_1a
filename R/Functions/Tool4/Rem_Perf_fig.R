#################################################################

#%% ----- Function for generating the figure

##------ INPUT
# three inputs are required here 
# df: input database for either df_VOC or df_Benz
# linear_df: input linear function of each OoM in the second sheet
# name: either Chlorinated Solvents or Benzene


Rem_Perf_fig<-function(df,linear_df,name,max_num){
  
  if (max_num==1000000){
    label_tx =c('0.001','0.01','0.1','1','10','100','1,000','10,000','100,000','1,000,000')
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
                             group = label)
    )+
    geom_line(data =linear_df, 
              aes(x = Before,y = After,group = Label),
              linetype = "dashed",
              size = 1,
              color='grey',
              show.legend = FALSE)+
    geom_text(data =linear_df%>%filter(After>=10),
              aes(x = Before,y = After,label = Label), 
              angle = 45,
              hjust = 0,
              size = 4)+
    scale_x_continuous(trans='log10',
                       limits = c(0.001,max_num),
                       # tickvals=tval,
                       # ticktext=ttxt,
                       breaks = c(1 %o% 10^(-3:log10(max_num))),
                       labels = label_tx
    )+
    scale_y_continuous(trans='log10',
                       limits = c(0.001,max_num),
                       breaks = c(1 %o% 10^(-3:log10(max_num))),
                       labels = label_tx
    )+
    labs(x = "Maximum Concentration Before Treatment (ug/L)", 
         y = 'Maximum Concentration After Treatment (ug/L)', 
         title = paste0("Remediation Performance: ",name,sep=''))+
    theme(legend.title = element_blank(), 
          legend.position = c(0.2,0.8), 
          legend.box = "horizontal",
          legend.text = element_text(color="black", size=10, hjust = 0.5), 
          legend.spacing.y = unit(0, "char"),
          plot.margin = unit(c(1, 8, 1, 1), "lines"))+
    coord_cartesian(clip="off")
  p
  # convert to plotly
  #p<-ggplotly(p)

  return(p)
}