library(shiny)

# Define UI for application that draws a plot of the data
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Non-Linear HBS Effect"),
        
        # Sidebar with a slider input for the number of bins
        sidebarLayout(
                sidebarPanel(
                        helpText("Visualise non-linear HBS effect by creating
                                 an adjusted GDP level which is inverted for values 
                                 of real GDP per capita below a set level."),
                        
                        selectInput("country", 
                                    label = "Choose a country to display",
                                    choices = list("CHINA", "INDIA",
                                                   "INDONESIA", "JAPAN",
                                                   "KOREA","MALAYSIA",
                                                   "SINGAPORE","THAILAND"),
                                    selected = "INDIA"),
                        
                        sliderInput("cutoff",
                                    "GDP Per Capita Threshold $US(1990):",
                                    min = 0,
                                    max = 5000,
                                    value = 1000
                                    )
                ),
                
                # Show a plot 
                mainPanel(
                        plotOutput("Plot")
                )
        )
))
