# Аналіз розподілу даних
data <- read.csv("~/Downloads/compsta3/distr4.txt", header=TRUE)

# Описова статистика
summary(data)
sd(data$X)
mean(data$X)
min(data)
max(data)

# Гістограма + щільності
hist(data$X, probability=TRUE, breaks=50)
curve(dnorm(x, mean=mean(data$X), sd=sd(data$X)), add=TRUE)

# PP-plot та QQ-plot для нормального розподілу
set.seed(12345)
n <- 300
x <- rnorm(n, mean=mean(data$X), sd=sd(data$X))
plot(pnorm(sort(x), mean=mean(data$X), sd=sd(data$X)), (1:length(x))/length(x), xlab="Theoretical", ylab="Empirical", main="PP-plot", col=4)
abline(0,1, col="red3")
qqnorm(x, asp=1)
qqline(x, col=2)
abline(0,1,col=4)

# Інші розподіли
hist(data$X, probability=TRUE, breaks=50)
curve(dlnorm(x, meanlog=0, sdlog=1), add=TRUE)
curve(dlnorm(x, meanlog=mean(data$X), sdlog=sd(data$X)), add=TRUE)
hist(data$X, probability=TRUE, breaks=50)
curve(dexp(x, rate=1), add=TRUE)
hist(data$X, probability=TRUE, breaks=50)
curve(dchisq(x, df=1), add=TRUE)

# QQ-плот з прогнозними інтервалами
QQplot <- function(x, K=1000, alpha=0.05) {
  n <- length(x)
  normQ <- qnorm((1:n - 0.5)/n)
  sx <- sort(x)
  W <- matrix(rnorm(K*n), nrow=n, ncol=K)
  W <- apply(W,2,sort)
  tops <- apply(W,1,quantile,probs=1-alpha/2)
  bots <- apply(W,1,quantile,probs=alpha/2)
  plot(c(normQ,normQ,normQ),c(tops,bots,sx),type="n", xlab="Theoretical quantiles", ylab="Empirical quantiles")
  points(normQ,sx,col=2)
  segments(normQ,bots,normQ,tops,col=4)
  abline(0,1,col=1)
}
x <- rnorm(300)
QQplot(x)