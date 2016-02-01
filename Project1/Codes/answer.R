# require(nnet)
require(caret)
library(pracma)
library(randomForestSRC)
library(neuralnet)
# library(randomForest)
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

features <- data_network_database[,-6]
target <- data_network_database[,6]

#Problem 1
data_network_database$Hours <- 0
for (i in 1:length(data_network_database[[1]])){
    data_network_database$Hours[i] <- (data_network_database$Week[i] - 1)*7*24 + (data_network_database$DayOfWeek[i] - 1) * 24 + data_network_database$StartTime[i]
}
first_20days_data_network_database <- subset(data_network_database, Hours %in% c(1:480))
#choose File
file_choose <- c(1,7,13,22,25)
str_filename <- c("File_0", "File_6", "File_12", "File_21", "File_24")
str_workflowname <- c("work_flow_0", "work_flow_1", "work_flow_2", "work_flow_3", "work_flow_4")
for (i_workflow in 1:5){
    i_workflow_first_20days_data <- subset(first_20days_data_network_database, WorkFlowName %in% c(i_workflow))
    i_workflow_first_20days_file_data <- subset(i_workflow_first_20days_data, FileName %in% c(file_choose[i_workflow]))
    plot(i_workflow_first_20days_file_data$Hours, i_workflow_first_20days_file_data$SizeBackup, type="o", col="blue", xlab="Hours (h)", ylab="File Copy Size (GB)", main=sprintf("%s %s's Copy Size in 20 Days", str_workflowname[i_workflow], str_filename[i_workflow]))
}

#Problem 2(a)
# reference https://gist.github.com/bhoung/11237681
fold_num = 10 #Folds
# sample from 1 to fold_num, nrow times (the number of observations in the data)
data_network_database$id <- sample(1:fold_num, nrow(data_network_database), replace = TRUE)
list <- 1:fold_num

#linear model
result_temp_linear <- data.frame()
fit_linear_best <- list()
best_RMSE_difference_linear <- 1000.0
for (i in 1:fold_num){
    # remove rows with id i from dataframe to create training set
    # select rows with id i to create test set
    trainingset <- subset(data_network_database, id %in% list[-i])
    testset <- subset(data_network_database, id %in% c(i))

    # run a linear regression model
    fit_linear <- lm(SizeBackup ~ Week+DayOfWeek+StartTime+WorkFlowName+FileName+TimeBackup, data=trainingset)

    temp_prediction_linear <- as.data.frame(predict(fit_linear, testset[,-6]))
    # append this iteration's predictions to the end of the prediction_linear data frame
    cat("===========================================\n")
    cat(sprintf("No.%d\n", i))
    cat(sprintf("fit_linear coefficients:\n"))
    print(fit_linear$coefficients)

    result_temp_linear <- cbind(temp_prediction_linear, as.data.frame(testset[,6]))
    names(result_temp_linear) <- c("Predicted", "Actual")
    result_temp_linear$Difference <- abs(result_temp_linear$Actual - result_temp_linear$Predicted) ^ 2
    temp_linear_RMSE <- sqrt(sum(result_temp_linear$Difference) / length(result_temp_linear$Difference))
    cat(sprintf("Linear Model: The RMSE is %f\n", temp_linear_RMSE))
    if (best_RMSE_difference_linear > temp_linear_RMSE){
        best_RMSE_difference_linear <- temp_linear_RMSE
        fit_linear_best <- fit_linear
    }
}
#residuals versus fitted values plot
#plot(fit_linear_best)

#Fitted values and actual values scattered plot over time
prediction_all_data <- as.data.frame(predict(fit_linear_best, data_network_database[,-6]))
difference_all_data <- cbind(prediction_all_data, as.data.frame(data_network_database[,6]))
difference_all_data <- cbind(difference_all_data, as.data.frame(data_network_database$Hours))
names(difference_all_data) <- c("Predicted", "Actual", "Hours")
plot(difference_all_data$Hours, difference_all_data$Actual, type="p", col="red", cex=0.5, xlab="Hours (h)", ylab="Fitted values and actual values (GB)", main="Fitted values and actual values scattered plot over time")
points(difference_all_data$Hours, difference_all_data$Predicted, col="blue", cex=0.5)

# Problem 2(b)

