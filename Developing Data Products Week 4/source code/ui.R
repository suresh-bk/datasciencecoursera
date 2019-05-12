library(shiny)
library(ggplot2)
library(datasets)
library(grid)
library(gridExtra)

library(shinyBS) 

library(shinythemes)

# 'mtcars' dataset, user for setting up limits in UI widgets.
mtcars1 <- mtcars

minCylinders = min(mtcars1$cyl)
maxCylinders = max(mtcars1$cyl)

minHp = min(mtcars1$hp)
maxHp = max(mtcars1$hp)

minWt = min(mtcars1$wt)
maxWt = max(mtcars1$wt)

minCarb = min(mtcars1$carb)
maxCarb = max(mtcars1$carb)

# Default hypothetical car, in order to initialize th UI widgets.
defaultCar <- data.frame(
  cyl = 4, 
  hp = 70, 
  wt = 1.8, 
  vs = 1, 
  am = 1, 
  carb = 2)

shinyUI(
  
  navbarPage(
    
    "MPG Prediction",
    
    theme = shinytheme("cerulean"),
    
    tabPanel(
      
      "Prediction",
      
      sidebarPanel(
        
        h3("Choose the values for parameters and click Go button to predict"),
        
        #width = 4,
        
        selectInput("cyl","# Cylinders",choices = list(4,6,8),selected = defaultCar$cyl),
        bsTooltip(id = "cyl", title = "Number of cylinders in the engine", placement = "right", options = list(container = "body")),

        sliderInput("hp", "Power in HP", min = minHp, max = maxHp, value = defaultCar$hp, step = 1),
        bsTooltip(id = "hp", title = "Engine's horsepower in HP", placement = "right", options = list(container = "body")),
        
        sliderInput("wt", "Weight", min = minWt, max = maxWt, value = defaultCar$wt, step = 1),
        bsTooltip(id = "wt", title = "Weight of the engine in 1000 lbs", placement = "right", options = list(container = "body")),
        
        radioButtons("vs", label = "Engine type", choices = list("V-Shape" = 0, "In-line" = 1), selected = defaultCar$vs, inline = FALSE),
        bsTooltip(id = "vs", title = "Engine cylinder type (V-shape or inline)", placement = "right", options = list(container = "body")),
        
        radioButtons("am", label = "Transmission", choices = list("Automatic" = 0, "Manual" = 1), selected = 1, inline = TRUE),
        bsTooltip(id = "am", title = "Transmission type (automatic or manual)", placement = "right", options = list(container = "body")),
        
        selectInput("carb","# Carburetors",choices = list(1,2,3,4,6,8)),
        bsTooltip(id = "carb", title = "Number of carburetor barrels", placement = "right", options = list(container = "body")),
        
        submitButton("Go")
      ),
      
      mainPanel(
        
        width = 8,
        
        h3("MPG Prediction"),
        
        br(),
        
        p("The fuel consumption for the chosen specifications will be: "),
        
        #textOutput("prediction")
        textOutput("prediction"),
        
        br(),
        
        p("The influence of the parameters on MPG is depicted below"),
        
        #imageOutput("plot")
        plotOutput("plot")
        
      )
      
    ),
    
    tabPanel(
      
      "Help",
      
      p("A linear regression prediction model is generated and trained for a specific dataset of cars (see below)."),
      
      p("User can play freely with the UI values in order to simulate the parameters of an hypothetical car and be able to predict its MPG consumption."),
      
      p("Dataset used by the application is the ",
        a(href = "https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", "Motor Trend Car Road Tests"),
        "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."
      ),
      
      tags$div("Next is the dataset structure:",
               tags$ul(
                 tags$li(strong("mpg"), "Miles/(US) gallon"),
                 tags$li(strong("cyl"), "Number of cylinders"),
                 tags$li(strong("disp"), "Displacement (cu.in.)"),
                 tags$li(strong("hp"), "Gross horsepower"),
                 tags$li(strong("drat", "Rear axle ratio"),
                 tags$li(strong("wt"), "Weight (1000 lbs)"),
                 tags$li(strong("qsec"), "1/4 mile time"),
                 tags$li(strong("vs"), "V/S (V-shape or straight engine)"),
                 tags$li(strong("am"), "Transmission (0 = automatic, 1 = manual)"),
                 tags$li(strong("gear"), "Number of forward gears"),
                 tags$li(strong("carb"), "Number of carburetor"))
               ),
       p("Not all parameters are used for prediction. Only the most influential parameters are used for building the prediction model"),
       tags$div("Based on step wise regression model building the below parameters are used for model building",
                tags$ul(
                  tags$li(strong("cyl"), "Number of cylinders"),
                  tags$li(strong("hp"), "Gross horsepower"),
                  tags$li(strong("wt"), "Weight (1000 lbs)"),
                  tags$li(strong("vs"), "V/S (V-shape or straight engine)"),
                  tags$li(strong("am"), "Transmission (0 = automatic, 1 = manual)"),
                  tags$li(strong("carb"), "Number of carburetor"))),
       
               tableOutput("dataStructure")
               
      )
      
    ),
    
    tabPanel(
      
      "About",
      
      h3("Developing Data Products course - Assignment Week 4 - Shiny Application and Reproducible Pitch"),
      
      h3("Author: Suresh B K - May, 2019"),
      
      br(),
      
      p("This application shows an example of making a web application using R and ",
        a(href = "https://shiny.rstudio.com/", "Shiny library"),
        "together, corresponding to the assigment of the week 4,",
        a(href = "https://www.coursera.org/learn/data-products", "Developing Data Products course from Coursera")
      ),
      
      p(a(href = "https://github.com/suresh-bk/datasciencecoursera/tree/master/Developing%20Data%20Products%20Week%204",
          "Click here")," to view the source code of this application - in GitHub"
      )
      
    )
    
    
  )
  
)