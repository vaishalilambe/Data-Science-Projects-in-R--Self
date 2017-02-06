install.packages("sqldf")
library(sqldf)
set.seed(1)
d1 <- data.frame(x=7:12, y1=rnorm(6))
d2 <- data.frame(x=4:9, y2=rnorm(6))
d1
d2
sqldf()
d <- sqldf("select * from d1 inner join d2 on d1.x=d2.x")
sqldf()
d

