#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(dplyr)

shinyServer(function(input, output, session) {
   
        model<-reactive({
                cylMin<-input$sliderCyl[1]
                cylMax<-input$sliderCyl[2]
                wtMin<-input$sliderWt[1]
                wtMax<-input$sliderWt[2]
                
                subCyl<-mtcars[(mtcars$cyl< cylMax)& (mtcars$cyl> cylMin),]
                subWt<-mtcars[(mtcars$wt< wtMax)& (mtcars$wt> wtMin),]
                subData<-intersect(subCyl, subWt)
                
                if(nrow(subData) < 2 ){
                        return(NULL)
                }
                
                fit<-lm(mpg ~ wt + cyl, data = subData)
                fit
        })

        
output$intOutWt <- renderText({
        if(is.null(model())){"xxx"} 
        else {model()[[1]][1]}
})
        
output$slopeOutWt <- renderText({
        if(is.null(model())){"xxx"} 
        else {model()[[1]][2]}
})
        
output$slopeOutCyl <- renderText({
        if(is.null(model())){"xxx"} 
        else {model()[[1]][3]}
})
        
output$rsquared <- renderText({
        if(is.null(model())){"xxx"} 
        else {summary(model())$r.squared}
})
        
output$error <- renderText({
        if(is.null(model())){
                "No observations left for model building."
        } else {
                
        }
})     
  
  output$plot1 <- renderPlot({
          plot(mtcars$wt, mtcars$mpg, xlab = "wt", ylab = "mpg", main = "mtcars", xlim = c(1,6), cex = 1.5, pch = 16, bty = "n", col=mtcars$cyl)
          
          if(!is.null(model())){
                  if(!is.na(model()[[1]][1])) {
                        modelInt<-model()[[1]][1]
                          
                        if(!is.na(model()[[1]][2])) {
                                modelSlopeWt<-model()[[1]][2]
                                }else{ modelSlopeWt<-0 }
                                  
                                  if(!is.na(model()[[1]][3])) {
                                        modelSlopeCyl<-model()[[1]][3]
                                        }else{ modelSlopeCyl<-0 }
                          
                                        abline(a=model()[[1]][1]+ (mean(mtcars[(mtcars$cyl<= input$sliderCyl[2])& (mtcars$cyl>= input$sliderCyl[1]),]$cyl)*modelSlopeCyl), b= modelSlopeWt, col = "blue", lwd = 2)                 
                 }   
          }      
          abline(v=input$sliderWt[2], col ="red")
          abline(v=input$sliderWt[1], col ="red")

  })
  
  output$plot2 <- renderPlot({
          plot(mtcars$cyl, mtcars$mpg, xlab = "cyl", ylab = "mpg", main = "mtcars", xlim = c(3,9),cex = 1.5, pch = 16, bty = "n")
          
          if(!is.null(model())){
                  if(!is.na(model()[[1]][1])) {
                          modelInt<-model()[[1]][1]
                          
                                if(!is.na(model()[[1]][2])) {
                                modelSlopeWt<-model()[[1]][2]
                                }else{modelSlopeWt<-0 }
                          
                                if(!is.na(model()[[1]][3])) {
                                modelSlopeCyl<-model()[[1]][3]
                                }else{modelSlopeCyl<-0 }
                                
                                abline(a=model()[[1]][1] + (mean(mtcars[(mtcars$wt<= input$sliderWt[2])& (mtcars$wt>= input$sliderWt[1]),]$wt)*modelSlopeWt), b= modelSlopeCyl, col = "blue", lwd = 2)                  

                }   
          }
          abline(v=input$sliderCyl[2], col ="red")
          abline(v=input$sliderCyl[1], col ="red")
  })
 
})


