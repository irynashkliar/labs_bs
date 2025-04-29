# Lab 2 — Height and Weight Regression
peo <- read.table(file="~/Downloads/regrasympt/people.txt", header=TRUE)
plot(peo[,"HEIGHT"], peo[,"WEIGHT"], xlab="height", ylab="weight")

# Linear regression
resLm <- lm(WEIGHT ~ HEIGHT, data=peo)
summary(resLm)
plot(resLm$fitted.values, resLm$residuals, xlab="prediction", ylab="residuals")
qqnorm(resLm$residuals)
qqline(resLm$residuals)

# Multiplicative model (log-log)
resLog <- lm(log(WEIGHT) ~ log(HEIGHT), data=peo)
summary(resLog)
plot(resLog$fitted.values, resLog$residuals, xlab="prediction", ylab="residuals")
qqnorm(resLog$residuals)
qqline(resLog$residuals, col="red")