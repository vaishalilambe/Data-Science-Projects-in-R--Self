### Adding new column
### By equation
fy <- c(2010,2011,2012,2010,2011,2012,2010,2011,2012) 
company <- c("Apple","Apple","Apple","Google","Google",
             "Google","Microsoft","Microsoft","Microsoft") 
revenue <- c(65225,108249,156508,29321,37905,50175,62484,69943,73723) 
profit <- c(14013,25922,41733,8505,9737,10737,18760,23150,16978) 
companiesData <- data.frame(fy, company, revenue, profit)
companiesData$margin <- (companiesData$profit / companiesData$revenue) * 100
companiesData$margin <- round(companiesData$margin, 1)
companiesData

### By R's transform
companiesData <- transform(companiesData, 
                           margin = round((profit/revenue) * 100, 1))
companiesData

### By apply() function
companiesData$margin <- apply(companiesData[,c('revenue', 'profit')], 1, 
                              function(x) { (x[2]/x[1]) * 100 } )
companiesData
### By mapply() function
companiesData$margin <- mapply(function(x, y) round((x/y) * 100, 1), 
                               companiesData$profit, companiesData$revenue)
companiesData

### Using 'dplyr' package
library(dplyr)
companiesData <- mutate(companiesData, margin = round((profit/revenue) * 100, 1))
companiesData 
