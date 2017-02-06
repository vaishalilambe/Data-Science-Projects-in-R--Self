z <- c(1,4,5,6,1,2,4,3,8,7)
z[duplicated(z)] ### Finding duplicates in a vector
z[!duplicated(z)] ### Removing duplicates in a vector
d1 <- data.frame(id=c(1,2,3,1,2),x=c(6,7,8,6,7))
d1
d1[duplicated(d1),] ### Finding duplicates in a data frame
d1[!duplicated(d1), ] ### Removing duplicates in a data frame


