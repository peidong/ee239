library(randomForestSRC)
# library(randomForest)
library(grnn)
network_database <- read.csv(file = "network_backup_dataset.csv", header = TRUE, sep = ",")
network_database[[8]] = 0
for (i in 1:length(network_database[[1]])){
    if (network_database[[2]][i] == "Monday"){
        network_database[[8]][i] <- (network_database[[1]][i]-1)*7 + 1
    }
    if (network_database[[2]][i] == "Tuesday"){
        network_database[[8]][i] <- (network_database[[1]][i]-1)*7 + 2
    }
    if (network_database[[2]][i] == "Wednesday"){
        network_database[[8]][i] <- (network_database[[1]][i]-1)*7 + 3
    }
    if (network_database[[2]][i] == "Thursday"){
        network_database[[8]][i] <- (network_database[[1]][i]-1)*7 + 4
    }
    if (network_database[[2]][i] == "Friday"){
        network_database[[8]][i] <- (network_database[[1]][i]-1)*7 + 5
    }
    if (network_database[[2]][i] == "Saturday"){
        network_database[[8]][i] <- (network_database[[1]][i]-1)*7 + 6
    }
    if (network_database[[2]][i] == "Sunday"){
        network_database[[8]][i] <- (network_database[[1]][i]-1)*7 + 7
    }
}
names(network_database)[8] <- "Days"
network_total_days <- max(network_database[[8]])
# Problem 1
network_database_workflow0 <- list()
network_database_workflow1 <- list()
network_database_workflow2 <- list()
network_database_workflow3 <- list()
network_database_workflow4 <- list()
network_database_workflow0[[1]] <- network_database[[8]][which(network_database[[4]] %in% "work_flow_0")]
network_database_workflow0[[2]] <- network_database[[6]][which(network_database[[4]] %in% "work_flow_0")]
network_database_workflow1[[1]] <- network_database[[8]][which(network_database[[4]] %in% "work_flow_1")]
network_database_workflow1[[2]] <- network_database[[6]][which(network_database[[4]] %in% "work_flow_1")]
network_database_workflow2[[1]] <- network_database[[8]][which(network_database[[4]] %in% "work_flow_2")]
network_database_workflow2[[2]] <- network_database[[6]][which(network_database[[4]] %in% "work_flow_2")]
network_database_workflow3[[1]] <- network_database[[8]][which(network_database[[4]] %in% "work_flow_3")]
network_database_workflow3[[2]] <- network_database[[6]][which(network_database[[4]] %in% "work_flow_3")]
network_database_workflow4[[1]] <- network_database[[8]][which(network_database[[4]] %in% "work_flow_4")]
network_database_workflow4[[2]] <- network_database[[6]][which(network_database[[4]] %in% "work_flow_4")]
names(network_database_workflow0)[1] <- "Days"
names(network_database_workflow0)[2] <- "Size"
names(network_database_workflow1)[1] <- "Days"
names(network_database_workflow1)[2] <- "Size"
names(network_database_workflow2)[1] <- "Days"
names(network_database_workflow2)[2] <- "Size"
names(network_database_workflow3)[1] <- "Days"
names(network_database_workflow3)[2] <- "Size"
names(network_database_workflow4)[1] <- "Days"
names(network_database_workflow4)[2] <- "Size"
sum_network_database_workflow0 <- list()
sum_network_database_workflow0[[1]] <- 0
sum_network_database_workflow0[[2]] <- 0
sum_network_database_workflow1 <- list()
sum_network_database_workflow1[[1]] <- 0
sum_network_database_workflow1[[2]] <- 0
sum_network_database_workflow2 <- list()
sum_network_database_workflow2[[1]] <- 0
sum_network_database_workflow2[[2]] <- 0
sum_network_database_workflow3 <- list()
sum_network_database_workflow3[[1]] <- 0
sum_network_database_workflow3[[2]] <- 0
sum_network_database_workflow4 <- list()
sum_network_database_workflow4[[1]] <- 0
sum_network_database_workflow4[[2]] <- 0
for (i in 1:floor(network_total_days/20)){
    sum_network_database_workflow0[[1]][i] <- 20*i
    sum_network_database_workflow0[[2]][i] <- sum(network_database_workflow0[[2]][which(network_database_workflow0$Days <= 20*i & network_database_workflow0$Days > 20*(i-1))])
}
for (i in 1:floor(network_total_days/20)){
    sum_network_database_workflow1[[1]][i] <- 20*i
    sum_network_database_workflow1[[2]][i] <- sum(network_database_workflow1[[2]][which(network_database_workflow1$Days <= 20*i & network_database_workflow1$Days > 20*(i-1))])
}
for (i in 1:floor(network_total_days/20)){
    sum_network_database_workflow2[[1]][i] <- 20*i
    sum_network_database_workflow2[[2]][i] <- sum(network_database_workflow2[[2]][which(network_database_workflow2$Days <= 20*i & network_database_workflow2$Days > 20*(i-1))])
}
for (i in 1:floor(network_total_days/20)){
    sum_network_database_workflow3[[1]][i] <- 20*i
    sum_network_database_workflow3[[2]][i] <- sum(network_database_workflow3[[2]][which(network_database_workflow3$Days <= 20*i & network_database_workflow3$Days > 20*(i-1))])
}
for (i in 1:floor(network_total_days/20)){
    sum_network_database_workflow4[[1]][i] <- 20*i
    sum_network_database_workflow4[[2]][i] <- sum(network_database_workflow4[[2]][which(network_database_workflow4$Days <= 20*i & network_database_workflow4$Days > 20*(i-1))])
}
names(sum_network_database_workflow0)[1] <- "Days"
names(sum_network_database_workflow0)[2] <- "Size"
names(sum_network_database_workflow1)[1] <- "Days"
names(sum_network_database_workflow1)[2] <- "Size"
names(sum_network_database_workflow2)[1] <- "Days"
names(sum_network_database_workflow2)[2] <- "Size"
names(sum_network_database_workflow3)[1] <- "Days"
names(sum_network_database_workflow3)[2] <- "Size"
names(sum_network_database_workflow4)[1] <- "Days"
names(sum_network_database_workflow4)[2] <- "Size"
barplot(sum_network_database_workflow0$Size, names.arg = c("1~20", "21~40", "41~60", "61~80", "81~100"),main="Workflow0 Copy Sizes Within a Period of 20 Days", xlab="Days")
barplot(sum_network_database_workflow1$Size, names.arg = c("1~20", "21~40", "41~60", "61~80", "81~100"),main="Workflow1 Copy Sizes Within a Period of 20 Days", xlab="Days")
barplot(sum_network_database_workflow2$Size, names.arg = c("1~20", "21~40", "41~60", "61~80", "81~100"),main="Workflow2 Copy Sizes Within a Period of 20 Days", xlab="Days")
barplot(sum_network_database_workflow3$Size, names.arg = c("1~20", "21~40", "41~60", "61~80", "81~100"),main="Workflow3 Copy Sizes Within a Period of 20 Days", xlab="Days")
barplot(sum_network_database_workflow4$Size, names.arg = c("1~20", "21~40", "41~60", "61~80", "81~100"),main="Workflow4 Copy Sizes Within a Period of 20 Days", xlab="Days")
# Problem 2

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
#   Generate random 90% and 10% database
#   Begin
#
#####################################################

