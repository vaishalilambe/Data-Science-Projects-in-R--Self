### Descriptive data summarization
x=c(1,3,4,6,2,2,3,5,3,7,2,9)
y=c(2,3,3,5,4,4,8,1,3,6,8,5)
summary(x)
z <- data.frame(x,y)
str(z)
install.packages('psych')
library(psych)
describe(z)
apply(z,2,mean)
apply(z,2,sd)
apply(z,2,median)

### Histogram, box plot and scatter plot
hist(x, main="Histogram of x")
boxplot(x, main="Boxplot of x")
plot(x,y, main="Scatterplot of x vs y")
### Probability Mass Function
plot(density(x))
### Q-Q Plot for two samples
qqplot(x,y,main="Q-Q plot of x and y")
abline(0,1)
### Side-by-Side Boxplot
data_test=data.frame(age=c(45,35,67,23,43,24,32,41,61,25),
                gender=c('M','F','F','M','F','M','M','F','F','M'))
boxplot(data_test$age~data_test$gender)
### Cross-Tabs
cat=data.frame(color=c('blue','green','red','blue','red','green','red','blue'),
               type=c('a','a','b','c','c','a','c','b'))
table(cat)
### Removing NaN
x=c(1,3,4,6,2,NaN,3,5,3,7,2,9)
y=c(2,3,3,5,4,4,8,1,3,NaN,8,5)
data <- cbind(x,y)
data
data[complete.cases(data),]
### Replacing NaN with mean
x=c(1,3,4,6,2,NaN,3,5,3,7,2,9)
y=c(2,3,3,5,4,4,8,1,3,NaN,8,5)
data <- cbind(x,y)
means <- colMeans(data, na.rm=TRUE) 
means
for (i in 1:ncol(data)){ 
       data[is.na(data[, i]), i] <- means[i] 
  } 
data
### z-score Normalizing
install.packages("clusterSim")
library(clusterSim)
data.Normalization (data,type="n1",normalization="column")
### Min-Max Normalizing
data.Normalization (data,type="n4",normalization="column")

