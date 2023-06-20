dataTable_UI <- function(id){
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("text1")),
    dataTableOutput(ns("dt1"))
  )
}

dataTable_server <- function(id) {
  moduleServer(id,
               function(input, output, session){
                 if (gsub(".*\\.", "",id) == "101") {
                   dset <- mtcars
                   dset_lbl <- "mtcars"}
                 if (gsub(".*\\.", "",id) == "102") {
                   dset <- diamonds
                   dset_lbl <- "diamonds"}
                 if (gsub(".*\\.", "",id) == "103") {
                   dset <- CO2
                   dset_lbl <- "CO2"}
                 output$text1 <- renderText(paste(dset_lbl))
                 output$dt1 <- renderDT({
                   datatable(dset, options = list(pageLength = 5, lengthMenu = c(5, 10, 15, 20)
                                                  )
                             )
                 })
                 }
  )
}