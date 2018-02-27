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
#source("account_functions.R")

# Load Modules-----------------------------------------------------------------
for (module_file in list.files("modules", pattern = "\\.R$")) {
  source(file.path("modules", module_file))
}

jscode <- '
$(function() {
var $els = $("[data-proxy-click]");
$.each(
$els,
function(idx, el) {
var $el = $(el);
var $proxy = $("#" + $el.data("proxyClick"));
$el.keydown(function (e) {
if (e.keyCode == 13) {
$proxy.click();
}
});
}
);
});
'