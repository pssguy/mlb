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

# load requisite files

teamYears <- read_csv("teamIDYears.csv")
