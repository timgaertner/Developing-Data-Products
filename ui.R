library(shiny)
library(caret)
library(e1071)
shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Train Your Model App: iris data illustrated"),
                
                sidebarPanel(
                        numericInput(inputId = 'TrainingSize',label = 'Proportion of Cases for Model Training',value = .5, min = .1, max = .99, step = 1),
                        submitButton('Run')
                ),
                mainPanel(
                        tabsetPanel(
                                tabPanel('Application',
                                         h4('Confusion Matrix Output'),
                                         tableOutput("confMat"),
                                         h4('Overall Accuracy on Test Data'),
                                         textOutput("accuracyRate")
                                         ),
                                tabPanel('Getting_Started',textOutput("startingOut"))
                                )
                )
        ))