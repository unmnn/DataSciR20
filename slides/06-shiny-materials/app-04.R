library("shiny")

ui <- fluidPage(
  actionButton(inputId = "button", label = "Go!")
)

server <- function(input, output) {
  observeEvent(input$button, {
    print(input$button)
  })
  
}

shinyApp(ui, server)