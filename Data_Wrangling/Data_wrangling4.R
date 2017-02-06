### Mapping missing values of data frame with values of another data frame
### having same index

x <- data.frame(x1=c(NaN,2.5,NaN,3.5,4.5,NaN))
y <- data.frame(y1=c(1,2,3,4,5,6))
x
y
### Replacing missing values of x1 column with y1 column

for (i in 1:nrow(x)) {
  if (is.na(x[i,1])){
    x[i,1] <- y[i,1] 
}}
x




