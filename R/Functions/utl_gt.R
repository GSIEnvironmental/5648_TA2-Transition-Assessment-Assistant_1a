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
