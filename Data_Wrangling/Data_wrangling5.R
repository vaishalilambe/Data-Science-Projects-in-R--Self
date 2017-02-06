### Reshaping and pivoting
install.packages("reshape")
library(reshape)
set.seed(1)
d1 <- data.frame(id=c(1,2,3,1,2),x=6:10, y=rnorm(5))
d1
d2=t(d1) ### Matrix transpose
d2
d3=melt(d1,id="id") ### Reshaping
d3
id.means <- cast(d3, id~variable, mean) ### Mean function pivot for "id"
id.means
### Converting long and wide format
install.packages('reshape2')
library('reshape2')
attach(USArrests)
head(USArrests)
head(melt(USArrests))
tail(melt(USArrests))
melt_data<- melt(USArrests, id.vars = c("Murder", "Assault"))
head(melt_data)
tail(melt_data)
head(dcast(melt_data, Murder + Assault ~ variable))
### Filtering
attach(mtcars)
### Bracket notation
head(mtcars[,c(2,4)]) ### Columns 2 and 4
head(mtcars[mtcars$mpg>20,]) ### All columns with mpg > 20
head(mtcars[mtcars$mpg>20,c("mpg","hp")]) ### 'mpg' and 'hp' columns mpg > 20
detach()
### Subset function
head(subset(mtcars, , c("mpg", "hp"))) ### All rows with 'mpg' and 'hp' columns

### Filter and select functions
install.packages("dplyr")
library(dplyr)
attach(iris)
head(iris)
head(filter(iris,Sepal.Length>4.5))
head(select(iris, Petal.Width, Species))

### Chaining operation
head(iris %>% filter(Sepal.Length>4.5) %>% select(Petal.Width, Species))
