# Лабораторна 3 — Логістична регресія для вин
w2 <- read.csv2(file="~/Downloads/regrasympt/wine.csv", header=TRUE)
w2 <- w2[w2$Site != 3,]
w2$Site <- w2$Site - 1
attach(w2)

# Модель 1
res <- glm(Site ~ OD + Proline + Alcogol + Malic_acid, family=binomial())
clasif <- as.numeric(fitted.values(res) > 0.5)
table(clasif, Site)

# Модель 2
res <- glm(Site ~ Proline + Alcogol + Malic_acid, family=binomial())
clasif <- as.numeric(fitted.values(res) > 0.5)
table(clasif, Site)

# Модель 3
res <- glm(Site ~ Alcogol + Malic_acid, family=binomial())
clasif <- as.numeric(fitted.values(res) > 0.5)
table(clasif, Site)

# Модель 4
res <- glm(Site ~ Proline + OD, family=binomial())
clasif <- as.numeric(fitted.values(res) > 0.5)
table(clasif, Site)