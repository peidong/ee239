# require(nnet)
# require(caret)
library(pracma)
library(randomForestSRC)
# library(neuralnet)
# library(randomForest)
network_database <- read.csv(file = "network_backup_dataset.csv", header = TRUE, sep = ",")

#####################################################
#
#   Generate new linear model database for training
#   Begin
#
#####################################################
network_database_linear_model <- list(network_database[[1]])
names(network_database_linear_model)[1] <- "Week"
temp_vector <- c()
for (i in 1:length(network_database[[1]])){
    if (network_database[[2]][i] == "Monday"){
        temp_vector <- append(temp_vector, 1)
    }
    if (network_database[[2]][i] == "Tuesday"){
        temp_vector <- append(temp_vector, 2)
    }
    if (network_database[[2]][i] == "Wednesday"){
        temp_vector <- append(temp_vector, 3)
    }
    if (network_database[[2]][i] == "Thursday"){
        temp_vector <- append(temp_vector, 4)
    }
    if (network_database[[2]][i] == "Friday"){
        temp_vector <- append(temp_vector, 5)
    }
    if (network_database[[2]][i] == "Saturday"){
        temp_vector <- append(temp_vector, 6)
    }
    if (network_database[[2]][i] == "Sunday"){
        temp_vector <- append(temp_vector, 7)
    }
}
network_database_linear_model[[2]] <- temp_vector
names(network_database_linear_model)[2] <- "DayOfWeek"
network_database_linear_model[[3]] <- network_database[[3]]
names(network_database_linear_model)[3] <- "StartTime"
temp_vector <- c()
for (i in 1:length(network_database[[4]])){
    if (network_database[[4]][i] == "work_flow_0"){
        temp_vector <- append(temp_vector, 1)
    }
    if (network_database[[4]][i] == "work_flow_1"){
        temp_vector <- append(temp_vector, 2)
    }
    if (network_database[[4]][i] == "work_flow_2"){
        temp_vector <- append(temp_vector, 3)
    }
    if (network_database[[4]][i] == "work_flow_3"){
        temp_vector <- append(temp_vector, 4)
    }
    if (network_database[[4]][i] == "work_flow_4"){
        temp_vector <- append(temp_vector, 5)
    }
}
network_database_linear_model[[4]] <- temp_vector
names(network_database_linear_model)[4] <- "WorkFlowName"
temp_vector <- c()
for (i in 1:length(network_database[[5]])){
    if (network_database[[5]][i] == "File_0"){
        temp_vector <- append(temp_vector, 1)
    }
    if (network_database[[5]][i] == "File_1"){
        temp_vector <- append(temp_vector, 2)
    }
    if (network_database[[5]][i] == "File_2"){
        temp_vector <- append(temp_vector, 3)
    }
    if (network_database[[5]][i] == "File_3"){
        temp_vector <- append(temp_vector, 4)
    }
    if (network_database[[5]][i] == "File_4"){
        temp_vector <- append(temp_vector, 5)
    }
    if (network_database[[5]][i] == "File_5"){
        temp_vector <- append(temp_vector, 6)
    }
    if (network_database[[5]][i] == "File_6"){
        temp_vector <- append(temp_vector, 7)
    }
    if (network_database[[5]][i] == "File_7"){
        temp_vector <- append(temp_vector, 8)
    }
    if (network_database[[5]][i] == "File_8"){
        temp_vector <- append(temp_vector, 9)
    }
    if (network_database[[5]][i] == "File_9"){
        temp_vector <- append(temp_vector, 10)
    }
    if (network_database[[5]][i] == "File_10"){
        temp_vector <- append(temp_vector, 11)
    }
    if (network_database[[5]][i] == "File_11"){
        temp_vector <- append(temp_vector, 12)
    }
    if (network_database[[5]][i] == "File_12"){
        temp_vector <- append(temp_vector, 13)
    }
    if (network_database[[5]][i] == "File_13"){
        temp_vector <- append(temp_vector, 14)
    }
    if (network_database[[5]][i] == "File_14"){
        temp_vector <- append(temp_vector, 15)
    }
    if (network_database[[5]][i] == "File_15"){
        temp_vector <- append(temp_vector, 16)
    }
    if (network_database[[5]][i] == "File_16"){
        temp_vector <- append(temp_vector, 17)
    }
    if (network_database[[5]][i] == "File_17"){
        temp_vector <- append(temp_vector, 18)
    }
    if (network_database[[5]][i] == "File_18"){
        temp_vector <- append(temp_vector, 19)
    }
    if (network_database[[5]][i] == "File_19"){
        temp_vector <- append(temp_vector, 20)
    }
    if (network_database[[5]][i] == "File_20"){
        temp_vector <- append(temp_vector, 21)
    }
    if (network_database[[5]][i] == "File_21"){
        temp_vector <- append(temp_vector, 22)
    }
    if (network_database[[5]][i] == "File_22"){
        temp_vector <- append(temp_vector, 23)
    }
    if (network_database[[5]][i] == "File_23"){
        temp_vector <- append(temp_vector, 24)
    }
    if (network_database[[5]][i] == "File_24"){
        temp_vector <- append(temp_vector, 25)
    }
    if (network_database[[5]][i] == "File_25"){
        temp_vector <- append(temp_vector, 26)
    }
    if (network_database[[5]][i] == "File_26"){
        temp_vector <- append(temp_vector, 27)
    }
    if (network_database[[5]][i] == "File_27"){
        temp_vector <- append(temp_vector, 28)
    }
    if (network_database[[5]][i] == "File_28"){
        temp_vector <- append(temp_vector, 29)
    }
    if (network_database[[5]][i] == "File_29"){
        temp_vector <- append(temp_vector, 30)
    }
}
network_database_linear_model[[5]] <- temp_vector
names(network_database_linear_model)[5] <- "FileName"
network_database_linear_model[[6]] <- network_database[[6]]
names(network_database_linear_model)[6] <- "SizeBackup"
network_database_linear_model[[7]] <- network_database[[7]]
names(network_database_linear_model)[7] <- "TimeBackup"
#####################################################
#
#   Generate new linear model database for training
#   End
#
#####################################################


