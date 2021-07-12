library(shiny)
library(tidyr)
library(dplyr)
library(ggplot2)

# Define server logic required to run a t-test and draw a barplot
shinyServer(function(input, output,session) {
        sample1<-reactive({rnorm(n=input$n_samp1,mean=input$mean_samp1,sd=input$sd1)}) #creates reactive expression based on UI inputs; sample1 is random draw from N dist
        sample2<-reactive({rnorm(n=input$n_samp2,mean=input$mean_samp2,sd=input$sd2)})
        t_test<-reactive({t.test(sample1(),sample2())})#runs t-test
    observeEvent(input$submit_button,{ #observeEvent allows outputs to change when submit button is clicked
        output$t_val<-renderText({ #extracts the t-value from t-test and outputs to UI
            isolate(paste("t-value: ", round(t_test()$statistic,3))) #isolate() tells Shiny to calculate only when submit button is clicked
        })
        output$p_val<-renderText({
            isolate(paste("p-value: ", round(t_test()$p.value,5)))
        })
        output$CI<-renderText({
            isolate(paste0("95% confidence interval: (",  #paste0 function 
                  round(t_test()$conf.int[1],3),
                  ", ",
                  round(t_test()$conf.int[2],3),
                  ")"))
        })
    })
    
    observeEvent(input$submit_button,{
        output$barplot<-renderPlot({
            isolate(samp1<-tibble(Sample=rep("s1",input$n_samp1),Value=sample1()))
            isolate(samp2<-tibble(Sample=rep("s2",input$n_samp2),Value=sample2()))
            isolate(shiny_data<-bind_rows(samp1,samp2))
            isolate(ggplot(shiny_data,aes(Sample,Value)) + 
                geom_bar(stat="summary", width=0.5,fill="steel blue") + 
                geom_errorbar(stat="summary",width=0.2) +
                labs(x="Sample",y="Mean +- 1 SE")) +
                scale_y_continuous(expand=expansion(mult=c(0,.1))) +
                theme_classic(base_size=20)
            })
        })
})

       




