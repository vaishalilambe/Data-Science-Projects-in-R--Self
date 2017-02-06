install.packages('ggplot2')
library(ggplot2)
ggplot(mtcars, aes(x=disp, y=mpg),main='mpg vs.disp') + geom_line() + geom_point()
ggplot(mtcars, aes(factor(cyl))) + geom_bar()
par(mfrow=c(1,2))
boxplot(mtcars$disp~mtcars$cyl,main='Boxplot of disp and cyl')
boxplot(mtcars$mpg~mtcars$cyl,main='Boxplot of mpg and cyl')



