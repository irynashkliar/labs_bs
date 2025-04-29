# Визначення власних функцій

# експоненційна щільність
dexp_custom <- function(x, rate) {
  rate * exp(-rate * x)
}

# функція відношення вірогідності
likelihood_ratio <- function(x, n, lambda0, lambda1) {
  (lambda1 / lambda0)^n * exp(-(lambda1 - lambda0) * sum(x))
}

# Параметри
lambda0 <- 6 # Гіпотеза H0
lambda1 <- 5 # Гіпотеза H1
n <- 55
alpha <- 0.05

# Генерація вибірки 
x <- rexp(n, lambda0)

# Відношення вірогідності
lr <- likelihood_ratio(x, n, lambda0, lambda1)

# Імітаційне моделювання
B <- 10000
lr_sim <- replicate(B, likelihood_ratio(rexp(n, lambda0), n, lambda0, lambda1))
c <- quantile(lr_sim, alpha)

# Рішення тесту
decision <- ifelse(lr <= c, "відхилити H0", "прийняти H0")
cat("Результат:", decision, "\n")

# Поріг за асимптотичною формулою
z_alpha <- qnorm(1 - alpha)
math_spos <- -(n/2) * (lambda1 - lambda0)^2 / lambda0
disp <- (lambda1 - lambda0)^2 / lambda0
threshold_approx <- exp(math_spos + z_alpha * sqrt(disp))
cat("Поріг за асимптотичною формулою:", threshold_approx, "\n")

# Потужність тесту
lambda_alt <- 5.5
power_approx <- pnorm((lambda_alt - lambda0) / sqrt(lambda0 / n), lower.tail=FALSE)
cat("Наближена потужність для lambda =", lambda_alt, ":", power_approx, "\n")

# Перевірка через імітацію
power_sim <- mean(replicate(B, likelihood_ratio(rexp(n, lambda_alt), n, lambda0, lambda1) <= c))
cat("Потужність для lambda =", lambda_alt, ":", power_sim, "\n")

# Мінімальний обсяг вибірки для потужності 0.95
target_power <- 0.95
n_min <- ceiling((qnorm(target_power) / ((lambda1 - lambda0) / lambda0))^2 * 2)
cat("Мінімальний обсяг вибірки:", n_min, "\n")