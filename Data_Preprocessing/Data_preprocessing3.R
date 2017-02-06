### Correlation coefficient
data=data.frame(a=c(1,7,0,5,2),b=c(2,0,2,2,4),c=c(3,-1,4,3,1))
data
cor(data$a,data$b)
cor(data$b,data$a)
cor(data$a,data$c)
cor(data$b,data$c)
cor(data) ### Correlation matrix

