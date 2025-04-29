# Кореляційний аналіз
filenames <- list.files(path="/Users/irynashkliar/Downloads/tables", full.names=TRUE)
datalist <- lapply(filenames, function(x){x0 <- read.csv(file=x, header=F)[,c(1,6)]; colnames(x0) <- c("data", unlist(strsplit(x,"[_.]"))[2]); x0})
y <- Reduce(function(x,y) {merge(x,y,by="data")}, datalist)

M <- cor(y[,-1])
install.packages('corrplot')
library(corrplot)
corrplot.mixed(M)
corrplot(M)
corrplot(M, order="hclust", addrect=6)

install.packages('vctrs')
install.packages('ggplot2')
install.packages('qgraph')
library(qgraph)
qgraph(M, layout="spring", threshold=0.5, labels=colnames(M))

# log returns
H <- y[,-1]
W <- log(H)
pairs(W[,c("f","eqt","expe")])
W01 <- cor(W, method="pearson")
corrplot(W01, order="hclust", addrect=6)