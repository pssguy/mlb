
theData <- eventReactive(input$rdButton,{
  if (is.null(input$franchise))
    return()
  
  print(input$franchise)
  
  # create page for scraping
 chosenURL<- "http://www.baseball-reference.com/teams/TOR/2015-schedule-scores.shtml"
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
  
  print("glimpse(matchDf)")
  print(glimpse(matchDf))
  
  print("glimpse(df)")
  print(glimpse(df))
  
  info = list(matchDf = matchDf,df = df)
  return(info)
  
})

output$plot_RD <- renderDimple({
  if (is.null(theData()))
    return()
  
  # easier for comprehension though not needed
  matchDf <- theData()$matchDf
  df <- theData()$df
  write_csv(df,"df.csv")
  # summarize data by run differential
  py <- df %>%
    group_by(Result,RD) %>%
    tally() %>%
    right_join(matchDf)
  
  print("py")
  print(glimpse(py))
  
  write_csv(py,"probs.csv")
 # py[is.na(py$n),]$n <- 0
  #Error : Unknown parameters: subset
  
  py$n <- ifelse(is.na(py$n),0,py$n)
  
  py[py$Result == "L",]$n <- -py[py$Result == "L",]$n
  
  # Set chart title
  wins <- df %>%
    filter(Result == "W") %>%
    nrow(.)
  
  losses <- nrow(df) - wins
  title <-
    paste0("Run Differentials ",input$franchise," ",input$year," (",wins,"-",losses,")")
  
  theMax <- max(py$n)
  theMin <- min(py$n)
  print(theMax)
  
  # create rcdimple chart
  py %>%
    dimple(x = "n", y = "RD", group = "Result", type = 'bar') %>%
    #dimple(x = "Population", y = "Age", group = "Gender", type = 'bar', storyboard = "Year") %>%
    yAxis(title="Run Differential",type = "addCategoryAxis", orderRule = "RD") %>%
    xAxis(title="Games",type = "addMeasureAxis", overrideMax = theMax, overrideMin = theMin) %>%
    add_legend() %>%
   # add_title(html = "<h4 style='font-family:Helvetica; text-align: center;'>Results by Run Differential</h4>") %>%
    add_title(html = paste0("<h3 style='font-family:Helvetica; text-align: center;'>",title,"</h3>")) %>%
    tack(., options = list(
      chart = htmlwidgets::JS("
                              function(){
                              var self = this;
                              // x axis should be first or [0] but filter to make sure
                              self.axes.filter(function(ax){
                              return ax.position == 'x'
                              })[0] // now we have our x axis set _getFormat as before
                              ._getFormat = function () {
                              return function(d) {
                              return d3.format(',.0f')(Math.abs(d)) ;
                              };
                              };
                              // return self to return our chart
                              return self;
                              }
                              "))
      )
  

  
  
})
