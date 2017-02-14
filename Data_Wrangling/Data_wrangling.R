### Existing local data
mydata1 <- read.csv("C:/Users/Admin/Documents/GitHub/Data-Analysis-Using-R_Self/Data_Wrangling/student-mat.csv",sep=";",header=TRUE)
head(mydata1)
mydata2 <- read.table("C:/Users/Admin/Documents/GitHub/Data-Analysis-Using-R_Self/Data_Wrangling/student-mat.csv",sep=";",header=TRUE)
head(mydata2)


### Help with some external data
install.packages("quantmod")
library(quantmod)
getSymbols("AAPL")
barChart(AAPL)
barChart(AAPL['2015-10-01::2015-10-12'])


### Accessing data from HTML webpage
### Needed package
install.packages("XML")
library(XML)
u <- 'http://finance.yahoo.com/q/op?s=AAPL+Options'
tables = readHTMLTable(u)
names(tables)
tables[[2]] ### Accessing table #2 as an example
### Directly accessing table number 2 as an example
doc = htmlParse(u)
tableNodes = getNodeSet(doc, "//table")
tb = readHTMLTable(tableNodes[[2]])
tb
