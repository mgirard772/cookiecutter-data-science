tab2UI <- function(id){
  tagList(
    conditionalPanel(
      "output.logged_in",
      #Tab contents goes here
      fluidRow(
        column(
          12,
          h3("Tab 2 is also visible.")
          )
        )
      )
    )
}

tab2Server <- function(input, output, session){
  
}