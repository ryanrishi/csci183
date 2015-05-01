# impute N/A with mean

age_mean <- mean(train$Age, na.rm = TRUE)

for (i in 1:nrow(train)) {
  if (is.na(train$Age[i])) {
    train$Age[i] <- age_mean
  }  
}

# rpart decision tree
fit <- rpart(survived ~ Age, data = train)
