# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(mlbench)

shinyServer(function(input, output) {
  BH <- BostonHousing
  BH$dissp <- ifelse(BH$dis - 7.5 > 0, BH$dis - 7.5, 0)
  model1 <- lm(medv ~ dis, data = BH)
  model2 <- lm(medv ~ dissp + dis, data = BH)
  model1pred <- reactive({
    disInput <- input$`Slider Distance`
    predict(model1, newdata = data.frame(dis = disInput))
  })
  model2pred <- reactive({
    disInput <- input$`Slider Distance`
    predict(model2, newdata = data.frame(dis = disInput, dissp = ifelse(disInput - 7.5 > 0, disInput - 7.5,0)))
  })
  output$plot2 <- renderPlot({
    disInput <- input$`Slider Distance`
    plot(BH$dis, BH$medv, xlab = "Weighted Distances to Boston Main Centers", ylab = "Median Value of a Property", bty = "n",
         pch = 16, xlim = c(0, 15), ylim = c(0, 50))
    if(input$showModel1){abline(model1, col = "purple", lwd = 2)}
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(dis = 0:15, dissp = ifelse(0:15 - 7.5 > 0,
                                                                                     0:15 - 7.5, 0)))
      lines(0:15, model2lines, col = "green", lwd =2)
    }
    legend(10, 50, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, col = c("purple", "green"),
           bty = "n", cex = 1.2)
    points(disInput, model1pred(), col = "purple", pch = 16, cex = 2)
    points(disInput, model2pred(), col = "green", pch = 16, cex = 2)
    
  })
  output$pred1 <- renderText({
    model1pred()
  })
  output$pred2 <- renderText({
    model2pred()
  })
  
})
