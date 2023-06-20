

output_UI <- function(id, dataset){
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("text1")),
    tableOutput(ns("table1")),
    dataTableOutput(ns("dt1")),
    selectInput(inputId = ns("xSelector"), label = "Select the x axis:", choices = colnames(dataset)),
    selectInput(inputId = ns("ySelector"), label = "Select the y axis:", choices = colnames(dataset)),
    plotOutput(ns("plot1")),
  )
}

output_server <- function(id, dataset) {
  moduleServer(id,
               function(input, output, session){
                 
                 # placeholder .... come from DB
                 #updateSelectInput(session, "xSelector", 
                                   #choices = colnames(mtcars))
                 #updateSelectInput(session, "ySelector", 
                                   #choices = colnames(mtcars))
                 # placeholder .... come from DB - END
                 
                 
                 output$text1 <- renderText(paste("This is the 1st sample text.", "This is the 2nd sample text.", sep = "\n"))
                 output$table1 <- renderTable(dataset)
                 output$plot1 <- renderPlot({
                   ggplot(data = dataset, aes_string(x = input$xSelector, y = input$ySelector)) + geom_point()
                 })
                 output$dt1 <- renderDT({
                   datatable(dataset, options = list(pageLength = 5,
                                                     lengthMenu = c(5, 10, 15, 20)
                   )
                   )
                 })
               }
  )
}