#####################################################
#
#   10 folds
#   Begin
#
#####################################################
data_network_database <- data.frame(matrix(unlist(network_database_linear_model), ncol=7))
for (j in 1:7){
    if (j == 1){
        names(data_network_database)[j] <- "Week"
    } else if (j == 2){
        names(data_network_database)[j] <- "DayOfWeek"
    } else if (j == 3){
        names(data_network_database)[j] <- "StartTime"
    } else if (j == 4){
        names(data_network_database)[j] <- "WorkFlowName"
    } else if (j == 5){
        names(data_network_database)[j] <- "FileName"
    } else if (j == 6){
        names(data_network_database)[j] <- "SizeBackup"
    } else if (j == 7){
        names(data_network_database)[j] <- "TimeBackup"
    }
}

#Problem 3 part 2
#polynomial model
fold_num = 10 #Folds
data_network_database$id <- sample(1:fold_num, nrow(data_network_database), replace = TRUE)
list <- 1:fold_num
best_RMSE_difference_poly <- 1000.0
result_temp_poly <- data.frame()
fit_poly_best <- list()
degree_vector <- c()
RMSE_vector <- c()
for (i_degree in 1:34){
    sum_RMSE_difference_poly <- 0
    for (i in 1:fold_num){
        # remove rows with id i from dataframe to create training set
        # select rows with id i to create test set
        trainingset <- subset(data_network_database, id %in% list[-i])
        testset <- subset(data_network_database, id %in% c(i))

        # run a poly regression model
        fit_poly <- lm(SizeBackup ~ poly(Week, i_degree, raw=TRUE) + poly(DayOfWeek, i_degree, raw=TRUE) + poly(StartTime, i_degree, raw=TRUE) + poly(WorkFlowName, i_degree, raw=TRUE) + poly(FileName, i_degree, raw=TRUE) + poly(TimeBackup, i_degree, raw=TRUE), data=trainingset)

        temp_prediction_poly <- as.data.frame(predict(fit_poly, newdata=testset[,-6]))
        # append this iteration's predictions to the end of the prediction_poly data frame
        result_temp_poly <- cbind(temp_prediction_poly, as.data.frame(testset[,6]))
        names(result_temp_poly) <- c("Predicted", "Actual")
        result_temp_poly$Difference <- abs(result_temp_poly$Actual - result_temp_poly$Predicted) ^ 2
        temp_poly_RMSE <- sqrt(sum(result_temp_poly$Difference) / length(result_temp_poly$Difference))
        sum_RMSE_difference_poly <- sum_RMSE_difference_poly + temp_poly_RMSE
        if (best_RMSE_difference_poly > temp_poly_RMSE){
            best_RMSE_difference_poly <- temp_poly_RMSE
            fit_poly_best <- fit_poly
        }
    }
    cat("===========================================\n")
    cat(sprintf("degree is %d\n", i_degree))
    cat(sprintf("Polynomial Model: The average RMSE is %f\n\n", sum_RMSE_difference_poly/fold_num))
    degree_vector <- append(degree_vector, i_degree)
    RMSE_vector <- append(RMSE_vector, sum_RMSE_difference_poly/fold_num)
}
    plot(degree_vector, RMSE_vector, type="o", col="blue", xlab="Degree", ylab="RMSE Value", main="RMSE Value Against Degree")
