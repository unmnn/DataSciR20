library("shiny")
library("tidyverse")

ui <- fluidPage(
  sliderInput(inputId = "slider", label = "Number of random values",
              min = 10, max = 150, step = 10, value = 50),
  plotOutput(outputId = "plot")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    df <- tibble(x = rnorm(input$slider))
      ggplot(df, aes(x)) + 
      geom_histogram(color = "black", fill = "royalblue", 
                                      bins = 10)
  })
}

shinyApp(ui, server)