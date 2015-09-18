# load libraries
# need for .function and has to be loaded before dplyr
library(plyr)
library(dplyr)
library(readr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(XML)
library(stringr)
library(markdown)
library(ggvis)

# load requisite files

## rundifferentials
teamYears <- read_csv("teamIDyears.csv")

## awards
## data can be found https://github.com/pssguy/mlb/blob/master/MVPvoting.csv
mvpVotes <- read_csv("MVPvoting.csv")

print(glimpse(mvpVotes))
