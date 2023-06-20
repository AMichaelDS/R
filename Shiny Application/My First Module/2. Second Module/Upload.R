uploadData_UI <- function(id){
  ns <- NS(id)
  tagList(
    fileInput(inputId = ns("file1"), "Upload a csv file:", 
              multiple = FALSE,
              accept = c(".csv")),
    textInput(inputId = ns("sep"), label = "Enter the Separator character", value = ","),
    checkboxInput(inputId = ns("header"), label = "File contains a header", value = TRUE), 
    DTOutput(outputId = ns("data1"))
  )
}

uploadData_server <- function(id) {
  moduleServer(id,
               function(input, output, session){
                 output$data1 <- renderDT({
                   req(input$file1)
                   df <- read.csv(input$file1$datapath, header = input$header, sep = input$sep)
                   return(datatable(df))
                 })
               }
  )
}