# Plotly Utility Functions 

margin <- list(b = 10, l = 10, t = 50, r = 100)

marker_plotly <- function(color){
  list(
    color = color,
    size = 10
  )
}

vline_plotly <- function(x = 0, color = "grey", line_type = "dot") {
  list(
    type = "line",
    y0 = 0,
    y1 = 1,
    yref = "paper",
    x0 = x,
    x1 = x,
    line = list(color = color, dash = line_type)
  )
}

hline_plotly <- function(y = 0, color = "grey", line_type = "solid") {
  list(
    type = "line",
    y0 = y,
    y1 = y,
    xref = "paper",
    x0 = 0,
    x1 = 1,
    line = list(color = color, dash = line_type)
  )
}

annotation_plotly <- function(label, x, y, xshift = 25, yshift = -60, angle = 0, log = F){
list(
    x = x,
    y = ifelse(log == T, log(y), y),
    text = label,
    xref = "x",
    yref = "y",
    xshift = xshift,
    yshift = yshift,
    textangle = angle,
    showarrow = F
  )
}

title_plotly <- function(text){
  list(
    text = text,
    x = 0,
    font = list(size = 20)
  )
}

x_axis_fmt <- function(title){
  list(title = title,
       automargin = T,
       showline = T,
       mirror = "ticks",
       linecolor = toRGB("black"),
       linewidth = 2,
       zeroline = F)
}

y_axis_fmt <- function(title, tval, ttxt, type = "linear"){
  list(title = title,
       type = type,
       tickvals = tval,
       ticktext = ttxt,
       showline = T,
       mirror = "ticks",
       linecolor = toRGB("black"),
       linewidth = 2,
       zeroline = F)
}
