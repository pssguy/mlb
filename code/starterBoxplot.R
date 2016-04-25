


sbp_data <- eventReactive(input$spb_go,{
  
  print(input$min_Inns)
  print(input$pitcherWAR_yr)
  
  # tables <- readHTMLTable(paste0("http://www.fangraphs.com/leaders.aspx?pos=all&stats=sta&lg=all&qual=",input$min_Inns,"&type=8&season=",input$pitcherWAR_yr,"&month=0&season1=",input$pitcherWAR_yr,"&ind=0&team=0&rost=0&age=0&filter=&players=0&page=1_300", stringsAsFactors=FALSE))
  
  tables <- readHTMLTable(paste0("http://www.fangraphs.com/leaders.aspx?pos=all&stats=sta&lg=all&qual=",input$min_Inns,"&type=8&season=",input$pitcherWAR_yr,"&month=0&season1=",input$pitcherWAR_yr,"&ind=0&team=0&rost=0&age=0&filter=&players=0&page=1_300"))
  
  
  starters <-tables[["LeaderBoard1_dg1_ctl00"]]
  
  starters$Name <- as.character(starters$Name)
  starters$Team <- as.character(starters$Team)
  starters$WAR <- as.numeric(as.character(starters$WAR))
  
  print(glimpse(starters))
  
  info=list(starters=starters)
  return(info)
  
  
})


output$startersWARplot <-renderExploding_boxplot({
  
  exploding_boxplot(
    sbp_data()$starters,
    y = "WAR",
    group = "Team",
   # width= 2000 ,
    label = "Name", 
    iqr = 2,
    margin = list(bottom = 30, left = 50, top = 20, right = 20),
   xlab=" ",
   ylab = "Individual's WAR"
    
  )
})