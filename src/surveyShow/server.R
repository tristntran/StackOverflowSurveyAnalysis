#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  d_split <- reactive({
    if (!input$noneHealthInput)
    {df_split %>% 
        filter(input$workExpInput < WorkExp,
               WorkExp < input$workExpInput[2],
               LearnCode %in% input$learnInput,
               Age %in% input$ageInput,
               MainBranch %in% input$mainBranchInput,
               MentalHealth != "None of the above")
      }
    else {
      df_split %>% filter(input$workExpInput < WorkExp,
            WorkExp < input$workExpInput[2],
            LearnCode %in% input$learnInput,
            Age %in% input$ageInput,
            MainBranch %in% input$mainBranchInput)
      }
    })
  d_whole <- reactive({
    df_whole %>% filter(ResponseId %in% d_split()$ResponseId
    )})
  # age vs work experience graph
  # gender breakdown graph pie chart
  output$ismanPlot<- renderPlotly({ggplotly(d_whole() %>% ggplot() +
      aes(y = Gender, fill = Age) + geom_bar())})
  output$ismanPlotRev<- renderPlotly({ggplotly(d_whole() %>% ggplot() +
      aes(y = Age, fill = Gender) + geom_bar())})
  output$genderPie <- renderPlotly({
    ggplotly(d_whole() %>% ggplot() + aes(x = Gender, fill=Gender) + geom_bar())
    })
  # graph on average use stack overflow with breakdown triple bar graph
  # SOVisitFreq
  output$usagePlot <- renderPlotly({
    ggplotly(d_whole() %>% ggplot(aes(y = SOVisitFreq,
                                      fill = WorkExpBin)) + geom_bar())})
  # blockchain favorability graph
  # more!!!
  output$blockChainAgePlot <- renderPlotly({
    ggplotly(d_whole() %>% ggplot(aes(x=Blockchain, fill = Age)) +
               geom_bar())})
  
  output$blockChainBranchPlot <- renderPlotly({
    ggplotly(d_whole() %>% ggplot(aes(x=Blockchain,
                                      fill = MainBranch)) +
               geom_bar()
             )
    })
  
  output$blockChainExpPlot <- renderPlotly({
    ggplotly(d_whole() %>% ggplot(aes(x=Blockchain,
                                      fill = WorkExpBin)) + geom_bar())})
  # nlanguages want vs have
  # more graphs here
  output$nLangsPlot <- renderPlotly({
    ggplotly(d_whole() %>% ggplot() +
      aes(x=nLanguageHaveWorkedWith, y = nLanguagesWant) +
        geom_count())})
  # mental Health
  # more graphs here
  output$healthPlotAge <- renderPlotly({
    ggplotly(
      d_split() %>% ggplot() +
        aes(y = MentalHealth, fill = Age) + geom_bar()
      )})
  output$healthPlotExp <- renderPlotly({
    ggplotly(
      d_split() %>% ggplot() +
        aes(y = MentalHealth, fill = WorkExpBin) + geom_bar()
      )
    })
  output$healthPlotBranch <- renderPlotly({
    ggplotly(d_split() %>% ggplot() +
               aes(y = MentalHealth, fill = MainBranch ) + geom_bar())
    })
  output$healthPlotBranchNoNone <- renderPlotly({ggplotly(d_split() %>%
                                                    ggplot() +
                                                    aes(y = MentalHealth, fill = MainBranch ) +
                                                    geom_bar())})
})
