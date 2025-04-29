# Lab 3 — Polynomial Regression for log(Y)
ce <- read.table(file="~/Downloads/regrasympt/c7.txt", header=TRUE)
x <- ce[,"X"]
y <- ce[,"Y"]
plot(x, y)

# Try hyperbolic model
x0 <- 1/x
resLm <- lm(y ~ x0)
summary(resLm)

# Try logarithmic model
x4 <- log(x)
resLm <- lm(y ~ x4)
summary(resLm)

# Log-transform Y
ly <- log(y)
plot(x, ly)

# Polynomial regression
x2 <- x^2
x3 <- x^3
resLm <- lm(ly ~ x + x2 + x3)
summary(resLm)

plot(resLm$fitted.values, resLm$residuals, xlab="prediction", ylab="residuals")
hi <- hist(resLm$residuals, breaks=8, xlab="residuals", ylim=c(0,60), main="Residuals")
curve(dnorm(x, mean=mean(resLm$residuals), sd=sd(resLm$residuals)) * length(resLm$residuals)*(hi$breaks[2]-hi$breaks[1]), col="darkblue", lwd=2, add=TRUE, yaxt="n")
qqnorm(resLm$residuals)
qqline(resLm$residuals, col="red")