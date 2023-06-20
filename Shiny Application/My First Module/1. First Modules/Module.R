#library
library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(data.table)
library(dplyr)

#input sample 

input_UI <- function(id){
  ns <- NS(id)
  tagList(
    textInput(inputId= ns("textInput"), label = "Please enter your name", value = "", placeholder = "Michael"), 
    numericInput(inputId = ns("numeric"), label = "Please enter your age", value = 20, min = 0, max = 100, step = 1),
    checkboxInput(inputId = ns("checkbox"), label = "Are you working right now?", value = F), 
    checkboxGroupInput(inputId = ns("groupCheckbox"), label = "Multi-Select", choices = c("Choice 1", "Choice 2", "Choice 3")),
    selectInput(inputId = ns("select"), label = "Select", choices = c("Choice 1", "Choice 2", "Choice 3"), selected = "Choice 1", multiple = F),
    sliderInput(inputId = ns("slider"), label = "Please enter your weight", value = 5, min = 0, max = 100, step = 10),
    radioButtons(inputId = ns("radio"), label = "Multi-Choice", choices = c("Choice 1", "Choice 2", "Choice 3"), selected = "Choice 1"),
    dateInput(inputId = ns("date"), label = "Select your birthday", value = "2000-01-03",min = "2000-01-01", max = "2023-01-01"),
    dateRangeInput(inputId = ns("dateRange"), label = "Select a range",min = "2020-01-01", max = "2023-01-01")
  )
}

input_server <- function(id) {
  moduleServer(id,
               function(input, output, session){
                 
               }
  )
}

#output sample

output_UI <- function(id, dataset){
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("text1")),
    tableOutput(ns("table1")),
    dataTableOutput(ns("dt1")),
    selectInput(inputId = ns("xSelector"), label = "Select the x axis:", choices = xAxisChoices),
    selectInput(inputId = ns("ySelector"), label = "Select the y axis:", choices = yAxisChoices),
    plotOutput(ns("plot1")),
  )
}

output_server <- function(id, dataset) {
  xAxisChoices <- colnames(dataset)
  yAxisChoices <- colnames(dataset)
  
  moduleServer(id,
               function(input, output, session){
                 output$text1 <- renderText(paste("This is the 1st sample text.", "This is the 2nd sample text.", sep = "\n"))
                 output$table1 <- renderTable(dataset)
                 output$plot1 <- renderPlot({
                   ggplot(data = dataset, aes(x = .data[[input$xSelector]], y = .data[[input$ySelector]])) + geom_point()
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

#selecting x, y, and title

xytSelect_UI <- function(id, dataset){
  ns <- NS(id)
  tagList(
    selectInput(inputId = ns("xSelector"), label = "Select the x axis:", choices = xAxisChoices),
    selectInput(inputId = ns("ySelector"), label = "Select the y axis:", choices = yAxisChoices),
    checkboxInput(inputId = ns("showTitle"), label = "Check if you want to enter title", value = FALSE),
    conditionalPanel(condition = paste0("input.", ns("showTitle"), " == true"), ns = ns,
                     textInput(ns("title"), label = "Enter a plot title", placeholder = "Title")),
    actionButton(ns("refreshPlot"), label = "Refresh"),
    plotOutput(ns("p1"))
  )
}

xytSelect_server <- function(id, dataset) {
  xAxisChoices <- colnames(dataset)
  yAxisChoices <- colnames(dataset)
  moduleServer(id,
               function(input, output, session){
                 plot1 <- eventReactive(input$refreshPlot,{
                   if(input$showTitle == TRUE){
                     ggplot(data = dataset, aes_string(x = input$xSelector, y = input$ySelector)) + geom_point() + ggtitle(input$title)
                   } 
                   else{
                     ggplot(data = dataset, aes_string(x = input$xSelector, y = input$ySelector)) + geom_point() 
                   }
                 })
                 output$p1 <- renderPlot(plot1())
               }
  )
}

#downloading data

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

#uploading data 

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

#progress bar

progress_UI <- function(id){
  ns <- NS(id)
  tagList(
    actionButton(inputId = ns("loop"), label = "Start long running process")
  )
}

progress_server <- function(id) {
  moduleServer(id,
               function(input, output, session){
                 observeEvent(input$loop,{
                   n = 100
                   
                   withProgress(message = "Running Process", value = 0,{
                     for(i in 1:n){
                       incProgress(amount = 1/n, detail = paste0("Completed ", i, "%"))
                       Sys.sleep(.1)
                     }
                   })
                 })
               }
  )
}

#summary 

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

ui <- dashboardPage(
  dashboardHeader(title = "Module"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Input", tabName = "input"),
      menuItem(text = "Output", tabName = "output"),
      menuItem(text = "XYT", tabName = "xyt"),
      menuItem(text = "Download", tabName = "download"),
      menuItem(text = "Upload", tabName = "upload"),
      menuItem(text = "Progress", tabName = "progress"),
      menuItem(text = "Summary", tabName = "summary")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "input", input_UI("input")),
      tabItem(tabName = "output", output_UI("mtcars2", dataset = mtcars)),
      tabItem(tabName = "xyt", xytSelect_UI("mtcars3", dataset = mtcars)),
      tabItem(tabName = "download", downloadData_UI("mtcars4", dataset = mtcars)),
      tabItem(tabName = "upload", uploadData_UI("data")),
      tabItem(tabName = "progress", progress_UI("progress")),
      tabItem(tabName = "summary", summary_UI("mtcars5", dataset = mtcars))
      )
  )
)

server <- function(input, output, session) {
  input_server("input")
  output_server("mtcars2", dataset = mtcars)
  xytSelect_server("mtcars3", dataset = mtcars)
  downloadData_server("mtcars4", dataset = mtcars)
  uploadData_server("data")
  progress_server("progress")
  summary_server("mtcars5", dataset = mtcars)
}

shinyApp(ui, server)    