library(RJDBC)
library(mmlib)
library(readr)

db <- 
  vertica_connect(
    Sys.getenv("user"), 
    Sys.getenv("pw"), 
    Sys.getenv("vertica_url")
  )