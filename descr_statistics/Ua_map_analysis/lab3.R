# Побудова карти України
setwd("/Users/irynashkliar/Downloads/map")

dat <- read.csv("geoMap.csv", header=T, stringsAsFactors=F)
nams <- read.csv("ukraine.csv", header=T)
datn <- merge(nams, dat, by="Region", all=T)
x <- datn$perc_Elis / (datn$perc_Elis + datn$perc_Boris)

install.packages('terra', repos='https://rspatial.r-universe.dev')
install.packages('raster')
install.packages('maptools')

library(raster)
library(sp)
library(maptools)

ukraine <- getData('GADM', country='UKR', level=1)
save(ukraine, file="/Users/irynashkliar/Downloads/ukrmap.Rdata")
load(ukraine)

numcol <- 7
brkMP <- c(min(x)-0.001, seq(min(x)+0.001, max(x)+0.001, length.out=numcol+1))
intMP <- numcol+2 - findInterval(x, brkMP)
palette(c(heat.colors(numcol, alpha=1), rgb(1,1,1)))
par(xpd=TRUE, mar=c(0,0,0,0))
plot(ukraine, col=intMP[order(datn$n)])
legend("bottomright", title="Queen %", legend=c("<85","<75","<60","<50","<30","<20","<10","0"), fill=c(heat.colors(numcol, alpha=1), rgb(1,1,1)), inset=0, horiz=F)