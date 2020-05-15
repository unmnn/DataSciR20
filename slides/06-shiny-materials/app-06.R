library("shiny")
library("ggplot2")
library("tibble")

ui <- fluidPage(
  sliderInput(inputId = "slider", label = "Number of random values",
              min = 10, max = 150, step = 10, value = 50),
  actionButton(inputId = "normal", label = "Normal distribution"),
  actionButton(inputId = "unif", label = "Uniform distribution"),
  plotOutput(outputId = "plot")
)

server <- function(input, output) {
  
  data <- reactiveValues(x = rnorm(100))
  
  observeEvent(input$normal, data$x <- rnorm(input$slider))
  observeEvent(input$unif, data$x <- runif(input$slider))
  
  output$plot <- renderPlot({
    ggplot(tibble(x = data$x), aes(x)) + 
      geom_histogram(color = "black", fill = "royalblue", bins = 10)
  })
}

shinyApp(ui, server)