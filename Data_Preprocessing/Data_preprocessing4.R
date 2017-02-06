### Binning (equal length bins)
x=c(1,2,3,4,2,4,7,8,12,5,6,8)
y=cut(x,4)
y
k=split(x,y)
k
y=factor(y)
aggregate(x,by=list(y),FUN='mean')
aggregate(x,by=list(y),FUN='sd')
### Binning (equal number of datapoints in each interval)
breaks=quantile(x,probs=c(0,.25,.5,.75,1))
breaks
z=cut(x,breaks,include.lowest=TRUE)
z


