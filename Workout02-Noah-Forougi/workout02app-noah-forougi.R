

library(shiny)
library(ggplot2)
library(rsconnect)
library(tidyverse)
#### Application ####
ui <- fluidPage(
  
  # Application title
  titlePanel("Investment Modality Outcomes"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(4, 
           sliderInput(inputId =  "initial_amount",
                       "Initial Amount",
                       min = 0,
                       max = 100000,
                       value = 1000, 
                       step = 500, 
                       pre = "$")),
    column(4, 
           sliderInput(inputId =  "return_rate",
                       "Return Rate",
                       min = 0,
                       max = 20,
                       value = 5, 
                       step = 0.1, 
                       post = "%")),
    column(4, 
           sliderInput(inputId =  "years",
                       "Years",
                       min = 0,
                       max = 50,
                       value = 20, 
                       step = 1)),
    column(4, 
           sliderInput(inputId =  "annual_contribution",
                       "Annual Contribution",
                       min = 0,
                       max = 50000,
                       value = 2000,
                       step = 500, 
                       pre = "$")),
    column(4, 
           sliderInput(inputId =  "growth_rate",
                       "Growth Rate (in %)",
                       min = 0,
                       max = 20,
                       value = 2, 
                       step = 0.1, 
                       post = "%")), 
    column(4, 
           selectInput(inputId =  "facet", label = "Facet?", 
                       choices = list("No" = 1, "Yes" = 2), 
                       selected = 1))
  ),
  # Show a plot of the generated distribution
  
  fluidRow(
    
    
    # Show a plot of the generated distribution
    column(width = 10,offset = 1,
           h4("Timelines"),
           plotOutput("plot")
           
    )
  ),
  fluidRow(
    column(width = 12,offset=1,
           h4("Balances"),
           verbatimTextOutput("values")
    )
  )
)


  


# Define server logic required to draw a histogram
server <- function(input, output) { 
  #### Functions ####
  #'@title future value function
  #'@description computes the future value of an investment for a given time period, interest rate and initial amount
  #'@param amount, the initial invested amount (numeric)
  #'@param rate, the annual rate of return (numeric)
  #'@param years, the number of years (numeric)
  #'@return the future value of an investment
  
  future_value <- function(amount, rate, years) { 
    if (years == 0) {
      return(future_valuex <- amount)
    }
    else (return(future_valuex <- amount*(1+rate)^years))}
  #'@title future value of annuity
  #'@description computes the future value of annuity 
  #'@param contrib, the contributed amount for each year (numeric)
  #'@param rate, the annual rate of return (numeric)
  #'@param years, the number of years (numeric)
  #'@return the future value of annuity
  
  annuity <- function(contrib, rate, years) { 
    fva <- contrib*(((1+rate)^years - 1)/rate)
    return(fva)}
  #'@title future value of growing annuity
  #'@description computes the future value of growing annuity 
  #'@param contrib, the contributed amount for each year (numeric)
  #'@param rate, the annual rate of return (numeric)
  #'@param years, the number of years (numeric)
  #'@param growth, the annual growth rate of deposit (numeric)
  #'@return the future value of growing annuity
  
  growing_annuity <- function(contrib, rate, growth, years) {
    ga <- contrib* (
      (  (1 + rate)^years - (1+growth)^years ) /
        (rate - growth)
    )
    return(ga)
  }
  
  row <- reactive(row <- c(0, rep(input$initial_amount, 3)))
  row0 <- reactive({
    years <- 0
    no_contrib <- input$initial_amount
    fixed_contrib <-  input$initial_amount
    growing_contrib <-   input$initial_amount
    row0 <- data.frame(
      year = years,
      no_contrib = no_contrib,
      fixed_contrib = fixed_contrib, 
      growing_contrib = growing_contrib
    )
    
    return(row0)
  })
  dat <- reactive({
    years <- 0:input$years
    
    no_contrib <- rep(0, input$years)
    fixed_contrib <- rep(0, input$years)
    growing_contrib <-  rep(0, input$years)
    
    
    
    for (y in years) {
      no_contrib[y+1] <- future_value(amount = input$initial_amount, rate = input$return_rate/100, years = y)
      
      fixed_contrib[y+1] <-   future_value(amount = input$initial_amount, rate = input$return_rate/100, years = y) + annuity(input$annual_contribution, rate = input$return_rate/100, years = y)
      
      growing_contrib[y+1] <- future_value(amount = input$initial_amount, rate = input$return_rate/100, years = y) + growing_annuity(contrib = input$annual_contribution, rate = input$return_rate/100, years = y, growth = input$growth_rate/100)
    }
    
    dat <- data.frame(
      year = years,
      no_contrib = no_contrib,
      fixed_contrib = fixed_contrib, 
      growing_contrib = growing_contrib
    )
    return(dat)
    return(row)
    return(row0)
  })
  
  
  
  
  # Show the values in an HTML table ----
  output$values <- renderPrint({
    return(dat())
   
  })
  
  output$plot <- renderPlot({ 
    dat <- reshape2::melt(dat(), id.var = 'year')
  
    if (input$facet == "1") {
      ggplot(dat, aes(x=year, y=value, col=variable))+ geom_line() + geom_point() + ggtitle("Three Modes of Investing")
    }
    else {
      ggplot(dat, aes(x=year, y=value, col=variable)) + geom_line() + facet_wrap(~variable) + 
        geom_area(data = dat, aes(fill=variable), alpha = 0.6) + geom_point() + ggtitle("Three Modes of Investing")
    }
  })
}
# Run the application 
shinyApp(ui = ui, server = server)

