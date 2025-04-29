# PCA і 3D візуалізація
z <- read.table("/Users/irynashkliar/Downloads/multi/F9t.txt", header=F)
pairs(z, cex=0.1)

res <- princomp(z)
plot(res)

plot(res$scores[,1:2])
plot(res$scores[,2:3])
plot(res$scores[,c(1,3)])

library(rgl)
plot3d(res$scores[,1:3])
plot3d(res$scores[,1:3], col=c("red","blue","green"))

plot(res$scores[,4:5])
plot(res$scores[,5:6])
plot(res$scores[,c(4,6)])
plot(res$scores[,c(4,6)], col=c("red","blue","green"))
plot3d(res$scores[,4:6], col=c("red","blue","green"))