#Random Forest model
cat("tree,depth,RMSE\n", file="depth4to64-ntree41to60-randomForestoutput.csv", append=FALSE)
result_temp_randomForest <- data.frame()
fit_randomForest_best <- data.frame()
best_RMSE_difference_randomForest <- 1000.0
depth_randomForest_best <- 0
ntree_randomForest_best <- 0
for (i_depth in 4:64){
    for (i_ntree in 41:60){
        fold_fit_randomForest_best <- data.frame()
        fold_best_RMSE_difference_randomForest <- 1000.0
        fold_depth_randomForest_best <- 0
        fold_ntree_randomForest_best <- 0
        for (i in 1:fold_num){
            # remove rows with id i from dataframe to create training set
            # select rows with id i to create test set
            trainingset <- subset(data_network_database, id %in% list[-i])
            testset <- subset(data_network_database, id %in% c(i))

            fit_randomForest <- rfsrc(SizeBackup ~ Week+DayOfWeek+StartTime+WorkFlowName+FileName+TimeBackup,
                                      data = trainingset, ntree = i_ntree, nodedepth = i_depth)

            temp_rfsrc_predict <- predict(fit_randomForest, testset[,-6])
            temp_prediction_randomForest <- as.data.frame(temp_rfsrc_predict$predicted)

            # keep only the Sepal Length Column
            result_temp_randomForest <- cbind(temp_prediction_randomForest, as.data.frame(testset[,6]))
            names(result_temp_randomForest) <- c("Predicted", "Actual")
            result_temp_randomForest$Difference <- abs(result_temp_randomForest$Actual - result_temp_randomForest$Predicted) ^ 2
            temp_randomForest_RMSE <- sqrt(sum(result_temp_randomForest$Difference)/length(result_temp_randomForest$Difference))
            if (fold_best_RMSE_difference_randomForest > temp_randomForest_RMSE){
                fold_best_RMSE_difference_randomForest <- temp_randomForest_RMSE
                fold_fit_randomForest_best <- fit_randomForest
                fold_depth_randomForest_best <- i_depth
                fold_ntree_randomForest_best <- i_ntree
            }
        }
        cat("===========================================\n")
        cat(sprintf("ntree = %d\t depth = %d\n", i_ntree, i_depth))
        cat(sprintf("Random Forest Model: The RMSE is %f\n\n", fold_best_RMSE_difference_randomForest))
        cat(sprintf("%d,%d,%f\n", i_ntree, i_depth, fold_best_RMSE_difference_randomForest), file="depth4to64-ntree41to60-randomForestoutput.csv", append=TRUE)
        if (best_RMSE_difference_randomForest > fold_best_RMSE_difference_randomForest){
            best_RMSE_difference_randomForest <- fold_best_RMSE_difference_randomForest
            fit_randomForest_best <- fold_fit_randomForest_best
            depth_randomForest_best <- fold_depth_randomForest_best
            ntree_randomForest_best <- fold_ntree_randomForest_best
        }
    }
}
if (1){
cat("===========================================\n")
cat("=======The best coefficients:==============\n")
cat(sprintf("ntree = %d\t depth = %d\n", ntree_randomForest_best, depth_randomForest_best))
cat(sprintf("Random Forest Model: The RMSE is %f\n\n", best_RMSE_difference_randomForest))
}

# Problem 2(c)
set.seed(8)

# neural network regression
# use 10-fold cross-validation
ctrl <- trainControl(method = "cv", number = 10)
# train a linear regression model
neuralnetFit <- train(x=features, y=target, method = "neuralnet",trControl = ctrl)
cat("===========================================================\n")
cat("Estimated coefficient for each predicator:\n")
print(summary(neuralnetFit))
cat("===========================================================\n")
cat("Averaged RMSE:\n")
print(neuralnetFit)
# plot "fitted values and actual values scattered plot over time"
plot_1<-xyplot(target ~ c(1:length(target)), type=c("p","g"), xlab="", ylab="Fitted Values (Red) / Actual values (Blue)")
plot_2<-xyplot(predict(neuralnetFit) ~ c(1:length(predict(neuralnetFit))), type=c("p","g"), col="red")
print(plot_1+plot_2)
# plot "actual values versus the fitted values"
plot_3<-xyplot(target ~ predict(neuralnetFit), type=c("p","g"), xlab="Fitted Values", ylab="Actual values")
print(plot_3)
# plot "residuals versus fitted values"
plot_4<-xyplot(resid(neuralnetFit) ~ predict(neuralnetFit), type=c("p","g"), xlab="Fitted Values", ylab="Residuals")
print(plot_4)

