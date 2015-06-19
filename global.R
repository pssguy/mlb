# load libraries

library(plyr) # need for .function and has to be loaded before dplyr
library(dplyr)
#library(ggvis)
#library(tidyr)
library(readr)
#library(leaflet)
library(shiny)
library(shinydashboard)
#library(htmlwidgets)
#library(DT)
library(ggplot2)
library(XML)
library(stringr)

# load requisite files
#teamYears <- read_csv("teamYears.csv")
teamYears <- read_csv("teamIDYears.csv")
print(names(teamYears))
print("end global")