
dashboardPage(
  dashboardHeader(title = "MLB"),
  
    dashboardSidebar(
         sliderInput("year","Select Season", min=1901,max=2015,value=2015,sep=""),
         uiOutput("a"),
 
  sidebarMenu(
    menuItem("Run Differential", tabName = "RD",icon = icon("map-marker")),
 

  menuItem("Info", tabName = "info",icon = icon("info")),
#   
#   menuItem("Code",icon = icon("code-fork"),
#            href = "https://github.com/pssguy/fortune500"),
#   
  menuItem("Other Dashboards",
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
    
  dashboardBody( 
    tabItems(
      tabItem("RD",
  
    
    box(
      status = "success", solidHeader = TRUE,
      title = "Run Differential",
      plotOutput("plot_RD")
      
    )
   
      ),

# tabItem("data",
#           fluidRow(
#             column(width=8,offset=2,
#           
#           box(width=12,
#             status = "info", solidHeader = FALSE,
#             includeMarkdown("data.md")
#           ),
#           box(width=12,
#             DT::dataTableOutput("data")
#           )
#             ))
#         ),
# 
 tabItem("info",includeMarkdown("info.md"))

) 
       
        
)
)




