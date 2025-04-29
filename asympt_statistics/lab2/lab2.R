library(readxl)

# Завантаження даних
x <- read_excel("~/Downloads/regrasympt/values.xls", col_names=TRUE)
n <- nrow(x)

# Побудова графіку
plot((x$WorkImp) + runif(n, -0.5, 0.5), (x$Happyness) + runif(n, -0.5, 0.5), cex=0.3)

# Фільтрація для Києва і позитивних значень
x <- x[x$Region == 804011, ]
x <- x[(x$WorkImp > 0) & (x$Happyness > 0), c("WorkImp", "Happyness")]

# Побудова таблиці спряженості
tbl <- table(x)

# Звичайний тест χ²
chisq.test(tbl)

# Імітаційний тест χ²
set.seed(4)
chisq.test(tbl, simulate.p.value=TRUE)