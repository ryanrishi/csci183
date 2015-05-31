# images are 28x28
# image data is between 0...255

setwd("~/git/csci183/kaggle/digit-recognition/")
train <- read.csv("./train.csv")
test <- read.csv("./test.csv")

labels <- train[,1]
features <- train[,-1]

xDim <- 28
yDim <- 28

# things to try
# linear model
# subsampling
# overlapping images to get average (?)

# linear model

# overlapping images
# DESIGN: find all the 0s in dataset, then compute mean of each pixel. Then all the 1s...
meanDigits <- aggregate(train, by=train["label"], FUN = mean)
# TODO why does this result in two "label" columns ?
meanDigits[,1] <- NULL    # get rid of one of the label columns
# only sometimes need this?
meanDigits$expected <- NULL

# took this function from Ben Hamner's "Example Handwritten Digits" script
# found at https://www.kaggle.com/liweihu/digit-recognizer/example-handwritten-digits
rowToMatrix <- function(row) {
  intensity <- as.numeric(row)/max(as.numeric(row))
  return(t(matrix(intensity, 28, 28)))  # this is sideways?
}

# just an example
zero <- rowToMatrix(meanDigits[1, -1])
image(zero)

# the way I'm thinking about this is a 3D representation of mean (and std deviations?) of each digit 0:9, like with stock bars
# then, I'd like to iterate through all the rows of the train set and see which digit the row is closest to
# iterate through training set and classify each row into digit from 0:9

subset <- train[3600:4000,]

### TESTING
subset <- test
### END TESTING

subset$expected <- NULL 
submission_labels <- vector()

for (i in 1:nrow(subset)) {
  print (i/nrow(subset)) # progress
  row <- subset[i,] # for training, use subset[i, -1]
  row$expected <- NULL
  #img <- rowToMatrix(row)
  #image(img)
  #print(subset[i, 'label'])
  # do I want to plot these?
  submission_labels[i] <- digitClosestTo(row)
  print (submission_labels[i])
  #subset[i, 'expected'] <- digitClosestTo(row)
  #print(subset[i, 'expected'])
  #print('\n')
}

# how did we do?
table(subset$label == subset$expected)

digitClosestTo <- function(img) {
  # assuming meanDigits is already calculated, and now you're iterating through dataset
  #weakest <- vector()
  #weakest[1] <- sum(abs(meanDigits[1,] - img))
  # there must be an R function to compute RMS?
  rms <- vector()
  rms[1] <- sum((meanDigits[1,-1] - img)^2)  # [1,] for train, [1, -1] for test
  
  for (i in 2:10) {
    # note that meanDigits[4] actually refers to the 3 row, etc.
    #weakest[i] <- sum(abs(meanDigits[i,] - img))
    rms[i] <- sum(abs(meanDigits[i,-1] - img)^2) # [i,] for train; [i, -1] for test
  }
  #print (weakest)
  #print (rms)
  return(which.min(rms) - 1)
}

# things NOT to try
# random forest b/c it 

# submission is [8 2 0 5 1 2 7 ... 2  6 2 0] transpose (28000 digits)
submission <- data.frame(ImageID = 1:28000, Label = submission_labels)
submission$ImageID <- 0

write.csv(submission, "submission.csv", row.names = F )
