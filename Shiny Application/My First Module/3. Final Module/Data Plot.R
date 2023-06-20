dataPlot_UI <- function(id){
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("text1")),
    selectInput(inputId = ns("xSelector"), label = "Select the x axis:", choices = ""),
    selectInput(inputId = ns("ySelector"), label = "Select the y axis:", choices = ""),
    plotOutput(ns("p1"))
  )
}
dataPlot_server <- function(id) {
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
                 updateSelectInput(session, 
                                   "xSelector", 
                                   choices = colnames(dset))
                 updateSelectInput(session, 
                                   "ySelector", 
                                   choices = colnames(dset))
                 
                 output$p1 <- renderPlot({
                   ggplot(dset, aes_string(x = input$xSelector, y = input$ySelector)) + geom_point()
                 })
               }
  )
}