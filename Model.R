#Model
#
# xgboost-specific design matrices
library(Matrix)
library(caret)

dt.train$Size<- factor(train$Size)
dt.test$Size<- factor(test$Size)

set.seed(12345)
train.y <- as.numeric(as.factor(train$OutcomeType)) - 1

feature.formula<- formula(OutcomeType~AnimalType+named+Breed+month+age+sex+status+color+Size)

trainS <- sparse.model.matrix(feature.formula , data = dt.train)
dtrain <- xgb.DMatrix(data=trainS, label=train.y)



#Cross- Validatewatchlist

watchlist <- list(train=dtrain)

param <- list(  objective       	= 'multi:softprob',
                booster         	= "gbtree",
                eval_metric     	= "mlogloss",
                eta             	= 0.02,
                max_depth       	= 5,
                subsample       	= 0.8,
                colsample_bytree	= 0.75
)

###cross validation para estimar numero de Nrounds
#xgb.cv(data=dtrain, 
#       label=train.y, 
#       nfold=5, 
#       nround=500, 
#       objective='multi:softprob',
#       num_class=5, 
#       eval_metric='mlogloss')

clf <- xgb.train(   params          	= param,
                    data            	= dtrain,
                    nrounds         	= 400,
                    verbose         	= 1,
                    watchlist       	= watchlist,
                    maximize        	= FALSE,
                    num_class=5
)                    


dt.test$OutcomeType<-1

testS<-sparse.model.matrix(feature.formula, data= dt.test)

# make predictions
preds <- predict(clf, testS)

# reshape predictions
XGBpredsDF <- data.frame(matrix(preds, ncol = 5, byrow=TRUE))

colnames(XGBpredsDF) <- c('Adoption', 'Died', 'Euthanasia', 'Return_to_owner', 'Transfer')


#ID
XGBpredsDF["ID"]<-test["ID"]

# submission

write.csv(XGBpredsDF, file="XGboost1andSize400SSinTimeround.csv", row.names = F)


#Randomforest Model

rf.model<-randomForest(OutcomeType~AnimalType+Breed+named+year+age+sex+status+color+Size, data = dt.train, mtry=5, ntrees= 900)

rf.preds <- data.frame(predict(rf.model, dt.test, type='vote'))


colnames(Rf.preds.dt) <- c('Adoption', 'Died', 'Euthanasia', 'Return_to_owner', 'Transfer')


XGBpredsDF["ID"]<-NULL
Ensemblepreds<-0.5*(rf.preds+XGBpreds1)
Ensemblepreds["ID"]<-test["ID"]

write.csv(Ensemblepreds, file="Ensemble.cvs", row.names = F)






