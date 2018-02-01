library(shiny)
library(shinydashboard)
library(DT)
library(RJDBC)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(ggplot2)
library(scales)
library(shinyBS)
library(digest)
library(zoo)

# Define global variables, functions, etc. here
approved_users <-
  data.frame(
    "user" = c("test"),
    password = c(digest("test", algo = "md5"))
  )
