#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(quantmod)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Stock Chart in R"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel("Select stock",
            selectInput("stock",
                        label = "Stock",
                        choices = c("Apple"="AAPL", "Cisco"="CSCO",
                                    "IBM"="IBM", "Facebook"="FB",
                                    "Twitter"="TWTR", "Microsoft"="MSFT",
                                    "Google"="GOOG"))
        ),
        # Show a plot of the generated distribution
        mainPanel("Stock Chart",
                  plotOutput("stockchart")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$stockchart <- renderPlot({
        stockdata <- getSymbols(input$stock, src = "yahoo",
                                from = "2017-01-01",
                                to = "2017-08-21",
                                auto.assign = FALSE)
        candleChart(stockdata, name=input$stock)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
