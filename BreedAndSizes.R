#size  in dogs



#razas_de_perro<-data.frame(unique(as.character(dt.train$Breed1[dt.train$AnimalType=="Dog"])))

#write.csv(razas_de_perro, file="Perros.csv")

#read dogs size
dog_sizes<-read.csv("dog_breeds.csv")
dog_sizes<-dog_sizes[,2:3]
names(dog_sizes)<- c("Breed1","Size")


#cats size "cats_size"

train<-merge(x = train, y = dog_sizes, by="Breed1", all.x = T, all.y = F)
test<-merge(x = test, y = dog_sizes, by="Breed1", all.x = T, all.y = F)

#CreateLevel catz size

levels(train$Size)<- c(levels(train$Size), "cats_size")
levels(test$Size)<- c(levels(test$Size), "cats_size")

summary(train$Size)


train$Size[train$AnimalType=="Cat"]<-"cats_size"
#check cats
summary(dt.test$Size)
test$Size[test$AnimalType=="Cat"]<-"cats_size"
test$Size[is.na(test$Size)]<- c(2,2,1,1,1,1,1,1,2,3,3,2,3,3,1,2,2,3,3,3,3,2,2,1,1)

dt.train$Size<-train$Size
dt.test$Size<-test$Size