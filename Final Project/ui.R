#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Concentration level from dose and time"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("sliderTime", "Time since drug administration (hr)", min=0, max=30, step=0.01, value=0.1),
       selectInput("subject", "select Subject", choices=1:12, multiple=FALSE, selected="1")
         
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot1"),
       h3("Predicted theophylline concentration"),
       textOutput("pred")
    )
  )
))
