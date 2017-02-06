### Detecting outliers
### First replace missing values with zero
data <- data.frame(x=c(.1,.2,NaN,-20,.8,.9,.5,.1,1),y=c(2,NaN,.5,20,1,.3,.1,.8,.9))
data
for(i in 1:ncol(data)){
  data[is.na(data[,i]), i] <- 0
}
data
### Detecting, filtering outliers and replacing with mean of column
for(j in 1:ncol(data)){
  for (i in 1:nrow(data)){
    if ((data[i,j] < (mean(data[[j]])-(1.5)*sd(data[[j]]))|
       (data[i,j] > (mean(data[[j]])+1.5*sd(data[[j]]))))) 
    {data[i,j]<-mean(data[[j]])}
  }
}
data 

