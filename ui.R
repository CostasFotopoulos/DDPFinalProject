library(shiny)

# Define UI for application
shinyUI(fluidPage(
  
  # Application and window title
  titlePanel("Prediction of Flower Species", windowTitle = "Prediction of Flower Species"),
  

  sidebarLayout(
    sidebarPanel(
      sliderInput("Selal.Length.In", "Length of sepal", min = 4.3, max = 7.9, value = 5.9),
      sliderInput("Sepal.Width.In", "Width of sepal", min = 2, max = 4.4, value = 3.1),
      sliderInput("Petal.Length.In", "Length of petal", min = 1, max = 6.9, value = 3.8),
      sliderInput("Petal.Width.In", "Width of petal", min = 1, max = 2.5, value = 1.7),
      submitButton("Submit")
    ),
    
    # Show plots
    mainPanel(
      h5("Please change the values of the sepals and petals on the left panel and click the <Submit> Button. 
          The charts and the prediction results will be updated. The set of values being predicted is marked 
          on the charts with a red dot and named \"unknown\"."),
      plotOutput('newPlot'),
      h2('Prediction Outcome:'),
      h2(textOutput('pred'))
  )
  )
))
