# Лабораторна 1 — Момент зміни розподілу
data <- read.table(file="~/Downloads/regrasympt/chp7.txt", header=TRUE)
x <- data$x
plot(x)

# Логарифмуємо дані
y <- log(x)
hist(x[1:350])
hist(x[530:950])
hist(y[1:350])
hist(y[530:950])

# Функції для оцінювання
Est <- function(ch, x) {
  n <- length(x)
  m1 <- mean(x[1:ch])
  m2 <- mean(x[(ch+1):n])
  s1 <- var(x[1:ch])
  s2 <- var(x[(ch+1):n])
  return(c(m1, m2, s1, s2))
}

LogLik <- function(ch, x) {
  z <- Est(ch, x)
  -sum((x[1:ch]-z[1])^2)/(2*z[3]) - sum((x[(ch+1):length(x)]-z[2])^2)/(2*z[4]) - ch*log(z[3])/2 - (length(x)-ch)*log(z[4])/2
}

LL <- sapply(2:(length(y)-2), LogLik, x=y)
plot(LL, type="l")
EstChP <- which.max(LL)
abline(v=EstChP, col='red')

# Перевірка гіпотез
y1 <- y[1:EstChP]
hi <- hist(y1, probability=TRUE)
curve(dnorm(x, mean=mean(y1), sd=sqrt(var(y1))), add=TRUE, col="darkblue", lwd=2)

y2 <- y[(EstChP+1):length(y)]
hi <- hist(y2, probability=TRUE)
curve(dnorm(x, mean=mean(y2), sd=sqrt(var(y2))), add=TRUE, col="darkblue", lwd=2)