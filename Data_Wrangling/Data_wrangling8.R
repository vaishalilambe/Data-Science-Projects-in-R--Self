### Replacing missing values with zero
data <- data.frame(x=c(1,2,NaN,5),y=c(4,NaN,3,7))
data
for(i in 1:ncol(data)){
  data[is.na(data[,i]), i] <- 0
}
data

for(j in 1:ncol(data)){
    for (i in 1:nrow(data)){
         if ((data[i,j] < 0.5*mean(data[[j]]))|(data[i,j] > 2*mean(data[[j]]))) 
{data[i,j]<-mean(data[[j]])}
    }
}
data          


 
