### Creating data frame
fy <- c(2010,2011,2012,2010,2011,2012,2010,2011,2012) 
company <- c("Apple","Apple","Apple","Google","Google",
             "Google","Microsoft","Microsoft","Microsoft") 
revenue <- c(65225,108249,156508,29321,37905,50175,62484,69943,73723) 
profit <- c(14013,25922,41733,8505,9737,10737,18760,23150,16978) 
companiesData <- data.frame(fy, company, revenue, profit)
companiesData$margin <- (companiesData$profit / companiesData$revenue) * 100
companiesData$margin <- round(companiesData$margin, 1)
companiesData

### Getting summary of each company based on maximum margin
install.packages('plyr')
library(plyr)
highestProfitMargins <- ddply(companiesData, 'company', summarize, 
                              bestMargin = max(margin))
highestProfitMargins ### Columns of company and bestMarging
highestProfitMargins <- ddply(companiesData, 'company', transform, 
                             bestMargin = max(margin))
highestProfitMargins ### All columns
### Applying more than one function 
myResults <- ddply(companiesData, 'company', transform, 
                   highestMargin = max(margin), lowestMargin = min(margin))
myResults
### Using dplyr to see the highest margin of data
### First creating two columns of max and min of marging
myresults <- companiesData %>% group_by(company) %>%    
  mutate(highestMargin = max(margin), lowestMargin = min(margin))
myresults
highestProfitMargins <- companiesData %>% group_by(company) %>%    
  summarise(bestMargin = max(margin))
highestProfitMargins ### Highest margin of the data

### Grouping by date range
vDates <- as.Date(c("2013-06-01","2013-07-08","2013-09-01","2013-09-15"))
### Sorting based on month
vDates.bymonth <- cut(vDates, breaks = "month")
dfDates <- data.frame(vDates, vDates.bymonth)
dfDates
