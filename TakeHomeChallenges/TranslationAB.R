
setwd("C:/Users/Admin/Documents/DataScience/PracticeProject/TakeHomeChallenges")
#libraries needed
require(dplyr)
require(rpart)
require(ggplot2)
#read data
user = read.csv("user_table.csv")
test = read.csv("test_table.csv")
#let's create one data set
length(unique(test$user_id)) == length(test$user_id) # are there dupes?
length(unique(user$user_id)) == length(user$user_id) # are there dupes?
length(user$user_id) - length(test$user_id) # everyone in one table also in the other one?
data = merge(test,user, by = "user_id", all.x = TRUE) # this way we don't lose data
data$date = as.Date(data$date)
summary(data)

data_conversion_country = data %>%
  group_by(country) %>%
  summarize( conversion = mean(conversion[test == 0]))%>% # we check the old version
  arrange (desc(conversion))
head(data_conversion_country)

#a simple t-test here should work. We have collected ~0.5MM data and test/control split is ~50/50.
data_test = subset(data, country != "Spain") #nothing changed in Spain, so no point in keeping those users
t.test(data_test$conversion[data_test$test == 1], data_test$conversion[data_test$test == 0])

data_test_by_day = data_test %>%
  group_by(date) %>%
  summarize(test_vs_control = mean(conversion[test==1])/
              mean(conversion[test==0])
  )
qplot(date, test_vs_control, data= data_test_by_day, geom = "line")

tree = rpart(test ~ .,data_test[,-8], #we remove conversion. Doesn't matter now.
             control = rpart.control(minbucket = nrow(data_test)/100, maxdepth =2)) 
???# we only look for segments representing at least 1% of the population.)
tree # here we are not too interested in predictive powe????, we are mainly using thetree as a descriptive stat tool.


data_test_country = data_test %>%
  group_by(country) %>%
  summarize(p_value = t.test( conversion[test==1],conversion[test==0])$p.value,
             conversion_test = t.test( conversion[test==1],conversion[test==0])$estimate[1],
             conversion_control = t.test( conversion[test==1],conversion[test==0])$estimate[2]) %>%
  arrange (p_value)
data_test_country
