### Sorting
library(dplyr)
library(plyr)
attach(mtcars)
### Using order function
mtcars_Ordered <- order(mtcars$mpg)
mtcars_Ordered ### This is just the order of rows
mtcars_ordered <- mtcars[mtcars_Ordered,] ### mpg ordered mtcars
head(mtcars_ordered)

### Descending order
mtcars_ordered <- mtcars[order(-mtcars$mpg),]
head(mtcars_ordered)

### Sorting more than one column
mtcars_ordered <- mtcars[order(mtcars$mpg,-mtcars$cyl),]
head(mtcars_ordered)
### or 
mtcars_ordered <- mtcars[with(mtcars,order(mpg,-cyl)),]
head(mtcars_ordered)

### Using doBy package
install.packages('doBy')
library(doBy)
mtcars_ordered <- orderBy(~mpg-cyl,data=mtcars)
head(mtcars_ordered)

### Using arrange function
mtcars_ordered <- arrange(mtcars, mpg, desc(cyl))
head(mtcars_ordered)


