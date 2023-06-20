#dashboardPage(
  #dashboardHeader(title = "Dashboard Header", 
                  #dropdownMenu(type = "messages", 
                                #messageItem(from = "Mike", message = "This is a test message")
                              #),
                  #dropdownMenuOutput(outputId = "messageMenu"),
                  
                  #dropdownMenu(type = "notifications", 
                                 #notificationItem(text = "This is a test notification")
                              #),
                  #dropdownMenu(type = "tasks", 
                                 #taskItem(text = "This is a test task", value  = 50)
                              #)
    #),
    #dashboardSidebar(
      #sidebarMenu(
        #menuItem(text = "Data", tabName = "data", icon = icon("table")),
        #menuItem(text = "Plots", tabName = "plots", icon = icon("chart-bar")),
        #selectInput(inputId = "cylSelector4", label = "Select a cylinder:", choices = cylinderChoices)
      #)
    #),
    #dashboardBody(
  fluidPage(
  #fluidRow(column(width = 3, input/output))
  
  textInput(inputId= "textInput", label = "Enter text", value = "", placeholder = "Michael"), 
  numericInput(inputId = "numeric", label = "Enter your age", value = 20, min = 0, max = 100, step = 1),
  checkboxInput(inputId = "checkbox", label = "Check or uncheck", value = F), 
  checkboxGroupInput(inputId = "groupCheckbox", label = "Check or Uncheck", choices = c("Choice 1", "Choice 2", "Choice 3")),
  selectInput(inputId = "select", label = "Select", choices = c("Choice 1", "Choice 2", "Choice 3"), selected = "Choice 1", multiple = F),
  sliderInput(inputId = "slider", label = "Select a number", value = 5, min = 0, max = 100, step = 10),
  radioButtons(inputId = "radio", label = "Select one", choices = c("Choice 1", "Choice 2", "Choice 3"), selected = "Choice 1"),
  dateInput(inputId = "date", label = "Select your birthday", value = "2000-01-03",min = "2000-01-01", max = "2023-01-01"),
  dateRangeInput(inputId = "dateRange", label = "Select a range",min = "2020-01-01", max = "2023-01-01"),

  verbatimTextOutput("text1"),
  tableOutput("table1"),
  plotOutput("plot1"),
  dataTableOutput("dt1"),
  
  selectInput(inputId = "colSelector", label = "Select a column:", choices = colChoices),
  selectInput(inputId = "cylSelector1", label = "Select a cylinder:", choices = cylinderChoices),
  plotOutput("p1"),
  
  selectInput(inputId = "xSelector", label = "Select the x axis:", choices = xAxisChoices),
  selectInput(inputId = "ySelector", label = "Select the y axis:", choices = yAxisChoices),
  selectInput(inputId = "cylSelector2", label = "Select a cylinder:", choices = cylinderChoices),
  
  
  #sidebarLayout(sidebarPanel(), mainPanel(tabsetPanel(tabPanel())))
  
  checkboxInput(inputId = "showTitle", label = "Check to enter title", value = FALSE),
  conditionalPanel(condition = "input.showTitle == true",
                   textInput("title", label = "Enter a plot title", placeholder = "Title")),
  actionButton("refreshPlot", label = "Refresh"),
  plotOutput("p2"),
  
  selectInput("cylSelector3", label = "Select a cylinder", choices = cylinderChoices),
  
  downloadButton("downloadData", "Download Data"),
  DTOutput("datatable1"),
  
  fileInput("file1", "Upload a csv file:", 
            multiple = FALSE,
            accept = c(".csv")),
  textInput("sep", label = "Enter the Separator character", value = ","),
  checkboxInput("header", label = "File contains a header", value = TRUE), 
  DTOutput("data1"),
  
  DTOutput(outputId = "updatedData"),
  plotOutput(outputId = "updatedPlot"),
  
  actionButton(inputId = "loop", label = "Start long running process"),
  
  #tabItems(
    #tabItem(tabName = "plots",
            #plotOutput("plot3")
    #),
    #tabItem(tabName = "data",
            #DTOutput(outputId = "data1")
    #)
  #)
  #)
  
  
)