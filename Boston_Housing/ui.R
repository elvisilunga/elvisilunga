# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(mlbench)

# Define UI for application that predict housing values in Boston suburbs
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Housing Values in Boston Suburbs"),
  
  # Sidebar with a slider input for the distances to main Boston centers
  sidebarLayout(
    sidebarPanel(
      sliderInput("Slider Distance", "How far are Boston Main Centers?", 1,15, value=7),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("SUBMIT")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot2"),
      h3("Predict Housing Values in Boston from Model 1: "),
      textOutput("pred1"),
      h3("Predict Housing Values in Boston from Model 2: "),
      textOutput("pred2")
    )
  )
))
