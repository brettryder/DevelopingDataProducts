setwd("~/LongRunExchangeRate")
library(zoo)
library(dplyr)
XR<-read.csv("rxr.csv",header=TRUE,sep=",")
RY<-read.csv("ry.csv",header=TRUE,sep=",")
GDP<-read.csv("GDP.csv",header=TRUE,sep=",")
GDP$date<-NULL
Pop<-read.zoo("Pop.csv",header=TRUE,sep=",")

XR1<-XR[,c("CN","ID","IN","JP","KR","MY","SG","TH")]
RY1<-RY[,c("CN","ID","IN","JP","KR","MY","SG","TH")]
Y1<-GDP[,c("CN","ID","IN","JP","KR","MY","SG","TH")]

Y1$CN<-GDP$CN/Pop$CN*1000000
Y1$ID<-GDP$ID/Pop$ID*1000000
Y1$IN<-GDP$IN/Pop$IN*1000000
Y1$JP<-GDP$JP/Pop$JP*1000000
Y1$KR<-GDP$KR/Pop$KR*1000000
Y1$MY<-GDP$MY/Pop$MY*1000000
Y1$SG<-GDP$SG/Pop$SG*1000000
Y1$TH<-GDP$TH/Pop$TH*1000000


colnames(XR1)<-c("xrcn","xrid","xrin","xrjp","xrkr","xrmy","xrsg","xrth")
colnames(RY1)<-c("rycn","ryid","ryin","ryjp","rykr","rymy","rysg","ryth")
colnames(Y1)<-c("ycn","yid","yin","yjp","ykr","ymy","ysg","yth")

Y1$yid<-na.approx(Y1$yid)
RY1$rykr[50:150]<-na.approx(RY1$rykr[50:150])

mdata<-cbind(XR1,RY1)
mdata<-cbind(mdata,Y1)

setwd("~/Coursera/DevDataProducts/App-1")
write.csv(mdata,file="~/Coursera/DevDataProducts/App-1/data/mdata.csv")
