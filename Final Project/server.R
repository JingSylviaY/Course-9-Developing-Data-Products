#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
 
    data1<-reactive({subset(Theoph, Subject==input$subject)
    })
    
    model1<-reactive({
    nls(conc~SSfol(Dose, Time, lke,ika, lCl), data=data1())
  })  
    
  modelpred<-reactive({
    
    timeInput<-input$sliderTime
    
    predict(model1(), newdata=data.frame(Time=timeInput))
  })
  
  output$Plot1 <- renderPlot({
    
    plot(conc ~ Time, data = data1(),
         xlab = "Time since drug administration (hr)",
         ylab = "Theophylline concentration (mg/L)",
         main = "Observed concentrations and fitted model",
         sub  = "Theophylline data",
         las = 1, col = 4)
    
    xvals <- seq(0, par("usr")[2], length.out = 55)
    lines(xvals, predict(model1(), newdata = list(Time = xvals)),
          col = 4)
    
  })
  output$pred<-renderText({
    modelpred()
  })
  
})
 
