Helpboxfunction<-function(X,Y,w,h){
  
  nargin <- length(as.list(match.call())) -1
  
  if (nargin==1){
    Y = '"./03_CleanupGoals/'
  }else{
    Y = Y
  }
  if (X=='10_Halflifev2.png'){
    filename = paste0('<p align="center">',
                      '<img src=',
                      #'"./03_CleanupGoals/',
                      Y,
                      X,
                      '" ',
                      'width="845" height="1317">',
                      '</p>',
                      sep='')
  }else{
    filename = paste0('<p align="center">',
                      '<img src=',
                      #'"./03_CleanupGoals/',
                      Y,
                      X,
                      '" ',
                      'width="845" height="1125">',
                      '</p>',
                      sep='')

  }
  
  if (nargin==4){
    filename = paste0('<p align="center">',
                      '<img src=',
                      #'"./03_CleanupGoals/',
                      Y,
                      X,
                      '" ',
                      'width="',
                      w,
                      '" height="',
                      h,
                      '">',
                      '</p>',
                      sep='')
  }
  
  showModal(modalDialog(
    title = "Help Box",
    size = 'l',
    HTML(filename),
    easyClose = TRUE,
    footer = NULL
  ))
}