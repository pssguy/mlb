# load libraries
# need for .function and has to be loaded before dplyr (look at whether still necessary)
library(plyr) 

library(readr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(XML)
library(stringr)
library(markdown)
library(ggvis)
library(rcdimple)
library(plotly)
library(explodingboxplotR)
library(dplyr) # looks like another package might include plyr so moved to bottom

# load requisite files

## rundifferentials
teamYears <- read_csv("teamIDyears.csv")

## awards
## data can be found https://github.com/pssguy/mlb/blob/master/MVPvoting.csv
mvpVotes <- read_csv("MVPvoting.csv")

#print(glimpse(mvpVotes))

#divRaces <- read_csv("finalRaw1969toDate.csv")
#divRaces <- read_csv("finalRaw19692015.csv")

divRaces <- read_csv("allRes1969toDate.csv")