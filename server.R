library(shiny)

shinyServer(function(input, output) {
        
        expected <- reactive({
                validate(
                        need(input$minEst < input$maxEst, "time_o must be less than time_p")
                )
                validate(
                        need(input$minEst < input$bestEst, "time_o must be less than time_m")
                )
                validate(
                        need(input$bestEst < input$maxEst, "time_e must be less than time_p")
                )
                (input$minEst + (input$bestEst * 4.0) + input$maxEst) / 6.0
        })
        
        deviation <- reactive({
                conf.factor <- as.numeric(input$confInt)
                sigma <- (input$maxEst - input$minEst) / 6.0
                conf.factor * sigma
        })
        
        output$exp <- renderText({
                paste(round(expected(), digits=1))
        })
        
        output$ci <- renderText({
                exp <- expected()
                dev <- deviation()
                min <- round(exp - dev, digits=1)
                max <- round(exp + dev, digits=1)
                paste("[", min, ",", max, "]")
        })

})
