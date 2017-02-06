ages=c(20,22,25,27,21,23,37,31,61,45,41,32)
breaks=c(0,18,25,35,60,100)
labels=c('Tenager','Youth','YoungAdult','MiddleAged','Senior')
cat_ages=cut(ages,breaks,labels)
cat_ages
ages
table(cat_ages)





