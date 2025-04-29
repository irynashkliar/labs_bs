# Lab 4 — Linear Regression L_EDUC vs SLIV
data <- read.table(file="~/Downloads/regrasympt/house011.txt", header=TRUE)
x <- data[,"L_EDUC"]
y <- data[,"SLIV"]
plot(x, y)

# Restricted model
resr <- lm(L_EDUC ~ SLIV, data=data)
summary(resr)

# Residual analysis
hi <- hist(resr$residuals, breaks=8, xlab="residuals", main="Residuals Histogram")
curve(dnorm(x, mean=mean(resr$residuals), sd=sd(resr$residuals)) * length(resr$residuals)*(hi$breaks[2]-hi$breaks[1]), col="darkblue", lwd=2, add=TRUE, yaxt="n")
qqnorm(resr$residuals)
qqline(resr$residuals, col="red")

# Chow test
RSSr <- anova(resr)["Residuals", "Sum Sq"]
RSSv <- anova(lm(L_EDUC ~ SLIV, data=data, subset=(COD_OBL==5)))["Residuals", "Sum Sq"]
RSSo <- anova(lm(L_EDUC ~ SLIV, data=data, subset=(COD_OBL==51)))["Residuals", "Sum Sq"]
RSSu <- RSSv + RSSo

F <- (RSSr - RSSu) * (length(data$L_EDUC) - 4) / (2 * RSSu)
p <- 1 - pf(F, 2, length(data$L_EDUC) - 4)
F
p