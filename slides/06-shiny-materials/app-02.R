library("shiny")
library("ggplot2")
library("tibble")

ui <- fluidPage(
  sliderInput(inputId = "slider", label = "Number of random values",
              min = 10, max = 150, step = 10, value = 50),
  plotOutput(outputId = "plot"),
  verbatimTextOutput(outputId = "summary")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    x <- tibble(x = rnorm(input$slider))
    ggplot(x, aes(x)) + 
      geom_histogram(color = "black", fill = "royalblue", bins = 10)
  })
  output$summary <- renderPrint({
    x <- rnorm(input$slider)
    summary(x)
  })
}

shinyApp(ui, server)