tab1 <- tabItem(
  "tab1",
  #Wrap sensitve tabs in this conidtional panel, login required
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
