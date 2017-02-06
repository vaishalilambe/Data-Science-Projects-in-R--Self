### Mapping values
### Defining some dictionary
dict<-data.frame(animal=c('pig','cow','salmon'),meat=c('bacon','beef','Nova lox'))
dict
### Creating a new data frame
data<-data.frame(meat=c('bacon', 'beef', 'bacon', 'Nova lox', 'bacon'))
data
### Matching meat with animal
data$animal <- dict[match(data$meat, key$meat), 'animal']
data



