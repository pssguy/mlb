


theData <- reactive({
  
  if(is.null(input$franchise)) return()
 # if(is.null(input$year)) return()
  print(input$year)
  print(input$franchise)
  
  #chosenURL <- "http://www.baseball-reference.com/teams/TOR/2015-schedule-scores.shtml"
 # http://www.baseball-reference.com/teams/ANA/2015-schedule-scores.shtml
  chosenURL <- paste0("http://www.baseball-reference.com/teams/",input$franchise,"/",input$year,"-schedule-scores.shtml")
  print(chosenURL)
  tables <- readHTMLTable(chosenURL,stringsAsFactors=F)
  print(names(tables))
  Origdf <- tables[["team_schedule"]] 
  
  df <- Origdf[Origdf$Rk!="Rk",c(1,8:10)]
 # print(glimpse(df))
  colnames(df) <- c("Order","Result","RF","RA")
  
  #glimpse(df)
  
  df <- df %>%  
    filter(nchar(df$Result)<6)
  
  df$RF <- as.integer(df$RF)
  df$RA <- as.integer(df$RA)
  df$Result <- str_sub(df$Result,1,1)
  print(glimpse(df))
  print(df$RF)
  print(df$RA)
  
  test <-df %>% 
    filter(!is.na(RF)) %>% 
    mutate(RD=abs(RF-RA)) 
    
  
  max(test$RD) #9
  
  Result <- c("W","L")
  RD <- c(1:max(test$RD))
  matchDf <- expand.grid(Result=Result,RD=RD)
  
  py <-test %>% 
    group_by(Result,RD) %>% 
    tally() %>% 
    right_join(matchDf)
  
  max(abs(py$n))
  
  py[is.na(py$n),]$n <- 0
  py[py$Result=="L",]$n <- -py[py$Result=="L",]$n
  
  glimpse(py)
  info=list(py=py,test=test)
  
})

output$plot_RD <- renderPlot({
  
  py <- theData()$py
  test <- theData()$test
  
  print(glimpse(py))
#   breaks = seq(-max(abs(py$n)), max(abs(py$n)),2)
#   print(breaks)
#   labels = c(seq(max(abs(py$n)),0,-2),seq(2,max(abs(py$n)),2))
#   print(labels)
  
  title <- paste0("Run Differences ",input$franchise," ",input$year)
  
  n1 <- ggplot(py, aes(x = RD, y = n, fill = Result)) + 
    geom_bar(subset = .(Result == "W"), stat = "identity") + 
    geom_bar(subset = .(Result == "L"), stat = "identity") + 
    scale_x_discrete(breaks=seq(1,max(test$RD))) +
    scale_y_continuous(breaks = seq(-max(abs(py$n)), max(abs(py$n)),2)) +
    # scale_y_continuous(breaks = seq(-max(abs(py$n)), max(abs(py$n)),2),labels = c(seq(max(abs(py$n)),0,-2),seq(2,max(abs(py$n)),2))) +
    ylab("Number of Games")+
    xlab("Run Difference") +
    coord_flip() + 
    #scale_fill_brewer(palette = "Set1") + 
    ggtitle(title) +
    theme_bw()
  n1
  
})
