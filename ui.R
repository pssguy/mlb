

dashboardPage(skin="yellow",
  dashboardHeader(title = "MLB"),
  
  dashboardSidebar(
    includeCSS("custom.css"),

    
    sidebarMenu(
      menuItem(
        "Division Races", tabName = "divRaces",icon = icon("line-chart"), selected=T
      ),
      menuItem(
        "Run Differential", tabName = "RD",icon = icon("area-chart")
      ),
      menuItem(
        "Awards",
        menuSubItem("MVP", tabName = "mvp")
      ),
      
      menuItem("Info", tabName = "info",icon = icon("info")),
      
      menuItem("Code",icon = icon("code-fork"),
               href = "https://github.com/pssguy/mlb"),
      
      tags$hr(),
      menuItem(text="",href="https://mytinyshinys.shinyapps.io/dashboard",badgeLabel = "All Dashboards and Trelliscopes (14)"),
      tags$hr(),
      
      tags$body(
        a(class="addpad",href="https://twitter.com/pssGuy", target="_blank",img(src="images/twitterImage25pc.jpg")),
        a(class="addpad2",href="mailto:agcur@rogers.com", img(src="images/email25pc.jpg")),
        a(class="addpad2",href="https://github.com/pssguy",target="_blank",img(src="images/GitHub-Mark30px.png")),
        a(href="https://rpubs.com/pssguy",target="_blank",img(src="images/RPubs25px.png"))
      )
    )
  ),
  
  dashboardBody(tabItems(
    tabItem(
      "RD",
      
      
      box(width=4,
        status = "success", solidHeader = TRUE,
        title = "Run Differential",

inputPanel(
sliderInput("year",NULL, min = 1901,max = 2015,value = 2015,
                 sep = "",width='300px'
               ),
uiOutput("a"),
actionButton("rdButton","Get Chart")
),
        dimpleOutput("plot_RD")
        
      )
      
    ),
   
tabItem(
  "mvp",
  box(width=8,
    status = "success", solidHeader = TRUE,
    title = "MVP winners compared with Top WAR Ranked (click point for details)",
    radioButtons("mvpChoice",NULL,choices=c("Rank","Value"),inline=T),
  ggvisOutput("rankWAR")
  ),
  box(width=4,
      status = "success", solidHeader = TRUE,
      title = "Summary",
     
     DT::dataTableOutput("table")
  )
),

tabItem("divRaces",
        box(
          status = "success", solidHeader = TRUE,
          title = "Divison Races - Hover for game details Zoom and other options available",
          radioButtons("race_lg",NULL,c("AL","NL"), inline=T),
          radioButtons("race_div",NULL,c("East","West","Central"),inline=T),
          h5("N.B.Central Division from 1994 on"),
          sliderInput("race_yr","Year",value=2015,min=1969,max=2015,sep=""),
         
          plotlyOutput("divRace")
        )),
    
    
    tabItem("info",includeMarkdown("info.md"))
    
  ))
)
