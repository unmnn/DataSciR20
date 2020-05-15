library("shiny")
library("ggplot2")
library("tibble")

ui <- fluidPage(
  sliderInput(inputId = "slider", label = "Anzahl von Zufallswerten",
              min = 10, max = 150, step = 10, value = 50),
  plotOutput(outputId = "plot"),
  verbatimTextOutput(outputId = "summary")
)

server <- function(input, output) {
  values <- rnorm(input$slider)
  
  output$plot <- renderPlot({
    ggplot(tibble(x = values), aes(x)) + 
      geom_histogram(color = "black", fill = "royalblue", bins = 10)
  })
  
  output$summary <- renderPrint({
    summary(values)
  })
}

shinyApp(ui, server)