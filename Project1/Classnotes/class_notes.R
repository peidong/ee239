library(MASS)
library(ISLR)

names(Boston)
?Boston
plot(medv~lstat, Boston)
fit1 = lm(medv~lstat, data=Boston)
summary(fit1)
abline(fit1, col='red') # show the line
predict(fit1, data.frame(lstat=c(5,10,15)),inteval='confidence')
confint(fit1)


fit2=lm(medv~lstat+age,data=Boston)
summary(fit2)
fit3=lm(medv~.,Boston)
summary(fit3)
par(c(2,2))
plot(fit3)
fit4=lm(medv~.-age-indus,data=Boston)
summary(fit4)

fit5=lm(medv~lstat*age,Boston)
summary(fit5)

fit6=lm(medv~lstat+I(lstat^2),Boston)
summary(fit6)
plot(Boston$lstat,Boston$medv)
points(Boston$lstat, fitted(fit6), col="red", pch=20)
