shinyUI({
  # Header ----
  # Define dashboard header, title is displayed in upper left corner
  # Logo appears in upper right corner
  header <- dashboardHeader(

    #Dashboard Title
    title = "MM Shiny Base",
    titleWidth = "225px",

    #Dashboard Logo
    tags$li(img(src = "mm.jpg", height = "50px"),
      class = "dropdown"))

  # Sidebar ----
  # Add tab entries and other sidebar items here
  sidebar <- dashboardSidebar(
    sidebarMenu(
      uiOutput("userpanel"),
      menuItem("Tab1", tabName = "tab1",
        icon = icon("bar-chart")),
      menuItem("Tab2", tabName = "tab2",
        icon = icon("cog"))
    )
  )

  # Tabs ----
  # Source tab ui files here
  source("modules/tab1_ui.R", local = TRUE)
  source("modules/tab2_ui.R", local = TRUE)

  # Body ----
  body <- dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "mm.css")
    ),
    conditionalPanel(
      condition = "!output.logged_in",
      column(6,
        offset = 3,
        wellPanel(textInput("user", label = "Username"),
          passwordInput("pw", label = "Password"),
          actionButton("login", label = "Log In",
            align = "center", width = "85px"),
          h4(textOutput("login_info"), align = "center")
        )
      )
    ),
    tabItems(tab1, tab2)
  )

  # Dashboard Page ----
  # Brigning it all together, title represents browser tab title
  dashboardPage(header, sidebar, body, title = "MM Shiny Base")

})
