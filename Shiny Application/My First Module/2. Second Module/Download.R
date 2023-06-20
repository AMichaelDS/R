downloadData_UI <- function(id, dataset){
  ns <- NS(id)
  tagList(
    downloadButton(outputId = ns("downloadData"), "Download Data"),
    DTOutput(outputId = ns("datatable1"))
  )
}

downloadData_server <- function(id, dataset) {
  moduleServer(id,
               function(input, output, session){
                 output$datatable1 <- renderDT({
                   datatable(dataset)
                 })
                 output$downloadData <-
                   downloadHandler(
                     filename = "Data.csv", 
                     content = function(file){
                       write.csv(dataset[input[["datatable1_rows_all"]],], file)
                     }
                   )
               }
  )
}