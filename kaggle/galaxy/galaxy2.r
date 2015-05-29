setwd('~/git/csci183/assignments/image_classification_competition/')

install.packages('ripa')
install.packages('jpeg')

source("http://bioconductor.org/biocLite.R")
biocLite("EBImage", ask = FALSE)

library('ripa')
library('jpeg')
library('EBImage')

# store all filenames in array
# DEBUG only taking anything with *007.jpg extension, just for my computer's sake
#all_files <- list.files('images_training_rev1/', pattern = "007\\.jpg$") # about 69 files
all_files <- list.files('images_training_rev1/') # everything

# get list of all ids
all_ids <- array()
for (i in 1:length(all_files)) {
  id <- strsplit(all_files[i], split='[.]')[[1]][1]
  all_ids[i] <- id
}

#all_ids <- sample_submission$GalaxyID

# setup submission data frame
submission <- data.frame(as.character(all_ids))
names(submission)[names(submission)=="as.character.all_ids."] <- "GalaxyID"
submission$Prob_Smooth <- 0.0

# ?
# tmp <- subset(all_files, id %in% galaxy_train$GalaxyID)

#df <- data.frame(GalaxyID = all_ids)
#df$Prob_Smooth <- 0
#df$variance <- 0
#df$stdDev <- 0

# read every image and store in 50x50 greyscale
prob <- array()
for (i in 1:length(all_files)) {
  file <- all_files[i]
  img <- readJPEG(paste('images_training_rev1/', file, sep = ''))
  reduced <- rgb2grey(resize(img, 50, 50))
  id <- strsplit(file, split='[.]')[[1]][1] # is there a better way to do this?
  print(id)
  # want something like ((id, matrix), (id, matrix), (id, matrix)) etc.
  
  # I could do something like reduced[reduced < mean(reduced)] <- 0 and reduced[reduced > mean(reduced)] <- 1 to get high contrast
  # TODO make it so id_* has data, mean, variance, smooth (BOOL), etc.
  submission$Prob_Smooth[i] <- roundProb(reduced)
  #prob[i] <- roundProb(reduced)
}

# change NAs into mean
# TODO why are there NAs?
submission$Prob_Smooth[is.na(submission$Prob_Smooth)] <- mean(submission$Prob_Smooth)
for (i in 1:nrow(submission)) {
  if (is.na(submission$Prob_Smooth[i])) {
    submission$Prob_Smooth[i] <- mean(submission$Prob_Smooth)
  }
}
submission$Prob_Smooth

# sample data
#sample1 <- sample(all_files, length(all_files) /  10)

roundProb <- function(myMatrix) {
  # myMatrix is n*n matrix
  # returns probability that myMatrix contains a round-ish element
  # DESIGN: find brightest point (max), then analyze variance of radius from that point
  center <- findMaxLocation(myMatrix)
  # check in x-y directions (a four-pointed star may fool this function)
  # something to do with std deviation?
  xMax <- center[1]
  yMax <- center[2]
  xSD <- sd(myMatrix[xMax,])
  xMean <- mean(myMatrix[xMax,])
  xMinSD <- min(which(myMatrix[xMax,] > (xMean - xSD)))
  xRadius <- (xSD*nrow(myMatrix))
  
  # xMaxSD <- max(which(myMatrix[xMax,] > (xMean - 4*xSD)))
  
  ySD <- sd(myMatrix[,yMax])
  yMean <- mean(myMatrix[,yMax])
  yMinSD <- min(which(myMatrix[,yMax] > (yMean - ySD)))
  yRadius <- (ySD*nrow(myMatrix))
  return (abs(abs(xRadius - yRadius)) / nrow(myMatrix))
}

findMaxLocation <- function(myMatrix) {
  max <- which.max(myMatrix)
  xMax <- max %% ncol(myMatrix)
  yMax <- (max - xMax) / ncol(myMatrix) + 1
  return(c(xMax, yMax))
}

squareMatrixToList <- function(myMatrix) {
  # TODO parameter verifiction
  myList <- list()
  for (i in dim(myMatrix)) {
    for (j in dim(myMatrix)) {
      myList <- c(myList, myMatrix[i, j]) # did I math right?
    }
  } 
}

listToSquareMatrix <- function(myList, dim = 3) {
  # TODO myList parameter checking for myList
  if (dim < 0) {
    print("Dimension must be positive.")
    return(NA)
  }
  if (length(myList) != dim*dim ) {
    print("Number of elements in list must be dim*dim")
    return(NA)
  }
  m <- matrix(nrow=dim, ncol=dim)
  for (i in seq(1:dim)) {
    for (j in seq(1:dim)) {
      m[j, i] <- myList[i + (j-1)*dim]  # did I math right?
    }
  }
  return(m)
}

# something to check out:
# persp(all_img$id_214007)

# this should be done using linear regression and RMSE

# FEATURES TO TEST
# circle w/ 95% bright -> check adjacent pixels for white


galaxy_train <- read.csv("galaxy_train.csv")

write.csv(submission, file = "submission.csv", row.names=FALSE)
