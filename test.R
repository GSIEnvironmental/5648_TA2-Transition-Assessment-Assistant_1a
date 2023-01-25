library(shiny)
library(rhandsontable)
library(data.table)
shinyUI <- fluidPage(
  rHandsontableOutput("tabled")
)

library(shiny)
library(rhandsontable)
fd<-data.table(iris[1:5,])
fd$checkbox<-rep(F,nrow(fd))
print(fd)
shinyServer<- function(input, output) {
  
  output$tabled<-renderRHandsontable({rhandsontable(fd)})
  
}


shinyApp(ui = shinyUI, server = shinyServer)
