#Dogs and Cats
#clean
setwd("~/Dropbox/rinstance/ShelterCatsAndDogs")


library(randomForest)
library(xgboost)
train<-read.csv("train.csv", stringsAsFactors = F)
test<-read.csv("test.csv", stringsAsFactors = F)

#source clean from fhlgood
source("https://raw.githubusercontent.com/fhlgood/K_sa/master/clean_original.R")












