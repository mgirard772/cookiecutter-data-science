tab2 <- tabItem(
  "tab2",
  #Wrap sensitve tabs in this conidtional panel, login required
  conditionalPanel(
    "output.logged_in",
    #Tab contents goes here
    fluidRow(
      column(
        12,
        h3("Tab 2 is also now visible.")
      )
    )
  )
)
