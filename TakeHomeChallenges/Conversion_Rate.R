#libraries needed
unloadNamespace("dplyr")
unloadNamespace("randomForest()")
install.packages("dplyr")
library(dplyr)
library(rpart)
library(ggplot2)

install.packages("randomForest")
library(randomForest)
getwd()
setwd("C:/Users/Admin/Documents/DataScience/PracticeProject/TakeHomeChallenges")
#read data from conversion_data.csv
data = read.csv('conversion_data.csv')
head(data)

#structure data in string
str(data)

#summary of data
summary(data)

#investigate abour max age 123
sort(unique(data$age), decreasing=TRUE)

#
subset(data, age>79)

#remove data for age>79 it is unrealistics
data = subset(data, age<80)
head(data)

#sense the data
data_country = data %>%
  group_by(country) %>%
  summarise(conversion_rate = mean(converted))
data_country
ggplot(data=data_country, aes(x=country, y=conversion_rate))+
  geom_bar(stat = "identity", aes(fill = country))

#
data_pages = data %>%
  group_by(total_pages_visited) %>%
  summarise(conversion_rate = mean(converted))
data_pages
qplot(total_pages_visited, conversion_rate, data=data_pages, geom="line")

# machine learning
data$converted = as.factor(data$converted) # let's make the class a factor
data$new_user = as.factor(data$new_user) #also this a factor
levels(data$country)[levels(data$country)=="Germany"]="DE" 
# Shorter name, easier to plot.

train_sample = sample(nrow(data), size = nrow(data)*0.66)
train_data = data[train_sample,]
test_data = data[-train_sample,]
rf = randomForest(y=train_data$converted, x = train_data[, -ncol(train_data)],
                  ytest = test_data$converted, xtest = test_data[, -ncol(test_data)],
                  ntree = 100, mtry = 3, keep.forest = TRUE)
rf

#checking variable importance
varImpPlot(rf,type=2)

#
rf = randomForest(y=train_data$converted, x = train_data[, -c(5, ncol(train_data))],                                                               
                  ytest = test_data$converted, xtest = test_data[, -c(5, ncol(train_data))],
                  ntree = 100, mtry = 3, keep.forest = TRUE, classwt = c(0.7,0.3))
rf

#Re-checking variable importance
varImpPlot(rf,type=2)

#partial dependance plots for variables
op <- par(mfrow=c(2, 2))
partialPlot(rf, train_data, country, 1)
partialPlot(rf, train_data, age, 1)
partialPlot(rf, train_data, new_user, 1)
partialPlot(rf, train_data, source, 1)

#
tree = rpart(data$converted ~ ., data[, -c(5,ncol(data))],
             control = rpart.control(maxdepth = 3),
             parms = list(prior = c(0.7, 0.3))
)
tree
