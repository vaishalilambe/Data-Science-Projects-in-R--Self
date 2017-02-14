#library("RODBC")
install.packages("RCurl")
install.packages("bitops")
install.packages("rjson")
library("RCurl")
library("rjson")
#library(rClr)
#library("RSQLServer")
#library("checkpoint")


Titanic_DS <- read.csv("C:\\Users\\Admin\\Documents\\DataScience\\test.csv")
Titanic_DS$PassengerId <- NULL
Titanic_DS$Name <- NULL
Titanic_DS$Cabin <- NULL
Titanic_DS$Ticket <- NULL
i <- 1

#Titanic_DS <- Titanic_DS[1:75, ]

mm <- matrix(0, ncol = 9)
mm <- data.frame(mm)
mm <-  mm[-1,]

while( i <= nrow(Titanic_DS) ){
  
  Titanic_DS <- na.omit(Titanic_DS)
  
  # Accept SSL certificates issued by public Certificate Authorities
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  
  h = basicTextGatherer()
  hdr = basicHeaderGatherer()
  
  Titanic_DS_Final <- Titanic_DS[i,]
  
  req = list(
    
    Inputs = list(
      
      "input1" = list(
        "ColumnNames" = list("PassengerClass", "Gender", "Age", "SiblingSpouse", "ParentChild", "FarePrice", "PortEmbarkation"),
        "Values" =  list( list(Titanic_DS_Final$Pclass, Titanic_DS_Final$Sex, Titanic_DS_Final$Age, Titanic_DS_Final$SibSp, Titanic_DS_Final$Parch, Titanic_DS_Final$Fare, Titanic_DS_Final$Embarked) )
      )                ),
    GlobalParameters = setNames(fromJSON('{}'), character(0))
  )

  body = enc2utf8(toJSON(req))
  api_key = "H5mL9kIQ7Q4WcPcXp8swxlNRJFXcbBlp9WpvebIk1CEMZZXa6gsCrlX8nNofwRm3Ch4OKRwKplwTyCJrrZ2SEw==" # Replace this with the API key for the web service
  authz_hdr = paste('Bearer', api_key, sep=' ')
  
  h$reset()
  curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/8fb252a917064ce0965cd059eaa5af55/services/321aa10dcfa2488dab853eaf2d2a13b2/execute?api-version=2.0&details=true",
              httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
              postfields=body,
              writefunction = h$update,
              headerfunction = hdr$update,
              verbose = TRUE
  )
  
  headers = hdr$value()
  httpStatus = headers["status"]
  if (httpStatus >= 400)
  {
    print(paste("The request failed with status code:", httpStatus, sep=" "))
    
    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
    print(headers)
  }
  
  print("Result:")
  result = h$value()
  finalResult <- fromJSON(result)
  colNames <- finalResult$Results$output1$value$ColumnNames
  c <- unlist(finalResult$Results$output1$value$Values)
  
  mm[nrow(mm)+1,]  <- rbind(c[1], c[2], c[3], c[4], c[5], c[6], c[7], c[8], c[9])
  i <- i + 1
}


mm$ScoredProbabilities <- as.numeric(format(round(as.numeric(mm$X9) * 100, 2), nsmall = 2))
mm$ScoredProbabilitiess <- paste(as.character(mm$ScoredProbabilities), "%")

mm$X9 <- NULL

library(data.table)
setnames(mm, old = c('X1','X2','X3','X4','X5','X6','X7','X8'), new = c(colNames[1], colNames[2], colNames[3], colNames[4], colNames[5], colNames[6], colNames[7], colNames[8]))
write.csv(s, "C:\\Users\\Admin\\Documents\\DataScience\\QQQ", row.names=TRUE)

pp <- read.csv("C:\\Users\\Admin\\Documents\\DataScience\\QQQ.csv")
pp



