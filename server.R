
shinyServer(function(input, output,session) {
  
  # franchises by year
  output$a <- renderUI({
    print("enter renderUI")
    print(input$year)
    teams <- teamYears[teamYears$years==input$year,]$teamID
    teams <- sort(teams)
    print(teams)
    selectInput("franchise","Select Franchise",teams)
  })
  

  source("code/runDifferentials.R", local=TRUE)
  
  
  
 
 
})

