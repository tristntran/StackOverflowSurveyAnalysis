#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Who are Stack Overflow Users?"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          checkboxGroupInput("learnInput", "How They Learned to code:",
                             choiceNames =
                               list("Books / Physical media",
                                    "Friend or family member",
                                    "Other online resources (e.g., videos, blogs, forum)",
                                    "School (i.e., University, College, etc)",
                                    "On the job training",               
                                    "Online Courses or Certification",
                                    "Coding Bootcamp",                   
                                    "Colleague",
                                    "Other (please specify):",
                                    "Hackathons (virtual or in-person)"),
                             choiceValues =
                               list("Books / Physical media",
                                    "Friend or family member",
                                    "Other online resources (e.g., videos, blogs, forum)",
                                    "School (i.e., University, College, etc)",
                                    "On the job training",               
                                    "Online Courses or Certification",
                                    "Coding Bootcamp",                   
                                    "Colleague",
                                    "Other (please specify):",
                                    "Hackathons (virtual or in-person)"),
                             selected =
                               list("Books / Physical media",
                                    "Friend or family member",
                                    "Other online resources (e.g., videos, blogs, forum)",
                                    "School (i.e., University, College, etc)",
                                    "On the job training",               
                                    "Online Courses or Certification",
                                    "Coding Bootcamp",                   
                                    "Colleague",
                                    "Other (please specify):",
                                    "Hackathons (virtual or in-person)"),
          ),
          checkboxGroupInput("ageInput", "What Age are they?",
                             choiceNames =
                               list("Under 18 years old", "18-24 years old",
                                    "25-34 years old", "35-44 years old",
                                    "45-54 years old", "55-64 years old",
                                    "65 years or older", "Prefer not to say"),
                             choiceValues =
                               list("Under 18 years old", "18-24 years old",
                                    "25-34 years old", "35-44 years old",
                                    "45-54 years old", "55-64 years old",
                                    "65 years or older", "Prefer not to say"),
                            selected = list("Under 18 years old", "18-24 years old",
                                            "25-34 years old", "35-44 years old",
                                            "45-54 years old", "55-64 years old",
                                            "65 years or older", "Prefer not to say")
          ),
          checkboxGroupInput("mainBranchInput", "Which of the following options best describes you today?",
                             choiceNames =
                               list("None of these",
                                    "I am a developer by profession",
                                    "I am not primarily a developer, but I write code sometimes as part of my work",
                                    "I code primarily as a hobby",
                                    "I am learning to code",
                                    "I used to be a developer by profession, but no longer am"),
                             choiceValues =
                               list("None of these",
                                    "I am a developer by profession",
                                    "I am not primarily a developer, but I write code sometimes as part of my work",
                                    "I code primarily as a hobby",
                                    "I am learning to code",
                                    "I used to be a developer by profession, but no longer am"),
                             selected =
                               list("None of these",
                                    "I am a developer by profession",
                                    "I am not primarily a developer, but I write code sometimes as part of my work",
                                    "I code primarily as a hobby",
                                    "I am learning to code",
                                    "I used to be a developer by profession, but no longer am")
          ),
          sliderInput("workExpInput", label = h3("Years Work Experience:"), min = 0, 
                      max = 50, value = c(0, 50))
        ),

        # Show a plot of the generated distribution
        mainPanel(
          # plotlyOutput("nLangsPlot"),
          tabsetPanel(type = "tabs",
                      # number of languages exploration
                      tabPanel(
                        "Gender Demographics By Age",
                        h2("Genders of developers"),
                        plotlyOutput("genderPie"),
                        plotlyOutput("ismanPlot"),
                        plotlyOutput("ismanPlotRev")
                      ),
                      tabPanel(
                        "General Statistics",
                        h2("Do people who know more languages want to know more?"),
                        plotlyOutput("nLangsPlot"),
                        h4("The more languages people have worked with, the more they tend to want to learn."),
                        plotlyOutput("usagePlot"),
                        h4("Stack overflow visit frequency colored by work experience"),
                        h2("Distributions of Age and Work Experience below"),
                        h4("select all on the slider to see survey representative results."),
                        plotlyOutput("WorkExpPlot"),
                        plotlyOutput("age_plot")
                        ),
                      tabPanel(
                        "Block Chain",
                        h2("How do programmers feel about blockchain"),
                        h4("In general we see a negative correlation between age and work experience and block chain favorability. This is probably explained by some aversion to new technology or indifference towards technologies outside of scope"),
                        h3("Favorability by Age Group"),
                        plotlyOutput("blockChainAgePlot"),
                        h3("Favorability by Branch of Programming"),
                        plotlyOutput("blockChainBranchPlot"),
                        h3("Favorability by Years Experience"),
                        plotlyOutput("blockChainExpPlot")
                        ),
                      tabPanel(
                        "Mental Health",
                        checkboxInput("noneHealthInput",
                                      'Include "None of the above"',
                                      TRUE),
                        h3("Mental health and age"),
                        plotlyOutput("healthPlotAge"),
                        h3("Main Branch and Mental health"),
                        plotlyOutput("healthPlotBranch"),
                        h3("Mental Health and years of Experience"),
                        plotlyOutput("healthPlotExp")
                        )
                      )
          )
        )
    ))
