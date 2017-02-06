data=data.frame(x=c(1,3,2,4,5,6,4,2,5),y=c(2,4,2,7,4,3,2,1,8))
data
set.seed(1)
#### Half of rows as sample
data_sample=sample(1: nrow(data), 0.5*nrow(data)) 
data[data_sample,]
