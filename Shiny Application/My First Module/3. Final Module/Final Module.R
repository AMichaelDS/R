library(rsconnect)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(DT)

source("Data Table.R",local = TRUE)
source("Data Plot.R",local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "Dataset"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Data 1", tabName = "d1"),
      menuItem(text = "Plot 1", tabName = "p1"),
      menuItem(text = "Data 2", tabName = "d2"),
      menuItem(text = "Plot 2", tabName = "p2"),
      menuItem(text = "Data 3", tabName = "d3"),
      menuItem(text = "Plot 3", tabName = "p3")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "d1", dataTable_UI("Dt.101")),
      tabItem(tabName = "p1", dataPlot_UI("Plot.101")),
      tabItem(tabName = "d2", dataTable_UI("Dt.102")),
      tabItem(tabName = "p2", dataPlot_UI("Plot.102")),
      tabItem(tabName = "d3", dataTable_UI("Dt.103")),
      tabItem(tabName = "p3", dataPlot_UI("Plot.103"))
    )
  )
)

server <- function(input, output, session) {
  dataTable_server("Dt.101")
  dataPlot_server("Plot.101")
  dataTable_server("Dt.102")
  dataPlot_server("Plot.102")
  dataTable_server("Dt.103")
  dataPlot_server("Plot.103")
}

shinyApp(ui, server)