setwd("~/git/csci183/kaggle/digit-recognition/")
train <- read.csv("./train.csv", header = T)
test <- read.csv("./test.csv", header = T)

library('randomForest')

labels <- as.factor(train[,1])
features <- train[,-1]

xDim <- 28
yDim <- 28

# overlapping images
# DESIGN: find all the 0s in dataset, then compute mean of each pixel. Then all the 1s...
meanDigits <- aggregate(train, by=train["label"], FUN = mean)
# TODO why does this result in two "label" columns ?
meanDigits[,1] <- NULL    # get rid of one of the label columns
# only sometimes need this?
meanDigits$expected <- NULL

train$label <- NULL
#rf.bench <- randomForest(features[1:1000,], labels[1:1000], xtest = test[1:1000,], ntree = 100)
rf.bench <- randomForest(features, labels, xtest = test, ntree = 1000, show.trace = TRUE)
rf_submission <- data.frame(ImageId=1:nrow(test), Label=levels(labels)[rf.bench$test$predicted])
