checksilenterror<-function(A){tryCatch({
  A
  print("good")
},
shiny.silent.error = function(e) {
  print("error")
})}
