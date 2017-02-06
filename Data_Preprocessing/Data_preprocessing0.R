Titanic=data.frame(Titanic)
attach(Titanic)
head(Titanic)
table(Titanic$Sex)
table(Titanic$Sex,Titanic$Age)
table(Titanic$Age,Titanic$Survived)
table(Titanic$Age,Titanic$Class)

