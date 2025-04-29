# Лабораторна 4 — ЕМ-алгоритм
data <- read.table(file="~/Downloads/regrasympt-1/mix7.txt", header=FALSE)
X <- data$V1

hist(X, probability=TRUE)

M <- 3
p0 <- c(0.33, 0.33, 0.34)
a0 <- c(-1, 1, 4)
s0 <- c(1, 1, 1)

# ЕМ-крок
EMstep <- function(X, p0, a0, s0) {
  M <- length(p0)
  n <- length(X)
  w <- matrix(nrow=n, ncol=M)
  Wc <- numeric(M)
  for (j in 1:n) {
    for (m in 1:M) {
      w[j,m] <- p0[m] * dnorm(X[j], a0[m], sqrt(s0[m]))
    }
    WS <- sum(w[j,])
    w[j,] <- w[j,] / WS
  }
  for (m in 1:M) {
    Wc[m] <- sum(w[,m])
    a0[m] <- sum(w[,m] * X) / Wc[m]
    s0[m] <- sum(w[,m] * (X - a0[m])^2) / Wc[m]
  }
  p0 <- Wc / sum(Wc)
  return(data.frame(p=p0, a=a0, s=s0))
}

# ЕМ-алгоритм
EMalgorithm <- function(X, p, a, s, delta=0.0001, MaxIter=100) {
  M <- length(p)
  z <- data.frame(p, a, s)
  B <- 0
  repeat {
    z1 <- EMstep(X, z$p, z$a, z$s)
    B <- B + 1
    if (sum(abs(z1 - z)) < delta || B > MaxIter) break
    z <- z1
  }
  return(z1)
}

z <- EMalgorithm(X, p0, a0, s0)

# Функція щільності
dens <- Vectorize(function(x, z) {
  sum(sapply(1:M, function(i) z$p[i] * dnorm(x, z$a[i], sqrt(z$s[i]))))
}, "x")

hist(X, probability=TRUE)
curve(dens(x, z), col="blue", add=TRUE)