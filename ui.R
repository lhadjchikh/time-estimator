library(shiny)

shinyUI(fluidPage(
        tags$head(
                tags$style(HTML("
                        .results-panel {
                                font-size: 1.5em;
                                padding: 2em;
                        }
                        .instructions {
                                font-size: 1.1em;
                                padding: 3em 1.5em;
                        }   
                        .shiny-bound-output, .result-label div {
                                display: inline;
                        }
                        .result-label {
                                width: 10em;
                                text-align: right;
                                float: left;
                                padding-right: 0.5em;
                        }
                "))
        ),
        titlePanel("Task Time Estimator"),
        sidebarLayout(
                sidebarPanel(
                        numericInput("bestEst",
                                     "Most Probable Time:",
                                     value = 10,
                                     min = 1,
                                     step = 1
                        ),
                        numericInput("minEst",
                                     "Optimistic Time:",
                                     value = 5,
                                     min = 1,
                                     step = 1
                        ),
                        numericInput("maxEst",
                                     "Pessimistic Time:",
                                     value = 20,
                                     min = 1,
                                     step = 1
                        ),
                        radioButtons("confInt",
                                     "Confidence Interval:",
                                     choices = list("68.3%" = 1, "95.5%" = 2)
                        )
                ),
                mainPanel(
                        tabsetPanel(
                                tabPanel("Results",
                                         div(
                                                 class="results-panel",
                                                 div(
                                                         div(class="result-label","Expected Time = "),
                                                         div(class="result", textOutput("exp"))
                                                 ),
                                                 div(
                                                         div(class="result-label",
                                                             conditionalPanel(
                                                                     condition = "input.confInt == 1",
                                                                     span("68.3%")
                                                             ),
                                                             conditionalPanel(
                                                                     condition = "input.confInt == 2",
                                                                     span("95.5%")
                                                             ),
                                                             span(class = "result", "C.I. = ")
                                                         ),
                                                         div(class="result", textOutput("ci"))
                                                 )
                                         )),
                                tabPanel("Instructions",
                                         p(
                                                 class="instructions",
                                                "To estimate a task time, enter a value for Most Probable Time, 
                                                Optimistic Time (best-case scenario), and Pessimistic Time 
                                                (worst-case scenario), and select a confidence interval width.
                                                The calculations are unitless, so time values can represent
                                                hours, days, or weeks, etc., as long all values are in the same time units."
                                         )
                                )
                        )
                )
        )
))
