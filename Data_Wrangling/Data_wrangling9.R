x=c(1,2,3,5,6,7,3)
y=c('a','b','c','a','b','c','a')
z=table(x,y)
z
dim(z)
dimnames(z)
dimnames(z)$x ### Renaming rows
dimnames(z)$y ### Renaming columns
dimnames(z)$x <- c('L1','L2','L3','L4','L5','L6')
dimnames(z)$y <- c('aa','bb','cc')
z
