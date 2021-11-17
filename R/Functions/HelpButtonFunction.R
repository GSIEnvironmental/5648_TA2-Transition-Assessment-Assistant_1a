Helpboxfunction<-function(X){
  filename = paste0('<p align="center">',
                    '<img src=',
                    '"./03_CleanupGoals/',
                    X,
                    '" ',
                    'width="845" height="1125">',
                    '</p>',
                    sep='')
  showModal(modalDialog(
  title = "Help Box",
  size = 'l',
  HTML(filename),
  easyClose = TRUE,
  footer = NULL
  ))
}