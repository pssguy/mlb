

shinyServer(function(input, output,session) {
  # franchises by year
  output$a <- renderUI({
  
    teams <- sort(teamYears[teamYears$years == input$year,]$teamID)
    
    inputPanel(
    selectInput("franchise","Select Franchise",teams)
    )
  })
  
  
  source("code/runDifferentials.R", local = TRUE)
  
  
  
  
  
})
