tab2UI <- function(id){
  ns <- NS(id)
  tagList(
    conditionalPanel(
      "output.logged_in",
      #Tab contents goes here
      fluidRow(
        box(
          title = "Slider Form",
          width = 6,
          sliderInput(
            ns("slider1"), 
            label = "Slider 1",
            min = 1,
            max = 10,
            value = 5
          )
        ),
        box(
          title = "Slider Output",
          width = 6,
          span(
            "Slider 1 Selection: ", 
            textOutput(ns("outfield1"))
          )
        )
      )
    )
  )
}

tab2Server <- function(input, output, session){
  output$outfield1 <- renderText({
    input$slider1
  })
}