#neural network regression
fold_num = 10 #Folds
# sample from 1 to fold_num, nrow times (the number of observations in the data)
data_network_database$id <- sample(1:fold_num, nrow(data_network_database), replace = TRUE)
list <- 1:fold_num
result_temp_neural <- data.frame()
fit_neural_best <- data.frame()
best_RMSE_difference_neural <- 1000.0
hidden_neural_best <- 0
threshold_neural_best <- 0
for (i_hidden in 1:1){
    for (i_threshold in 1:1){
        fold_fit_neural_best <- data.frame()
        fold_best_RMSE_difference_neural <- 1000.0
        fold_hidden_neural_best <- 0
        fold_threshold_neural_best <- 0
        for (i in 1:fold_num){
            # remove rows with id i from dataframe to create training set
            # select rows with id i to create test set
            trainingset <- subset(data_network_database, id %in% list[-i])
            testset <- subset(data_network_database, id %in% c(i))

            fit_neural <- neuralnet(formula=SizeBackup ~ Week+DayOfWeek+StartTime+WorkFlowName+FileName+TimeBackup, data=trainingset, hidden=i_hidden, threshold=i_threshold)

            test_x <- model.matrix(SizeBackup ~ Week+DayOfWeek+StartTime+WorkFlowName+FileName+TimeBackup, testset)
            temp_prediction_neural <- as.data.frame(compute(fit_neural, test_x))
            # keep only the Sepal Length Column
            result_temp_neural <- cbind(temp_prediction_neural, as.data.frame(testset[,6]))
            names(result_temp_neural) <- c("Predicted", "Actual")
            result_temp_neural$Difference <- abs(result_temp_neural$Actual - result_temp_neural$Predicted) ^ 2
            temp_neural_RMSE <- sqrt(sum(result_temp_neural$Difference)/length(result_temp_neural$Difference))
            if (fold_best_RMSE_difference_neural > temp_neural_RMSE){
                fold_best_RMSE_difference_neural <- temp_neural_RMSE
                fold_fit_neural_best <- fit_neural
                fold_hidden_neural_best <- i_hidden
                fold_threshold_neural_best <- i_threshold
            }
        }
        cat("===========================================\n")
        cat(sprintf("threshold = %d\t hidden = %d\n", i_threshold, i_hidden))
        cat(sprintf("Random Forest Model: The RMSE is %f\n\n", fold_best_RMSE_difference_neural))
        if (best_RMSE_difference_neural > fold_best_RMSE_difference_neural){
            best_RMSE_difference_neural <- fold_best_RMSE_difference_neural
            fit_neural_best <- fold_fit_neural_best
            hidden_neural_best <- fold_hidden_neural_best
            threshold_neural_best <- fold_threshold_neural_best
        }
    }
}

# Problem 3 part 1
for (i_workflow in 1:5){
    data_i_workflow_network <- subset(data_network_database, WorkFlowName %in% c(i_workflow))
    fold_num = 10 #Folds
    data_i_workflow_network$id <- sample(1:fold_num, nrow(data_i_workflow_network), replace = TRUE)
    list <- 1:fold_num
    #linear model
    result_temp_linear <- data.frame()
    fit_linear_best <- list()
    best_RMSE_difference_linear <- 1000.0
    sum_RMSE_linear <- 0.0
    for (i in 1:fold_num){
        # remove rows with id i from dataframe to create training set
        # select rows with id i to create test set
        trainingset <- subset(data_i_workflow_network, id %in% list[-i])
        testset <- subset(data_i_workflow_network, id %in% c(i))

        # run a linear regression model
        fit_linear <- lm(SizeBackup ~ Week+DayOfWeek+StartTime+FileName+TimeBackup, data=trainingset)

        temp_prediction_linear <- as.data.frame(predict(fit_linear, testset[,-6]))
        # append this iteration's predictions to the end of the prediction_linear data frame
        # cat("===========================================\n")
        # cat(sprintf("No.%d\n", i))
        # cat(sprintf("fit_linear coefficients:\n"))
        # print(fit_linear$coefficients)

        result_temp_linear <- cbind(temp_prediction_linear, as.data.frame(testset[,6]))
        names(result_temp_linear) <- c("Predicted", "Actual")
        result_temp_linear$Difference <- abs(result_temp_linear$Actual - result_temp_linear$Predicted) ^ 2
        temp_linear_RMSE <- sqrt(sum(result_temp_linear$Difference) / length(result_temp_linear$Difference))
        # cat(sprintf("Linear Model: The RMSE is %f\n", temp_linear_RMSE))
        sum_RMSE_linear <- sum_RMSE_linear + temp_linear_RMSE
        if (best_RMSE_difference_linear > temp_linear_RMSE){
            best_RMSE_difference_linear <- temp_linear_RMSE
            fit_linear_best <- fit_linear
        }
    }
    cat("===========================================\n")
    cat(sprintf("WorkFlow No.%d\n", i_workflow-1))
    cat(sprintf("Linear Model: The average RMSE is %f\n", sum_RMSE_linear/fold_num))
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
for (i_degree in 6:20){
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
    plot(degree_vector, RMSE_vector, type="o", col="blue", log="y", xlab="Degree", ylab="RMSE Value", main="RMSE Value Against Degree")
