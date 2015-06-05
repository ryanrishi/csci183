install.packages('rpart')
install.packages('caret')
install.packages('glm')
install.packages('rattle')
install.packages('doParallel')

library(rpart)
library(caret)
library(rattle)
library(doParallel)

train <- read.csv('datasets/train.csv', header = T)
test <- read.csv('datasets/test.csv', header = T)

# impute N/A with mean
summary(train)
train[is.na(train$Age),]$Age <- mean(train$Age, na.rm = T)
summary(test)
test[is.na(test$Age),]$Age <- mean(test$Age, na.rm = T)
test[is.na(test$Fare),]$Fare <- mean(test$Fare, na.rm = T)

# rpart decision tree
fit <- rpart(Survived ~ Age + Sex + Pclass + Fare + Embarked, method="class", data = train)
plot(fit)
plotcp(fit)

# fit model
fitControl <- trainControl(method = "repeatedcv", number = 10, repeats=1, verbose=TRUE)
gbmGrid <- expand.grid(interaction.depth = 1:4, n.trees = (1:50)*20, shrinkage = c(.1, .05, .01, .005, .001), n.minobsinnode = 1)
set.seed(825)
gbmFit <- train(Survived ~ Age + Sex + Pclass + Fare + Embarked, 
                data=train, method = "gbm", trControl = fitControl, verbose = F, tuneGrid = gbmGrid)

trellis.par.set(caretTheme())
plot(gbmFit)
summary(gbmFit)

prediction <- round(predict(gbmFit, test))
submission <- data.frame(PassengerID = test$PassengerId, Survived = prediction)

write.csv(submission, file='submission.csv', row.names = F)
