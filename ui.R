
library(shiny)

shinyUI(fluidPage(

    titlePanel("Diamond Data"),

    sidebarLayout(
        sidebarPanel(
            selectInput("Cut", "Select a cut:", c("Fair", "Good", "Very Good", "Premium", "Ideal")),
            selectInput("Clarity", "Select a clarity:(worst to best)", c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF")),
            selectInput("Color", "Select a color:(worst to best)", c("D", "E", "F", "G", "H", "I", "J")),
            checkboxInput("ModelType", "Check the box if you would like a log(price) vs carat model", value = FALSE),
            hr(),
            hr(),
            h4("DIRECTIONS FOR USE"),
            h6("Select a subset of the diamonds data set by choosing a cut, clarity, and color from the drop-down menus in the sidebar."),
            h6("Also check or uncheck the box to indicate whether you would like a linear model or an exponential model fitted to the data"),
            h6("The graph, summary, and model information information will be updated immediately."),
            h6("Click on any of the tabs to the right of the dropdown menus to view information about the data and the models.")
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("Plot of Data and Fitted Data", plotOutput("plot")),
                tabPanel("Summary of Chosen Data Set", tableOutput("summaryTable")),
                tabPanel("Model Information", textOutput("model"))
            )
           
        )
    )
))
