library(shiny)

# Define UI for application that draws a bar plot and runs a t-test
shinyUI(fluidPage(

    # Application title
    titlePanel("t-test Shiny Application"),

    # Sidebar with numeric inputs for mean and n's and slidrs for st devs
    sidebarLayout(
        sidebarPanel(
            numericInput("n_samp1","Enter the size of sample 1",value=0), #first of four text boxes for n's and means
            numericInput("n_samp2","Enter the size of sample 2",value=0),
            numericInput("mean_samp1","Mean of population 1",value=0),
            numericInput("mean_samp2","Mean of population 2",value=0),
            sliderInput("sd1","Standard deviation of population 1",min=0.5,max=20,value=1,step=0.5), #slider input for pop1
            sliderInput("sd2","Standard deviation of population 2",min=0.5,max=20,value=1,step=0.5),
            actionButton("submit_button","Submit")), #creates submit button
            
        # Show a plot of the generated distribution and return t-test stats
        mainPanel(
            tabsetPanel(type="tabs", #creates tabs: 1) stats and bar graph and 2) info and link to code
                tabPanel("Stats and barplot", #first tab
                    tags$br(), #inserts line break
                    textOutput("t_val"), #outputs t-statistic from t-test
                    textOutput("p_val"), #p-value
                    textOutput("CI"), #confidence interval
                    plotOutput("barplot")), #plots barplot
                tabPanel("Instructions and Code", tags$p( #second tab; tags$p creates a paragraph
                    tags$br(), #line break
                    "This Shiny application allows a user to perform an unpaired t-test on samples pulled from
                    normal distributions. Their sample sizes and the means and standard deviations of their populations
                    can be specified using the text boxes and sliders on the left pane. Clicking on the submit button
                    returns the t-statistic, p-value, and 95% confidence interval as well as a barplot of sample
                    means with standard errors. Adjust the inputs to understand how they impact the test
                    statistics and distributions of samples.",
                    tags$br(), #line break separates background info (above) and sentence below about code link
                    tags$br(), #creates line spacde
                    "If you would like to see the code for this Shiny app, 
                    please visit my",
                    tags$a(href="https://github.com/kpost34/t_tester_shiny_app", #tags$a creates a hyperlink to Github
                    "Github repo"),".") 
                )
            )
        )
    )
))


