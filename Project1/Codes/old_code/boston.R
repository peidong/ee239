library(MASS)
library(ISLR)
name(Boston)
length(Boston)
mode(Boston)
typeof(Boston)
Boston

fit1=lm(medv~lstat, data = Boston)
summary(fit1)
abline(fit1, col='red')
predict(fit1, data.frame(lstat=c(5,10,15)),interval='confidence')
confint(fit1)
plot(fit1)

fit2=lm(medv~lstat+age, data=Boston)
summary(fit2)
plot(fit2)

fit3=lm(medv~.,Boston)
summary(fit3)
par(c(2,2))
plot(fit3)






