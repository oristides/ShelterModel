dt.train <- clean(train)
dt.test <- clean(test)

#i dont kno Datatable too much

dt.train<-data.frame(dt.train)
dt.test<-data.frame(dt.test)



#NAS introduce meddian as principal
lm.model<-lm(age~., data= dt.train)
lm.model2sinOutcomeType<-lm(age~ Breed+AnimalType+named+year+month+day+weekday+time+status+color+Breed, data= dt.train)
preds.ageTrain<-predict(lm.model, dt.train[is.na(dt.train$age),])
#imputarte ages 
dt.train$age[is.na(dt.train$age)]<-preds.ageTrain

#same thing para test

preds.ageTest<-predict(lm.model2sinOutcomeType, dt.test[is.na(dt.test$age),])
dt.test$age[is.na(dt.test$age)]<-preds.ageTest
#dt.train$age[which(is.na(dt.train$age))]<- 300
#dt.test$age[which(is.na(dt.test$age))]<- 300