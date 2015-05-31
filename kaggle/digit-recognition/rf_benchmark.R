# Creates a simple random forest benchmark
# https://www.kaggle.com/users/993/ben-hamner/digit-recognizer/random-forest-benchmark

# This got us around 93%. The confusion matrix for the training/testing set looked like this:
#      0    1    2    3    4    5    6    7    8    9  class.error
# 0 4080    0    2    2    5    5   15    0   20    3  0.01258470
# 1    0 4613   20   15    8    4    5    8    8    3  0.01515798
# 2   14    8 4042   22   18    1   12   34   22    4  0.03231985
# 3    6    4   50 4146    1   45    8   26   40   25  0.04711561
# 4    6    6    4    0 3959    0   18    6    8   65  0.02775049
# 5   10    5    4   45    6 3648   29    4   25   19  0.03873518
# 6   16    4    2    0    9   19 4072    0   15    0  0.01571187
# 7    4   15   45    6   16    0    0 4245    7   63  0.03544649
# 8    9   16   15   34   13   25   14    3 3890   44  0.04257937
# 9   20    9    7   54   51   11    3   33   26 3974  0.05109838

# From the above, you can see that 4 and 9 are often confused, and 5 and 3 are often confused.
# I could tweak the model, but this may start to overfit to the training set.

library(randomForest)
library(readr)

set.seed(0)

numTrain <- 10000
numTrees <- 25

train <- read_csv("train.csv")
test <- read_csv("test.csv")

rows <- sample(1:nrow(train), numTrain)
labels <- as.factor(train[rows,1])
train <- train[rows,-1]

rf <- randomForest(train, labels, xtest=test, ntree=numTrees)
predictions <- data.frame(ImageId=1:nrow(test), Label=levels(labels)[rf$test$predicted])
head(predictions)

write_csv(predictions, "rf_benchmark.csv") 