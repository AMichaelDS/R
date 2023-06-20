summary_UI <- function(id, dataset) {
  ns <- NS(id)
  
  tagList(
    checkboxInput(
      inputId = ns("summary"),
      label = "show summary",
      value = FALSE
    ),
    selectInput(
      inputId = ns("summary_column"),
      label = "summary based on: ",
      choices = colnames(dataset)
    ),
    DTOutput(
      outputId = ns("table")
    )
  )
}

summary_server <- function(id, dataset) {
  moduleServer(
    id,
    function(input, output, session){
      table_data <- reactive({
        if(input$summary) {
          data <- dataset %>%
            group_by(.data[[input$summary_column]]) %>%
            summarise(counts = n())
        } else {
          data <- dataset
        }
        
        data
      })
      
      output$table <- renderDT({
        table_data()
      })
    }
  )
}