setwd("C:/Users/Admin/Documents/DataScience/PracticeProject/TakeHomeChallenges")

#libraries needed
require(dplyr)
require(rpart)
require(ggplot2)
require(scales)

data = read.csv("employee_retention_data.csv")
str(data) #check the structure

data$company_id = as.factor(data$company_id) # this is a categorical var
data$join_date = as.Date(data$join_date) #make it a date
data$quit_date = as.Date(data$quit_date) #make it a date
summary(data) # everything seems to make sense, some simple plots would help double check that

unique_dates = seq(as.Date("2011/01/24"), as.Date("2015/12/13"), by = "day") # create list of unique dates for the table
unique_companies = unique(data$company_id) #ceate list of unique companies
data_headcount = merge(unique_dates, unique_companies, by = NULL) #cross join so I get all combinations of dates and companies. Will need it later.
colnames(data_headcount) = c("date", "company_id") #now I get for each day/company, how many people quit/got hired on that day
data_join = data %>%
  group_by(join_date, company_id) %>%
  summarise(join_count = length(join_date))
data_quit = data %>%
  group_by(quit_date, company_id) %>%
  summarise(quit_count = length(quit_date))
#Now I left outer join with data_headcount.
#NA means no people were hired/quit on that day cause there is no match.
data_headcount = merge (data_headcount, data_join,
                        by.x = c("date", "company_id"),
                        by.y = c("join_date", "company_id"),
                        all.x = TRUE)
data_headcount = merge (data_headcount, data_quit,
                        by.x = c("date", "company_id"),
                        by.y = c("quit_date", "company_id"),
                        all.x = TRUE)
#replace the NAs with 0
data_headcount$join_count[is.na(data_headcount$join_count)] = 0
data_headcount$quit_count[is.na(data_headcount$quit_count)] = 0
#Now I need the sum by company_id. Data set is already ordered by date,
# so I can simply use dplyr to group by company_id and do cumsum
data_headcount = data_headcount %>%
  group_by(company_id) %>%
  mutate ( join_cumsum = cumsum(join_count),
           quit_cumsum = cumsum(quit_count)
  )
# finally, for each date I just take join_count - quit_count and I am done
data_headcount$count = data_headcount$join_cumsum - data_headcount$quit_cumsum
data_headcount_table = data.frame(data_headcount[, c("date", "company_id","count")])
#Another way to do it would be with a for loop.
#While you often hear that you should avoid for loops in R as much as possible,
#in some cases you don't care that much about processing time, and you are
#willing to have something slower but more understandable.
#Other data scientists reading your code in future (or even yourself) will appreciate 87
## [1] TRUE
#Now let's try to understand employee retention. Here the main challenge is about feature engineering.
#That is, extract variables from the quitting_date column.

#Let's try with the for loop. Again here we optimize for future readibility!
# This is as slow as it can possibly be, but much clearer.
loop_cumsum = c() #intialize empty vector
loop_date = c()
loop_company = c()
for (i in seq(as.Date("2011/01/24"), as.Date("2015/12/13"), by = "day")) { #loop through all days
  for (j in unique(data$company_id)){ # loop through all companies
    tmp_join = nrow(subset(data, join_date <= i & company_id == j)) # count joins until that day
    tmp_quit = nrow(subset(data, quit_date <= i & company_id == j)) # count quits
    loop_cumsum = c(loop_cumsum, tmp_join - tmp_quit )
    loop_date = c(loop_date, i)
    loop_company = c(loop_company, j)
  }
  data_headcount_table_loop = data.frame(date = as.Date(loop_date, origin = '1970-01-01'), #fix R date
                                         company_id = loop_company,
                                         count = loop_cumsum)
}
#Let's finally check the two data sets are exactly the same:
identical (data_headcount_table[order(data_headcount_table[,1],
                                      as.numeric(as.character(data_headcount_table[,2] ))),],
           data_headcount_table[order(data_headcount_table[,1],
                                      as.numeric(as.character(data_headcount_table[,2]))),]
)

# how many days was she employed? This should matter.
#People might get bored in the same place for too long
data$employment_length = as.numeric(data$quit_date - data$join_date)
#In general, whenever you have a date, extract week of the year, and day of the week. They tend to give an idea of seasonlity and weekly trends.
#In this case, weekly trends probably don't matter. So let's just get week of the year
data$week_of_year = as.numeric(format(data$quit_date, "%U"))

#Let's plot employee length in days
hist(data$employment_length, breaks = 100)

#Let's plot week of the year
hist(data$week_of_year, breaks = length(unique(data$week_of_year)))

#Create binary class
data = subset(data, data$join_date < as.Date("2015/12/13") - (365 + 31)) # only keep people who had ???????????????????????? time to age
data$early_quitter = as.factor(ifelse( is.na(data$quit_date) | as.numeric(data$quit_date - data$join_date) > 396, 0, 1))

tree = rpart(early_quitter ~ .,data[, c("company_id", "dept", "seniority", "early_quitter", "salary")], #put salary
             control = rpart.control(minbucket = 30, maxdepth = 3 , cp = 0.000001),
             parms = list(prior = c(0.5,0.5))
)
tree #we are not too interested in predictive powe????, we are mainly using thtreetr as a descriptive stat tool.

data$salary_percentile = cut(data$salary, breaks = quantile(data$salary, probs = seq(0, 1, 0.02)),include.lowest = TRUE, labels = 1:50)
data_proportion_by_percentile = data %>%
  group_by(salary_percentile) %>%
  summarize(proportion_early_quitters = length(early_quitter[early_quitter==1])/length(early_quitter))
qplot(salary_percentile, proportion_early_quitters, data=data_proportion_by_percentile, geom="line", group =1) + scale_x_discrete(breaks = seq(1,50, by=2))
