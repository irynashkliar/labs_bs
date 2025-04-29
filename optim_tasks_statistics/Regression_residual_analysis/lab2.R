# Лабораторна 2 — Регресія sin/ln
data <- read.table(file="~/Downloads/regrasympt/D7.txt", header=TRUE)
x <- data$x
y <- data$y

plot(x, y, cex=0.5)

# Модель
fit <- nls(y ~ sin(b0*x)/log(a0+x), start = list(a0=0.2183, b0=2.86))
a0 <- coef(fit)["a0"]
b0 <- coef(fit)["b0"]
curve(sin(b0*x)/log(a0+x), add=TRUE, col="red")

summary(fit)
confint(fit, level=0.95)

# Аналіз залишків
u <- residuals(fit)
pr <- fitted(fit)
plot(pr, u, xlab="Prediction", ylab="Residuals")
hist(u)
plot(y, pr, cex=0.5, xlab="Response", ylab="Prediction")
abline(0,1,col="red")
qqnorm(u, col="blue", cex=0.2, main="Residuals normal QQ-diagram")
qqline(u, col="red")