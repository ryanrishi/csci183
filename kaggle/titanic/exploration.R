# impute N/A with mean

rm(survived)

age_mean <- mean(test$Age, na.rm = TRUE)

for (i in 1:nrow(test)) {
  if (is.na(test$Age[i])) {
    test$Age[i] <- age_mean
  }  
}

survived <- test$Sex == 'female' & (test$Age < 18 | test$Age > 65)
survived <- survived * 1


table(survived == test$Survived)

df = data.frame(PassengerId = test$PassengerId, Survived = survived)
write.csv(df, file = "females_and_children.csv", row.names=FALSE)
