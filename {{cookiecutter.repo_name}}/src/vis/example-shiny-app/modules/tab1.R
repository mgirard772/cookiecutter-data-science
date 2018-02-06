tab1UI <- function(id){
  tagList(
    conditionalPanel(
      "output.logged_in",
      #Tab contents goes here
      fluidRow(
        column(
          12,
          h3("Congratulations, you've logged in successfully.
            Content in this tab is now visible.")
          )
        )
      )
  )
}

tab1Server <- function(input, output, session){
  
}