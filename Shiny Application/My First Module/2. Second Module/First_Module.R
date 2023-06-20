#library
library(shiny)
library(shinydashboard)
library(shinyjs)
library(DT)
library(ggplot2)
library(data.table)
library(dplyr)

source("Download.R",local = TRUE)
source("Input.R",local = TRUE)
source("Output.R",local = TRUE)
source("Progress.R",local = TRUE)
source("XYT.R",local = TRUE)
source("Summary.R",local = TRUE)
source("Upload.R",local = TRUE)




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
                 