tab1UI <- function(id){
  ns <- NS(id)
  tagList(
    conditionalPanel(
      "output.logged_in",
      #Tab contents goes here
      fluidRow(
        box(
          title = "Text Field Form",
          width = 6,
          textInput(ns("field1"), label = "Enter Some Text"),
          actionButton(ns("button1"), label = "Submit")
        ),
        box(
          title = "Form Output",
          width = 6,
          textOutput(ns("outfield1"))
        )
      )
    )
  )
}

tab1Server <- function(input, output, session){
  observeEvent(input$button1, {
    output$outfield1 <- renderText({
      isolate(input$field1)
    })
  })
}