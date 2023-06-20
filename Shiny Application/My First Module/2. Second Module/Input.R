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