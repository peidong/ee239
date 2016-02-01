# load the library
library(AppliedPredictiveModeling)
library(caret)
library(lars)
library(elasticnet)
library(latticeExtra)

# load boston housing data file
housing_data<-read.csv("housing_data.csv")

# split original boston housing dataset into target variable and features
# use MEDV as the target variable and the other attributes as the features
features <- housing_data[,1:13]
target <- housing_data[,14]

# the random number seed is set prior to the modeling so that the results can be reproduced
set.seed(8) 


#########################
##      Problem 4      ##           
#########################

# Linear Regression Model
# use 10-fold cross-validation
ctrl <- trainControl(method = "cv", number = 10) 
# train a linear regression model
lmFit <- train(x=features, y=target, method = "lm",trControl = ctrl)
cat("===========================================================\n")
cat("Estimated coefficient for each predicator:\n")
print(summary(lmFit))
cat("===========================================================\n")
cat("Averaged RMSE:\n")
print(lmFit)
# plot "fitted values and actual values scattered plot over time"
plot_1<-xyplot(target ~ c(1:length(target)), type=c("p","g"), xlab="", ylab="Fitted Values (Red) / Actual values (Blue)")
plot_2<-xyplot(predict(lmFit) ~ c(1:length(predict(lmFit))), type=c("p","g"), col="red")
print(plot_1+plot_2)
# plot "actual values versus the fitted values"
plot_3<-xyplot(target ~ predict(lmFit), type=c("p","g"), xlab="Fitted Values", ylab="Actual values")
print(plot_3)
# plot "residuals versus fitted values"
plot_4<-xyplot(resid(lmFit) ~ predict(lmFit), type=c("p","g"), xlab="Fitted Values", ylab="Residuals")
print(plot_4)


#########################
##    Problem 5(a)     ##           
#########################

# Ridge Regreesion Model
# use 10-fold cross-validation
ctrl <- trainControl(method = "cv", number = 10)  
# tune the complexity parameter alpha of the ridge regression in the range {0.1, 0.01, 0.001}
ridgeGrid<- data.frame(.lambda = c(0.1, 0.01, 0.001))
# train a ridge regression model
ridgeFit <- train(features, target, method ="ridge",tuneGrid = ridgeGrid, trControl=ctrl, preProc=c("center","scale"))
cat("===========================================================\n")
cat("Ridge Regreesion Model:\n")
print(ridgeFit)

#########################
##    Problem 5(b)     ##           
#########################

# Lasso Regression Model
# use 10-fold cross-validation
ctrl <- trainControl(method = "cv", number = 10) 
# tune the complexity parameter alpha of the lasso regression in the range {0.1, 0.01, 0.001}
# I also tried "alpha=1" to check if the lasso regression model we trained is correct
lassoGrid <- expand.grid(.lambda=0, .fraction = c(1, 0.1, 0.01, 0.001))
# train a lasso regression model
lassoFit <- train(features, target, method ="enet", tuneGrid = lassoGrid, trControl=ctrl, preProc=c("center","scale"))
cat("===========================================================\n")
cat("Lasso Regreesion Model:\n")
print(lassoFit)
