# Перевірка гіпотез для біноміального розподілу
set.seed(3)
alpha <- 0.05
n <- 65
B <- 10000
p0 <- 0.5
p1 <- 3/5
m <- 2

S_fun <- function(p0, p1) {
  S <- log(p1*(1-p0)/(p0*(1-p1)))
  return(S)
}
s <- S_fun(p0, p1)
S0 <- replicate(B, {
  k0 <- rbinom(n, m, p0)
  log(p1*(1-p0)/(p0*(1-p1))) * k0
})
c_alpha <- quantile(S0, 1-alpha)
mean(S0 > s)

f0 <- function(x){log(dbinom(x, m, p0))}
f1 <- function(x){log(dbinom(x, m, p1))}
lr <- function(x){sum(sapply(x, f1) - sapply(x, f0))}
gen0 <- function(n)rbinom(n, m, p0)
gen1 <- function(n)rbinom(n, m, p1)
lr0 <- replicate(B, lr(gen0(n)))
lr1 <- replicate(B, lr(gen1(n)))
Ca <- quantile(lr0, 1-alpha)
mean(lr1 < Ca)

mi <- min(c(lr0, lr1))
mx <- max(c(lr0, lr1))
hist(lr0, breaks=15, probability=TRUE, angle=0, density=12, xlim=c(mi,mx), col="red", xlab="lr")
hist(lr1, breaks=15, probability=TRUE, angle=90, density=12, xlim=c(mi,mx), col="blue", add=TRUE)
abline(v=Ca)