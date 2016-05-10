#exploreData

#Numerodelamismaraza que compiten en el mercado

tablebreed<-table(train$Breed)
bredfrequency <- as.data.frame(tablebreed)
bredfrequency$Breed<-bredfrequency$Var1
bredfrequency$Var1<-NULL

#joins de new feature competence.
train<-merge(x = train, y = bredfrequency, by = "Breed", all.x = T)
test<-merge(x = test, y = bredfrequency, by = "Breed", all.x = T)
test$Freq[is.na(test$Freq)]<-0

library(stringi)

#create second y third breed
train$Breed1<-sapply(strsplit(as.character(train$Breed), split="/"), "[", 1) 
train$Breed1[is.na(train$Breed1)]<-"NotCombined" #if does have second breed
test$Breed1<-sapply(strsplit(as.character(test$Breed), split="/"), "[", 1)
test$Breed1[is.na(test$Breed1)]<-"NotCombined" #if does have second breed

#create new feature Breed1 in dt.train Y dt.test
dt.train$Breed1<-train$Breed1
dt.test$Breed1<-test$Breed1

train$Breed2<-sapply(strsplit(as.character(train$Breed), split="/"), "[", 2) 
train$Breed2[is.na(train$Breed2)]<-"NotCombined" #if does have second breed
test$Breed2<-sapply(strsplit(as.character(test$Breed), split="/"), "[", 2)
test$Breed2[is.na(test$Breed2)]<-"NotCombined" #if does have second breed


train$Breed3<-sapply(strsplit(as.character(train$Breed), split="/"), "[", 3) 
train$Breed3[is.na(train$Breed3)]<-"NotCombined3" #if does have second breed

test$Breed3<-sapply(strsplit(as.character(test$Breed), split="/"), "[", 3) 
test$Breed3[is.na(test$Breed3)]<-"NotCombined3" #if does have second breed
