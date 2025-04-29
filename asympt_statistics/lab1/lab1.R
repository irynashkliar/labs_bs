# Завантаження даних
fish <- read.table(file="~/Downloads/regrasympt/fish.txt", header=TRUE)
fish_type <- fish$Var1

# Оцінка параметрів
m <- mean(fish_type)
std <- sqrt(var(fish_type))

# Побудова гістограми та накладення теоретичної кривої
hi <- hist(fish_type, density=20, breaks=10, xlab="x-variable", ylim=c(0, 45), main="absolute frequencies")
curve(dnorm(x, mean=m, sd=std) * length(fish_type) * (hi$breaks[2]-hi$breaks[1]), col="darkblue", lwd=2, add=TRUE, yaxt="n")

# Перевірка експоненційності через логарифмування
hist(log(fish_type))

# Тест χ²
r <- hist(fish_type, breaks=10, plot=FALSE)
nn <- r$counts      # емпіричні частоти
b <- r$breaks       # межі комірок
h <- b[2] - b[1]    # ширина комірки
x <- b[-length(b)] + h/2       # середини комірок
m <- sum(x * nn) / sum(nn)     # оцінка математичного сподівання

# Оцінка дисперсії з поправкою Шеппарда
s <- sqrt(sum((x - m)^2 * nn) / sum(nn) + h^2 / 12)
pp <- pnorm(b, mean=m, sd=s)       # теоретичні ймовірності
pp[c(1,length(b))] <- c(0,1)       # розширюємо крайні комірки

nth <- length(fish_type) * (pp[-1] - pp[-length(pp)])    # теоретичні частоти
chi2emp <- sum((nn - nth)^2 / nth)       # статистика тесту χ²

# p-value
p_value <- 1 - pchisq(chi2emp, df=length(b) - 4)    # досягнутий рівень значущості
cat("Досягнутий рівень значущості (p-value):", p_value, "\n")