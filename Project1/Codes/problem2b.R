library(neuralnet)
network_database <- read.csv(file = "network_backup_dataset.csv", header = TRUE, sep = ",")
# Prepare 2

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

#################
#   10 folds
#################
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

# Problem 2(c)
FileName <- 17
str_filename <- "File_16"
singleFile_data_network_database <- subset(data_network_database, FileName %in% c(17))

#neural network regression
cat("hidden nodes each layer,hidden layers,RMSE\n", file="neuralOutput.csv", append=FALSE)
cat("hidden nodes each layer,hidden layers,RMSE\n")
fold_num = 10 #Folds
# sample from 1 to fold_num, nrow times (the number of observations in the data)
singleFile_data_network_database$id <- sample(1:fold_num, nrow(singleFile_data_network_database), replace = TRUE)
list <- 1:fold_num
result_temp_neural <- data.frame()
fit_neural_best <- data.frame()
best_RMSE_difference_neural <- 1000.0
hidden_neural_best <- 0
threshold_neural_best <- 0
for (i_hidden_nodes_each_layer in 1:15){
    for (i_hidden_layers in 1:4){
        fold_fit_neural_best <- data.frame()
        fold_best_RMSE_difference_neural <- 1000.0
        sum_fold_RMSE_neural <- 0.0
        fold_hidden_neural_best <- 0
        fold_threshold_neural_best <- 0
        for (i in 1:fold_num){
            # remove rows with id i from dataframe to create training set
            # select rows with id i to create test set
            trainingset <- subset(singleFile_data_network_database, id %in% list[-i])
            testset <- subset(singleFile_data_network_database, id %in% c(i))

            fit_neural <- neuralnet(formula=SizeBackup ~ Week+DayOfWeek+StartTime+WorkFlowName+FileName+TimeBackup, data=trainingset, hidden=rep(i_hidden_nodes_each_layer,i_hidden_layers))

            test_x <- model.matrix(SizeBackup ~ Week+DayOfWeek+StartTime+WorkFlowName+FileName+TimeBackup, testset)
            temp_prediction_neural <- as.data.frame(compute(fit_neural, test_x[,-1]))
            # keep only the Sepal Length Column
            result_temp_neural <- cbind(temp_prediction_neural$net.result, as.data.frame(testset[,6]))
            names(result_temp_neural) <- c("Predicted", "Actual")
            result_temp_neural$Difference <- abs(result_temp_neural$Actual - result_temp_neural$Predicted) ^ 2
            temp_neural_RMSE <- sqrt(sum(result_temp_neural$Difference)/length(result_temp_neural$Difference))
            if (fold_best_RMSE_difference_neural > temp_neural_RMSE){
                fold_best_RMSE_difference_neural <- temp_neural_RMSE
                fold_fit_neural_best <- fit_neural
                fold_hidden_neural_best <- i_hidden_nodes_each_layer
                fold_threshold_neural_best <- i_hidden_layers
            }
            sum_fold_RMSE_neural <- sum_fold_RMSE_neural + temp_neural_RMSE
        }
        # cat("===========================================\n")
        cat(sprintf("%d,%d,%f\n", i_hidden_nodes_each_layer, i_hidden_layers, sum_fold_RMSE_neural/fold_num))
        # cat(sprintf("threshold = %d\t hidden = %d\n", i_hidden_nodes_each_layer, i_hidden_layers))
        # cat(sprintf("Neural Network Model: The Average RMSE is %f\n\n", sum_fold_RMSE_neural/fold_num))
        cat(sprintf("%d,%d,%f\n", i_hidden_nodes_each_layer, i_hidden_layers, sum_fold_RMSE_neural/fold_num), file="neuralOutput.csv", append=TRUE)
        if (best_RMSE_difference_neural > fold_best_RMSE_difference_neural){
            best_RMSE_difference_neural <- fold_best_RMSE_difference_neural
            fit_neural_best <- fold_fit_neural_best
            hidden_neural_best <- fold_hidden_neural_best
            threshold_neural_best <- fold_threshold_neural_best
        }
    }
}

