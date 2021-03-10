

library(shiny)

data(diamonds)

shinyServer(function(input, output) {

    library(dplyr)
    library(ggplot2)
    diamonds2 <- select(diamonds, -table, -x, -y, -z)
    
    diamondsSub <- reactive({
        diamonds2[diamonds2$cut == input$Cut & diamonds2$clarity == input$Clarity & diamonds2$color == input$Color , ]
    })
    
    linModel <- reactive({
        with(diamondsSub(), lm(price ~ carat))
    })
    
    logModel <- reactive({
        with(diamondsSub(), lm(log(price) ~ carat))
    })
    
    output$plot <- renderPlot({
        if(input$ModelType == FALSE){
            p <- ggplot(diamondsSub(), aes(x=carat, y=price)) + geom_point(color="blue") + geom_smooth(method = "lm", formula = y~x, se=FALSE, size=2, color="red")
            p
        } else{
            caratSequence <- data.frame(carat = seq(min(diamondsSub()$carat), max(diamondsSub()$carat), by = .005 ))
            predLog <- predict(logModel(), caratSequence)
            predPrice <- exp(predLog)
            dataPred <- data.frame(carat = caratSequence, price = predPrice)
            p <- ggplot(dataPred, aes(x=carat, y=price), ) + geom_point(color="red", size=1) + geom_point(data=diamondsSub(), color="blue")
            p
        }
    })
    
    output$summaryTable <- renderTable({
        summary(diamondsSub())
    })
    
    output$model <- renderText({
        if(input$ModelType == FALSE){
            results <- paste("y vs x model -------- Intercept = ", round(linModel()$coefficients[1],2), "Slope = ", round(linModel()$coefficients[2],2))
        }else{
            results <- paste("log(y) vs x model -------- Intercept = ", round(logModel()$coefficients[1],2), "Slope = ", round(logModel()$coefficients[2],2))
        }
        results
    })

})
