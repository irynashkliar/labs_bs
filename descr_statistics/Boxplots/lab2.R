# Робота з компаніями Ford, EW, EXPE
setwd("/Users/irynashkliar/Downloads/tables")

# Ford
x <- read.csv("table_f.csv", header=F)
colnames(x) <- c("dat", "z", "opn", "mx", "mn", "clo", "vol")
lr <- log(x$clo[-nrow(x)]/x$clo[-1])
mr <- log(x$mx/x$mn)
or <- log(x$opn/x$clo)

# EW
y <- read.csv("table_ew.csv", header=F)
colnames(y) <- c("dat", "z", "opn", "mx", "mn", "clo", "vol")
lr1 <- log(y$clo[-nrow(y)]/y$clo[-1])
mr1 <- log(y$mx/y$mn)
or1 <- log(y$opn/y$clo)

# EXPE
z <- read.csv("table_expe.csv", header=F)
colnames(z) <- c("dat", "z", "opn", "mx", "mn", "clo", "vol")
lr2 <- log(z$clo[-nrow(z)]/z$clo[-1])
mr2 <- log(z$mx/z$mn)
or2 <- log(z$opn/z$clo)

# Побудова boxplot
boxplot(mr, lr, or, names=c("mr", "lr", "or"))
boxplot(mr, lr, or, outline=F, names=c("mr", "lr", "or"))