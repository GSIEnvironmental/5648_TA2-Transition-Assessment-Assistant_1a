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
  for (change_dir in collist){
    if (change_dir %in% c(dummy1,dummy2,dummy3,dummy4,dummy5)){
      logo_out <-
        gt::html(paste0('<a style="','font-weight: bold;color:red ">',change_dir,"</a>"))
    }else if (change_dir == dummy6){
      logo_out <- fontawesome::fa("check", fill = "red")
      logo_out %>% 
        as.character() %>% 
        gt::html()
    }else{
      logo_out<-change_dir
      logo_out %>% 
        as.character() %>% 
        gt::html()
    }
    logo_outlist<- append(logo_outlist,HTML(logo_out))
  }
  return(logo_outlist)
}  
