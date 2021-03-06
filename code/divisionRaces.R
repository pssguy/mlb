
output$divRace <- renderPlotly({
  if (input$race_div == "Central" & input$race_yr <= 1993)
    return()
  
  
  
  final_sel <- divRaces %>%
    filter(league == input$race_lg &
             divison == input$race_div & season == input$race_yr)
  
  
  
  
  title <-
    paste0(input$race_lg,
           " ",
           input$race_div,
           " ",
           input$race_yr,
           " Pennant Race")
  
  
  
  
  plot_ly(
    final_sel,
    x = gameOrder,
    y = diff,
    mode = "lines",
    hoverinfo = "text",
    color = Team,
    text = paste(Team,
                 "<br>", Date,
                 "<br> v ", Opp, " ", " ", R, "-", RA,
                 # "<br> W-L:",toDate,
                 "<br> GB:", GB)
  ) %>%
    
    layout(
      hovermode = "closest",
      title = title,
      xaxis = list(title = "Games Played"),
      yaxis = list(title = "Games Behind Division Leader", autorange =
                     "reversed")
    )
  
})