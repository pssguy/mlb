

dashboardPage(skin="yellow",
  dashboardHeader(title = "MLB"),
  
  dashboardSidebar(
    includeCSS("custom.css"),
#     inputPanel(
#     sliderInput(
#       "year","Select Season", min = 1901,max = 2015,value = 2015,sep = ""
#     )),
#     uiOutput("a"),
    
    sidebarMenu(
      menuItem(
        "Run Differential", tabName = "RD",icon = icon("area-chart")
      ),
      menuItem(
        "Awards",
        menuSubItem("Head To Head", tabName = "matchup")
      ),
      
      menuItem("Info", tabName = "info",icon = icon("info")),
      
      menuItem("Code",icon = icon("code-fork"),
               href = "https://github.com/pssguy/mlb"),
      
      menuItem(
        "Other Dashboards",
        menuSubItem("Climate",href = "https://mytinyshinys.shinyapps.io/climate"),
        menuSubItem("Cricket",href = "https://mytinyshinys.shinyapps.io/cricket"),
        menuSubItem("MainlyMaps",href = "https://mytinyshinys.shinyapps.io/mainlyMaps"), 
       
       
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
#         inputPanel(
#           sliderInput(
#             "year",NULL, min = 1901,max = 2015,value = 2015,sep = ""
#           )),
#         uiOutput("a"),
div(style = "display:inline-block",sliderInput(
               "year",NULL, min = 1901,max = 2015,value = 2015,
               sep = "",width='300px'
             )),
div(style = "display:inline-block;",uiOutput("a")),

        plotOutput("plot_RD")
        
      )
      
    ),
    
    
    
    tabItem("info",includeMarkdown("info.md"))
    
  ))
)
