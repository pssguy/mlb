



theData <- reactive({
  if (is.null(input$franchise))
    return()
  
  # create page for scraping
  chosenURL <-
    paste0(
      "http://www.baseball-reference.com/teams/",input$franchise,"/",input$year,"-schedule-scores.shtml"
    )
  
  # obtain data and tidy up
  tables <- readHTMLTable(chosenURL,stringsAsFactors = F)
  Origdf <- tables[["team_schedule"]]
  df <- tables[["team_schedule"]]
  df <- df[df$Rk != "Rk",c(1,8:10)]
  colnames(df) <- c("Order","Result","RF","RA")
  
  
  df <- df %>%
    filter(nchar(df$Result) < 6)
  
  df$RF <- as.integer(df$RF)
  df$RA <- as.integer(df$RA)
  df$Result <- str_sub(df$Result,1,1)
  
  df <- df %>%
    filter(!is.na(RF)) %>%
    mutate(RD = abs(RF - RA))
  
  
  
  # create a data.frame with all possible run differences occuring
  Result <- c("W","L")
  RD <- c(1:max(df$RD))
  matchDf <- expand.grid(Result = Result,RD = RD)
  
  
  info = list(matchDf = matchDf,df = df)
  return(info)
  
})

output$plot_RD <- renderPlot({
  if (is.null(theData()))
    return()
  
  # easier for comprehension though not needed
  matchDf <- theData()$matchDf
  df <- theData()$df
  
  # summarize data by run differential
  py <- df %>%
    group_by(Result,RD) %>%
    tally() %>%
    right_join(matchDf)
  
  py[is.na(py$n),]$n <- 0
  py[py$Result == "L",]$n <- -py[py$Result == "L",]$n
  
  # Set chart title
  wins <- df %>%
    filter(Result == "W") %>%
    nrow(.)
  losses <- nrow(df) - wins
  title <-
    paste0("Run Differences ",input$franchise," ",input$year," (",wins,"-",losses,")")
  
  # Create chart
  ggplot(py, aes(x = RD, y = n, fill = Result)) +
    geom_bar(subset = .(Result == "W"), stat = "identity") +
    geom_bar(subset = .(Result == "L"), stat = "identity") +
    scale_x_discrete(breaks = seq(1,max(df$RD))) +
    scale_y_continuous(breaks = seq(-max(abs(py$n)), max(abs(py$n)),2)) +
    ylab("Number of Games") +
    xlab("Run Difference") +
    coord_flip() +
    ggtitle(title) +
    theme_bw()
  
  
})
