

shinyServer(function(input, output,session) {
  # franchises by year
  output$a <- renderUI({
  
    teams <- sort(teamYears[teamYears$years == input$year,]$teamID)
    
   
    selectInput("franchise","Select Franchise",teams, width='120px')
    
  })
  
  
  source("code/runDifferentials.R", local = TRUE)
  source("code/awards.R", local = TRUE)
  source("code/divisionRaces.R", local = TRUE)
  
  
  
  
  
})
