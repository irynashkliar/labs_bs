# Генерація псевдовипадкових чисел (генератори)
n <- 500

# Генератор Парка-Міллера
a <- 7^5
c0 <- 0
m <- 2^31 - 1
I <- numeric(n)
I[1] <- 2^15 + 2
for (i in 2:n) {
  I[i] <- (a * I[i-1] + c0) %% m
}
x1 <- I / m

# Інша реалізація генератора Парка-Міллера
park_miller <- function() {
  m <- 2^31
  a <- 7^5
  x <- 2^15
  x <- (a * x) %% m
  return(x / m)
}
seq1 <- replicate(500, park_miller())

# Генератор лінійних конгруенцій
lincon_generator <- function(n) {
  a <- 75831
  c0 <- 0
  m <- 2^31
  seed <- 2^15
  I <- numeric(n)
  I[1] <- seed
  generate <- function() {
    I <<- (a * I + c0) %% m
    return(I / m)
  }
  replicate(n, generate())
}

# Побудова емпіричної та теоретичної функції розподілу
sx <- sort(x1)
plot(sx, (1:n)/n, type="s", xlim=c(-0.1,1), ylim=c(0,1), col="green4")
abline(0,1,col="red")

# Перевірка незалежності генераторів
x11 <- x1[1:(n-1)]
x12 <- x1[2:n]
plot(x11, x12, cex=0.5)

# Генерація логнормальної послідовності
lognormal_generator <- function(n, meanlog, sdlog) {
  rlnorm(n, meanlog=meanlog, sdlog=sdlog)
}
n <- 500
meanlog <- 1
sdlog <- sqrt(0.75)
lognormal_seq <- lognormal_generator(n, meanlog, sdlog)

# Порівняння функцій розподілу
theoretical_cdf <- plnorm(seq(0, max(lognormal_seq), length.out=n), meanlog=meanlog, sdlog=sdlog)
empirical_cdf <- ecdf(lognormal_seq)
plot(seq(0, max(lognormal_seq), length.out=n), theoretical_cdf, type="l", col="pink", xlab="Значення", ylab="Ймовірність", main="Порівняння функцій розподілу")
lines(sort(lognormal_seq), empirical_cdf(sort(lognormal_seq)), col="violet")
legend("topright", legend=c("Теоретична", "Емпірична"), col=c("pink", "violet"), lty=1)