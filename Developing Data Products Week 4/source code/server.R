library(shiny)
library(ggplot2)
library(caret)


library(datasets)

#
# Setting up for Random Forest predictor.
#

# Initializing data. 'mtcars' dataset is used. 
data("mtcars")
mtcars1 <- mtcars

mtcars1$cyl <- factor(mtcars1$cyl)
mtcars1$vs <- factor(mtcars1$vs)
mtcars1$am <- factor(mtcars1$am)
mtcars1$gear <- factor(mtcars1$gear)
mtcars1$carb <- factor(mtcars1$carb)
#
# Defines the Linear regression model and predictor for 'mpg' in the 'mtcars' dataset.
#
#source(file = "modelBuilding.R")

#
# Setting up Shiny Server
#

g1 <- ggplot(data=mtcars1,aes(x=cyl,y=mpg))
g2 <- ggplot(data=mtcars1,aes(x=hp,y=mpg))
g3 <- ggplot(data=mtcars1,aes(x=wt,y=mpg))
g4 <- ggplot(data=mtcars1,aes(x=am,y=mpg))
g5 <- ggplot(data=mtcars1,aes(x=vs,y=mpg))
g6 <- ggplot(data=mtcars1,aes(x=carb,y=mpg))
g1 <- g1 + geom_boxplot() + labs(title="MPG vs. CYL",x="# Cylinders",y="Miles per gallon") + theme(plot.title = element_text(hjust = 0.5))
g2 <- g2 + geom_point() + labs(title="MPG vs. HP",x="Horse Power",y="Miles per gallon") + theme(plot.title = element_text(hjust = 0.5)) + geom_smooth(method = "lm")
g3 <- g3 + geom_point() + labs(title="MPG vs. Weight",x="Weight",y="Miles per gallon") + theme(plot.title = element_text(hjust = 0.5)) + geom_smooth(method = "lm")
g4 <- g4 + geom_boxplot() + labs(title="MPG vs. Transmission",x="Transmission Type",y="Miles per gallon") + theme(plot.title = element_text(hjust = 0.5))+scale_x_discrete(labels=c("0"="Automatic","1"="Manual"))
g5 <- g5 + geom_boxplot() + labs(title="MPG vs. Engine Type",x="Engine Type",y="Miles per gallon") + theme(plot.title = element_text(hjust = 0.5))+scale_x_discrete(labels=c("0"="V-Shape","1"="In-Line"))
g6 <- g6 + geom_boxplot() + labs(title="MPG vs. # Carburetors",x="# Carburetors",y="Miles per gallon") + theme(plot.title = element_text(hjust = 0.5))
grid_arrange <- grid.arrange(g1,g2,g3,g4,g5,g6,nrow=3,ncol=2)

shinyServer(
  
  function(input, output) {
    predict_model <- lm(mpg ~ cyl+hp+wt+vs+am+carb,data=mtcars1)
    
    # Builds "reactively" the prediction.
    predictMpg <- reactive({
      
      carToPredict <- data.frame(
        cyl = input$cyl, 
        hp = input$hp, 
        wt = input$wt, 
        vs = as.factor(input$vs), 
        am = as.factor(input$am), 
        carb = input$carb)
      
      predict(predict_model,newdata=carToPredict)
    })
    
    output$prediction <- renderText({
      predictMpg()
    })
    
    output$plot <- renderPlot({
      p <- grid.arrange(g1,g2,g3,g4,g5,g6,nrow=3,ncol=2,widths=c(3.5,3.5),heights=c(50,50,50))
      print(p)      
      
    }) 
    
  }
  
)