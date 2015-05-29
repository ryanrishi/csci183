library(rpart)
library(caret)


# impute N/A with mean
train$Age <- mean(train$Age, na.rm = TRUE)

library(rpart)


# rpart decision tree
fit <- rpart(Survived ~ Age + Sex + Pclass + Fare + Cabin + Embarked, method="class", data = train)
