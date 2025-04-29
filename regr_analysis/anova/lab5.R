# Lab 5 — ANOVA for Coffee Purchase Intervals
data <- read.table(file="~/Downloads/regrasympt/kaffee.txt", header=TRUE)
boxplot(dauer ~ persn, data=data)

# Fisher test (ANOVA)
anova_res <- aov(dauer ~ as.factor(persn), data=data)
summary(anova_res)

# Confidence intervals
library(plotrix)
alpha0 <- 0.05
alpha <- 1 - (1 - alpha0)^(1/5)
l <- tapply(data$dauer, data$persn, length)
m <- tapply(data$dauer, data$persn, mean)
s <- tapply(data$dauer, data$persn, sd)
t_critical <- qt(1 - alpha/2, l-1)
h <- s * t_critical / sqrt(l)
plotCI(1:5, y=m, uiw=h, xlab="Groups", ylab="Means", xlim=c(1,5.2), xaxt="n")
axis(1, at=1:5, labels=c("A", "B", "C", "D", "E"))

# Levene's test for variance homogeneity
# library(car)
# leveneTest(data$dauer, data$persn)