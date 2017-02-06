### Combining two data frames (column wise)
set.seed(1)
m <- cbind(1, 1:7) 
m
m <- cbind(m, 8:14)[, c(1, 2, 3)]
m
d1 <- data.frame(x=1:5, y1=rnorm(5))
d2 <- data.frame(x=2:6, y2=rnorm(5))
d1
d2
cbind(d1,d2)
### Combining two data frames (row wise) 
set.seed(1)
m <- rbind(1, 1:7) 
m
m <- rbind(m, 8:14)[c(1, 2, 3), ]
m
d3 <- data.frame(x=1:5, y1=rnorm(5))
d4 <- data.frame(x=6:10, y1=rnorm(5))
d3
d4
rbind(d3,d4)
