x <- data.frame(k1 = c(1,NA,3,4,5), k2 = c(1,NA,NA,4,5), k3 = 8:12)
y <- data.frame(k1 = c(NA,2,NA,4,5), k2 = c(NA,NA,3,4,5), k3 = 14:18)
x
y
merge(x,y,all=FALSE) ### Inner join
merge(x,y,all.x=TRUE) ### Left join
merge(x,y,all.y=TRUE) ### Right join
merge(x,y,all=TRUE) ### Outer join
