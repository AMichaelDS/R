function(input,output, session){
  
  output$text1 <- renderText(paste("This is the 1st sample text.", "This is the 2nd sample text.", sep = "\n"))
  output$table1 <- renderTable(mtcars)
  output$plot1 <- renderPlot({
    ggplot(data = mtcars, aes(x = mpg, y = hp, color = cyl)) + geom_point()
  })
  
  output$dt1 <- renderDT({
    datatable(mtcars, options = list(pageLength = 5,
                                     lengthMenu = c(5, 10, 15, 20)
                                     )
              )
  })
  filterData1 <- reactive({
    
    filteredData1 <- mtcars[mtcars$cyl == input$cylSelector1,]
    
    return(filteredData1)
  })
  
  output$p1 <- renderPlot({
    ggplot(data = filterData1(), aes_string(x = "mpg", y = input$colSelector)) + geom_point()
  })
  
  filterData2 <- reactive({
    
    filteredData2 <- mtcars[mtcars$cyl == input$cylSelector2,]
    
    return(filteredData2)
  })
  
  plot2 <- eventReactive(input$refreshPlot,{
    
    if(input$showTitle == TRUE){
      
      ggplot(data = filterData2(), aes_string(x = input$xSelector, y = input$ySelector)) + geom_point() + ggtitle(input$title)
      
 
    } 
    
    else{
      
      ggplot(data = filterData2(), aes_string(x = input$xSelector, y = input$ySelector)) + geom_point() 
    }
    
   })
  
  output$p2 <- renderPlot(plot2())
  
  #download data:

  filterData3 <- reactive({
    
    filteredData3 <- mtcars[mtcars$cyl == input$cylSelector3,]
    
    return(filteredData3)
  })
  
  output$datatable1 <- renderDT({
    
    datatable(filterData3())
    
  })
  output$downloadData <-
    downloadHandler(
      filename = "FilteredData.csv", 
      content = function(file){
        write.csv(filterData3()[input[["datatable1_rows_all"]],], file)
      }
    )
  
  output$data1 <- renderDT({
    req(input$file1)
    df <- read.csv(input$file1$datapath, header = input$header, sep = input$sep)
    return(datatable(df))
  })
  
  
  
  fileData <- reactiveFileReader(intervalMillis = 1000, 
                                 session = session,
                                 filePath = 'C:/Users/ASUS/Downloads/dataToRefresh.csv',
                                 readFunc = read.csv)
  
  dataAggregation <- reactive({
    
    aggData <- data.table(fileData())[,list(totalSales = sum(Amount)),
                                      by = list(SalesPerson, Day)]
    return(aggData)
    
  })
  
  output$updatedData <- renderDT(datatable(dataAggregation()))
  output$updatedPlot <- renderPlot({
    ggplot(data = dataAggregation(), aes(x = SalesPerson, y = totalSales, fill = SalesPerson)) + geom_col()
  })
  
  observeEvent(input$loop,{
    n = 100
    
    withProgress(message = "Running Process", value = 0,{
      for(i in 1:n){
        incProgress(amount = 1/n, detail = paste0("Completed ", i, "%"))
      Sys.sleep(.1)
      }
    })
  })
  
  
  #messageData <- data.frame(from = c("Finance", "Accounting", "HR"),
                            #message = c("Revenue is up", "Budget meeting this friday", "Donuts in the breakroom"))
  
  #output$messageMenu <- renderMenu({
    
    #msg <- apply(messageData, 1, function(row){
      #messageItem(from  = row[['from']], message = row[["message"]])
  #})
    
    #dropdownMenu(type = "messages", .list = msg)
  #})
  
  #filterData4 <- reactive({
    
    #filteredData4 <- mtcars[mtcars$cyl == input$cylSelector4,]
    
    #return(filteredData4)
  #})
  
  #output$data1 <- renderDT(datatable(filterData4()))
  #output$plot3 <- renderPlot({
    #ggplot(data = filterData4(), aes(x = mpg, y = hp)) + geom_point()
  #})
  
}