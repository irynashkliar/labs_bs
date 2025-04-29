# Ієрархічна кластеризація
z <- read.table("/Users/irynashkliar/Downloads/multi/F9t.txt", header=F)
res <- princomp(z)

# Метод найближчого сусіда
z.dist <- dist(res$scores[,1:3])
z.hclust <- hclust(z.dist, method="single")
plot(as.dendrogram(z.hclust), leaflab="none")
groups3 <- cutree(z.hclust, k=3)
plot(res$scores[,c(1,3)], col=c("red","blue","green")[groups3])

# Інші методи
z.hclust <- hclust(z.dist, method="complete")
plot(as.dendrogram(z.hclust), leaflab="none")
z.hclust <- hclust(z.dist, method="average")
plot(as.dendrogram(z.hclust), leaflab="none")

# Інші відстані
z.dist <- dist(res$scores[,1:3], method="maximum")
z.hclust <- hclust(z.dist)
plot(as.dendrogram(z.hclust), leaflab="none")

z.dist <- dist(res$scores[,1:3], method="manhattan")
z.hclust <- hclust(z.dist)
plot(as.dendrogram(z.hclust), leaflab="none")

# Частина В
filenames <- list.files(path="/Users/irynashkliar/Downloads/tables", full.names=TRUE)
datalist <- lapply(filenames, function(x){x0 <- read.csv(file=x, header=F)[,c(1,6)]; colnames(x0) <- c("data", unlist(strsplit(x,"[_.]"))[2]); x0})
y <- Reduce(function(x,y) {merge(x,y,by="data")}, datalist)
W <- log(y[,-1])
res <- princomp(W)
plot(res)