# random_index <- sample(1:length(network_database_linear_model[[1]]), length(network_database_linear_model[[1]]))
# length_group <- floor(length(network_database_linear_model[[1]]) / 10) + 1
# length_group_last_one <- length(network_database_linear_model[[1]]) - length_group * 9
# list_random_network_database <- list()
# temp_vector <- c()
# temp_list <- list()
# for (i in 1:10){
#     temp_list <- list()
#     if (i == 10){
#         temp_index_low <- (i-1)*length_group+1
#         temp_index_high <- (i-1)*length_group+length_group_last_one
#     }else{
#         temp_index_low <- (i-1)*length_group+1
#         temp_index_high <- i*length_group
#     }
#     for (j in 1:7){
#         temp_vector <- c()
#         temp_vector <- network_database_linear_model[[j]][random_index[temp_index_low:temp_index_high]]
#         temp_list[[j]] <- temp_vector
#         if (j == 1){
#             names(temp_list)[j] <- "Week"
#         } else if (j == 2){
#             names(temp_list)[j] <- "DayOfWeek"
#         } else if (j == 3){
#             names(temp_list)[j] <- "StartTime"
#         } else if (j == 4){
#             names(temp_list)[j] <- "WorkFlowName"
#         } else if (j == 5){
#             names(temp_list)[j] <- "FileName"
#         } else if (j == 6){
#             names(temp_list)[j] <- "SizeBackup"
#         } else if (j == 7){
#             names(temp_list)[j] <- "TimeBackup"
#         }
#     }
#     list_random_network_database[[i]] <- temp_list
# }

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
# reference https://gist.github.com/bhoung/11237681
fold_num = 10 #Folds
# sample from 1 to fold_num, nrow times (the number of observations in the data)
data_network_database$id <- sample(1:fold_num, nrow(data_network_database), replace = TRUE)
list <- 1:fold_num

# prediction and testset data frames that we add to with each iteration over
# the folds

#linear model
result_temp_linear <- data.frame()
fit_linear_best <- data.frame()
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

#Random Forest model
result_temp_randomForest <- data.frame()
fit_randomForest_best <- data.frame()
best_RMSE_difference_randomForest <- 1000.0
depth_randomForest_best <- 0
ntree_randomForest_best <- 0
for (i_depth in 4:5){
    for (i_ntree in 20:21){
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
            cat("===========================================\n")
            cat(sprintf("ntree = %d\t depth = %d\tNo.%d\n", i_ntree, i_depth, i))
            cat(sprintf("Random Forest Model: The RMSE is %f\n\n", temp_randomForest_RMSE))
            if (best_RMSE_difference_randomForest > temp_randomForest_RMSE){
                best_RMSE_difference_randomForest <- temp_randomForest_RMSE
                fit_randomForest_best <- fit_randomForest
                depth_randomForest_best <- i_depth
                ntree_randomForest_best <- i_ntree
            }
        }
    }
}
if (1){
cat("===========================================\n")
cat("=======The best coefficients:==============\n")
cat(sprintf("ntree = %d\t depth = %d\n", ntree_randomForest_best, depth_randomForest_best))
cat(sprintf("Random Forest Model: The RMSE is %f\n\n", best_RMSE_difference_randomForest))
}

# Problem 2(b)
