library(shiny)
library(zoo)

#read in raw data files at start 
mdata <- read.csv("data/mdata.csv")
M.date<-seq(from=1849,to=2014)
data<-zoo(mdata,M.date)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {  
       
        output$Plot <- renderPlot({
                #Link the country selected to the relevant country data
                #x=log(real per capita GDP)
                x <- switch(input$country, 
                            "CHINA" = data$rycn,
                            "INDIA" = data$ryin,
                            "INDONESIA" = data$ryid,
                            "JAPAN" = data$ryjp,
                            "KOREA"=data$rykr,
                            "MALAYSIA"=data$rymy,
                            "SINGAPORE"=data$rysg,
                            "THAILAND"=data$ryth)
                #y=log(real exchange rate)
                y <- switch(input$country, 
                            "CHINA" = data$xrcn,
                            "INDIA" = data$xrin,
                            "INDONESIA" = data$xrid,
                            "JAPAN" = data$xrjp,
                            "KOREA"=data$xrkr,
                            "MALAYSIA"=data$xrmy,
                            "SINGAPORE"=data$xrsg,
                            "THAILAND"=data$xrth)
                #z=country real GDP per capita (in levels)
                z <- switch(input$country, 
                            "CHINA" = data$ycn,
                            "INDIA" = data$yin,
                            "INDONESIA" = data$yid,
                            "JAPAN" = data$yjp,
                            "KOREA"=data$ykr,
                            "MALAYSIA"=data$ymy,
                            "SINGAPORE"=data$ysg,
                            "THAILAND"=data$yth)
                #Calculate the maximum & minimum data points for scaling of plot
                maxx<-max(x,na.rm=TRUE)
                minx<-min(x,na.rm=TRUE)
                maxy<-max(y,na.rm=TRUE)
                miny<-min(y,na.rm=TRUE)
                mx<-max(maxx,maxy)+0.5
                mn<-min(minx,miny)-0.5
                
                #divide the sample into years in which GDP > or < cutoff
                sm<-sum(as.numeric(z<input$cutoff),na.rm=TRUE)
                xold=x
                #multiply low GDP levels by -1 to invert the relationship
                x[1:sm]=(-1)*x[1:sm]+2*as.numeric(x[sm])
                #plot the data             
                plot(x,xlab="",main=input$country,ylim=c(mn,mx),ylab="")
                lines(y,col="red")
                lines(xold,col="green")
                abline(h=0)
                legend("bottomleft",c("Adjusted GDP","Exchange Rate","Original GDP"),col=c(1,2,3),lty=1,bty="n")
        }, width = "auto", height = "auto")
})
