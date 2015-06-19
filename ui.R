

dashboardPage(
  dashboardHeader(title = "MLB"),
  
  dashboardSidebar(
    sliderInput(
      "year","Select Season", min = 1901,max = 2015,value = 2015,sep = ""
    ),
    uiOutput("a"),
    
    sidebarMenu(
      menuItem(
        "Run Differential", tabName = "RD",icon = icon("area-chart")
      ),
      
      
      menuItem("Info", tabName = "info",icon = icon("info")),
      
      menuItem("Code",icon = icon("code-fork"),
               href = "https://github.com/pssguy/mlb"),
      
      menuItem(
        "Other Dashboards",
        menuSubItem("Fortune 500",href = "https://mytinyshinys.shinyapps.io/fortune500"),
        menuSubItem("WikiGuardian",href = "https://mytinyshinys.shinyapps.io/wikiGuardian"),
        menuSubItem("World Soccer",href = "https://mytinyshinys.shinyapps.io/worldSoccer")
        
      ),
      
      menuItem("", icon = icon("twitter-square"),
               href = "https://twitter.com/pssGuy"),
      
      menuItem("", icon = icon("envelope"),
               href = "mailto:agcur@rogers.com")
    )
  ),
  
  dashboardBody(tabItems(
    tabItem(
      "RD",
      
      
      box(
        status = "success", solidHeader = TRUE,
        title = "Run Differential",
        plotOutput("plot_RD")
        
      )
      
    ),
    
    
    
    tabItem("info",includeMarkdown("info.md"))
    
  ))
)
