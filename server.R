
library(shiny)
library(caret)
library(randomForest)
library(ggplot2)
library(lattice)
library(Rmisc)
library(plyr)
library(e1071)

data("iris")

# Define server logic
shinyServer(function(input, output) {
  modFit <- train(Species ~ ., method = 'rf', data = iris)
  p1<-ggplot(data=iris,aes(x=Sepal.Length,y=Sepal.Width))
  p1<-p1+geom_point(aes(colour=Species),size=1.5)
  p2<-ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Width))
  p2<-p2+geom_point(aes(colour=Species),size=1.5)
  p3<-ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length))
  p3<-p3+geom_point(aes(colour=Species),size=1.5)
  p4<-ggplot(data=iris,aes(x=Sepal.Width,y=Petal.Width))
  p4<-p4+geom_point(aes(colour=Species),size=1.5)
  p5<-ggplot(data=iris,aes(x=Sepal.Width,y=Petal.Length))
  p5<-p5+geom_point(aes(colour=Species),size=1.5)
  p6<-ggplot(data=iris,aes(x=Petal.Length,y=Petal.Width))
  p6<-p6+geom_point(aes(colour=Species),size=1.5)
  modPredict <- reactive({
    predict(modFit, newdata = data.frame(
      Sepal.Length = input$Selal.Length.In,
      Sepal.Width = input$Sepal.Width.In,
      Petal.Length = input$Petal.Length.In,
      Petal.Width = input$Petal.Width.In
    ))
  })
  test_df<-reactive(data.frame(Sepal.Length=input$Selal.Length.In,
                               Sepal.Width=input$Sepal.Width.In,
                               Petal.Length=input$Petal.Length.In,
                               Petal.Width=input$Petal.Width.In,
                               Species=as.factor("unknown")))
  output$newPlot <- renderPlot({
    p1_1<-p1+geom_point(data=test_df(), aes(x=Sepal.Length,y=Sepal.Width, color='unknown'),size=3)
    p1_1<-p1_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
    
    p2_1<-p2+geom_point(data=test_df(), aes(x=Sepal.Length,y=Petal.Width, color='unknown'),size=3)
    p2_1<-p2_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
    
    p3_1<-p3+geom_point(data=test_df(), aes(x=Sepal.Length,y=Petal.Length, color='unknown'),size=3)
    p3_1<-p3_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
    
    p4_1<-p4+geom_point(data=test_df(), aes(x=Sepal.Width,y=Petal.Width, color='unknown'),size=3)
    p4_1<-p4_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
    
    p5_1<-p5+geom_point(data=test_df(), aes(x=Sepal.Width,y=Petal.Length, color='unknown'),size=3)
    p5_1<-p5_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
    
    p6_1<-p6+geom_point(data=test_df(), aes(x=Petal.Length,y=Petal.Width, color='unknown'),size=3)
    p6_1<-p6_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
    multiplot(p1_1,p2_1,p3_1,p4_1,p5_1,p6_1,cols=2)  
  })
  output$pred <- renderText({as.character(modPredict())})
})
