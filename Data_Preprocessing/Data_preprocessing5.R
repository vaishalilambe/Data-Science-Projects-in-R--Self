### Dummy variables
install.packages("dummy")
library(dummy)
data=data.frame(gender=c('M','F','F','M'),age=c(20,30,40,50))
data
data$gender <- factor(data$gender) ### Creating factors
is.factor(gender_new)
data$gender
### Creating dummies
new_gender=dummy(data, p = "all", object = NULL, int = FALSE, verbose = FALSE)
new_gender
cbind(data,new_gender)
