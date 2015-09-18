## Award processing

## want to add cickability slike standings in world soccer

getSeason = function(data,location,session){
  
  if(is.null(data)) return(NULL)
  
  theYear <- data$year
  theLeague <- data$league

  
  session$output$table <- DT::renderDataTable({

    mvpVotes  %>% 
      filter(year==theYear&league==theLeague) %>% 
     
      
      select(Name,Tm,WAR,rankWAR) %>% 
      
      DT::datatable(class='compact stripe hover row-border order-column',rownames=TRUE,options= list(paging = TRUE, searching = FALSE,info=FALSE))
    
  })


## initial graph

winner <-mvpVotes %>% 
  filter(Rank==1) %>% 
  select(Winner=Name,WAR.winner=WAR,league,year,Rank.WAR=rankWAR)

topRanked <- mvpVotes %>% 
  filter(rankWAR==1) %>% 
  select(TopRank=Name,WAR.topRank=WAR,league,year)

df <- inner_join(winner,topRanked) %>% 
  mutate(diffWAR=WAR.topRank-WAR.winner) 


df$id <- 1:nrow(df)

all_values <- function(x) {
  if(is.null(x)) return(NULL)
  row <- df[x$id == df$id,c("year","league","Winner","Rank.WAR","WAR.winner","TopRank","WAR.topRank")]
  paste0( names(row),": ",format(row), collapse = "<br />")
}

observe({
  
  if (input$mvpChoice=="Rank") {
df %>% 
 
  ggvis(~year,~Rank.WAR,fill=~league,key:= ~id) %>% 
  layer_points() %>% 
  add_tooltip(all_values, "click") %>% 
      handle_click(getSeason) %>%     
  add_axis("x",title="",format='d') %>% 
  add_axis("y",title="WAR ranking",format='d') %>% 
  scale_numeric("y", reverse=T, zero=FALSE) %>% 
    bind_shiny("rankWAR")
  } else {
    df %>% 
      
      ggvis(~year,~diffWAR,fill=~league,key:= ~id) %>% 
      layer_points() %>% 
      add_tooltip(all_values, "click") %>% 
      add_axis("x",title="",format='d') %>% 
      add_axis("y",title="WAR Differential",format='d') %>% 
      scale_numeric("y", reverse=T, zero=FALSE) %>% 
      bind_shiny("rankWAR")
    
  }
})