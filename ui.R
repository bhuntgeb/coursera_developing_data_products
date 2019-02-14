#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Linear regression of mpg with the mtcars dataset"),
  p("by Bastian Huntgeburth, 14.2.2019"),
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
            h2("Get started!"),
            p("This application performs a simple linear regression on the 'mtcars' dataset that comes with r-studio. ",
            span("The linear regression uses the 'wt' (weight) and the 'cyl' (cylinder) features to build a model to predict mpg. "),
            span("With the help of the sliders you can subset the 'mtcars' dataset, while setting the min and max of the used features"),
            span("Every time you change the position of the slider, the linear model will be updated. "),
            span("On the right site you can see a plot of mpg vs. the wt feature. The blue line is the fittet line of the linear model. "),
            span("The red lines represent the min/max values set by the slider. "),
            span("On the second tab you can see a plot of mpg vs. the cyl feature."),
            span("Above the plots you can see the coefficients of the model and the R-squared value. ")),
            sliderInput("sliderWt", "Pick Minimum and Maximum of weight", 1, 6, value = c(1, 6), step = 0.1),
            sliderInput("sliderCyl", "Pick Minimum and Maximum of cylinders", 3, 9, value = c(3, 9), step = 0.1)

    ),
    
    # Show a plot 
    mainPanel(
            h3("Regression coefficients"),
            p("Intercept: ",textOutput("intOutWt", inline = TRUE)),
            p("Slope of 'wt' coefficent:",textOutput("slopeOutWt", inline = TRUE)),
            p("Slope of 'cyl' coefficent:",textOutput("slopeOutCyl", inline = TRUE)),
            p("R-squared: ",textOutput("rsquared", inline = TRUE)),
            p(" ", textOutput("error", inline = TRUE),style = "color:red"),
            
            tabsetPanel(type = "tabs",
                tabPanel("MPG vs. Wt", br(),"(blue=4 cyl, pink=6 cyl, grey=8 cyl)" , plotOutput("plot1")),
                tabPanel("MPG vs. Cyl", br(), plotOutput("plot2"))
            )
      )
    )
))
