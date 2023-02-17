# gt utiliy functions

style_body <- function(align = "center"){
  list(
    cell_borders(sides = "all",
                 style = "solid",
                 weight = px(2),
                 color = "#D3D3D3"),
    cell_text(align = align,
              v_align = "middle"))
}

style_col_labels <- function(){
  list(
    cell_text(align = "center",
              v_align = "middle",
              weight = "bold"))
}

style_body_tool10 <- function(align = "left"){
  list(
    cell_borders(sides = "bottom",
                 style = "solid",
                 weight = px(2),
                 color = "#D3D3D3"),
    cell_text(align = align,
              v_align = "middle"))
}

style_body_tool10_middle <-function(align = "center"){
  list(
    cell_borders(sides = "bottom",
                 style = "solid",
                 weight = px(2),
                 color = "#D3D3D3"),
    cell_text(align = align,
              v_align = "middle"))
}

rank_chg <- function(collist,dummy1,dummy2,dummy3,dummy4,dummy5,dummy6){
  logo_outlist<-list()
  count = 0 
  countlist = 1
  for (change_dir in collist[1:6]){
    if (change_dir %in% c(dummy1,dummy2,dummy3,dummy4,dummy5)){
      logo_out <-
        gt::html(paste0('<a style="','font-weight: bold;color:red">',change_dir,"</a>"))
      count = count +1
    }else if (change_dir == dummy6){
      logo_out <- fontawesome::fa("check", fill = "red")
      logo_out %>% 
        as.character() %>% 
        gt::html()
      count = count +1
    }else{
      logo_out<-change_dir
      logo_out %>% 
        as.character() %>% 
        gt::html()
      count = count +0
    }
    
    
    logo_out = if (dummy1=='NA'&countlist==1){
      gt::html(paste0('<a style="','color:black">','NA',"</a>"))
      }else{
      logo_out}
    logo_out = if (dummy2=='NA'&countlist==2){
      gt::html(paste0('<a style="','color:black">','NA',"</a>"))
      }else{
      logo_out
    }
    logo_out = if (dummy3=='NA'&countlist==3){
      gt::html(paste0('<a style="','color:black">','NA',"</a>"))
      }else{
      logo_out
    }
    logo_out = if(dummy4=='NA'&countlist==4){
      gt::html(paste0('<a style="','color:black">','NA',"</a>"))
      }else{
      logo_out
    }
    logo_out = if (dummy5=='NA'&countlist==5){
      gt::html(paste0('<a style="','color:black">','NA',"</a>"))
      }else{
      logo_out
    }
    logo_out = if(dummy6=='NA'&countlist==6){
      gt::html(paste0('<a style="','color:black">','NA',"</a>"))
      }else{
      logo_out
    }
      
    
    logo_outlist<- append(logo_outlist,HTML(logo_out))
    countlist = countlist+1
  }
  logo_outlist<- append(logo_outlist,HTML(gt::html(paste0('<a style="','font-weight: bold">',count,"</a>"))))
  return(logo_outlist)
}  

