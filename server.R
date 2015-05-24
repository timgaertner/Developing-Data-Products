library(caret)
library(e1071)
data(iris)
Obs <- iris

model.fn1 <- function(TrainingSize) {
        set.seed(1)
        inTrain <- createDataPartition(y = Obs$Species, 
                                       p=TrainingSize,
                                       list = F)
        training <- Obs[inTrain,]
        testing <- Obs[-inTrain,] 
        
        library(party)
        
        ctreeTune <- ctree(Species ~ ., data=training)
        
        library(caret)
        library(e1071)
        
        confMat <- confusionMatrix(testing$Species,predict(ctreeTune,testing[,-length(names(testing))]))$table
        # create confustion table to display results 
        confusion.matrix = data.frame(confMat[1:3],confMat[4:6],confMat[7:9]) 
        rows <- c("(pred) setosa", "veriscolor", "virginica") 
        cols <- c("(actual) setosa", "veriscolor", "virginica") 
        row.names(confusion.matrix) <- rows 
        colnames(confusion.matrix) <- cols 
              
        confusion.matrix # return confusion table to display 
        
}

model.fn2 <- function(TrainingSize) {
        set.seed(1)
        inTrain <- createDataPartition(y = Obs$Species, 
                                       p=TrainingSize,
                                       list = F)
        training <- Obs[inTrain,]
        testing <- Obs[-inTrain,] 
        
        library(party)
        
        ctreeTune <- ctree(Species ~ ., data=training)
        
        library(caret)
        library(e1071)
        
        confMat <- confusionMatrix(testing$Species,predict(ctreeTune,testing[,-length(names(testing))]))
        confMatAcc <- data.frame(confMat$overall)
        Acc <- round(confMatAcc$confMat.overall[1],3)
        Acc
        
}


shinyServer(
        function(input, output) {
                output$confMat <- renderTable({model.fn1(input$TrainingSize)})
                output$accuracyRate <- renderText({model.fn2(input$TrainingSize)})
                output$startingOut <- renderText('Step 1: Enter a number between 0.1 and 0.99 to represent the proportion of labeled cases to assign the training set used to build the supervised model.
                                                 Step 2: View the table of Actual versus Predicted results from the test data set aside and scored by the model.
                                                 Step 3: View the accuracy achieved by the model on the test data.
                                                 Step 4: Adjust the training proportion to try and achieve a higher accuracy percentage.')
        }
)