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