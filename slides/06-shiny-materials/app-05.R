library("shiny")
library("ggplot2")
library("tibble")

ui <- fluidPage(
  sliderInput(inputId = "slider", label = "Number of random values",
              min = 10, max = 150, step = 10, value = 50),
  textInput(inputId = "text", label = "Histogram title", value = "fancy title"),
  actionButton(inputId = "button", label = "Go!"),
  plotOutput(outputId = "plot")
)

server <- function(input, output) {
  rp <- eventReactive(input$button, {
    ggplot(tibble(x = rnorm(input$slider)), aes(x)) + 
      geom_histogram(color = "black", fill = "royalblue", bins = 10) +
      labs(title = input$text)
  })
  
  output$plot <- renderPlot(rp())
}

shinyApp(ui, server)