setwd('~/git/csci183/assignments/image_classification_competition/')

install.packages('ripa')
install.packages('jpeg')

source("http://bioconductor.org/biocLite.R")
biocLite("EBImage", ask = FALSE)

library('ripa')
library('jpeg')
library('EBImage')

# store all files in array
# DEBUG only taking anything with *007.jpg extension, just for my computer's sake
all_files <- list.files('images_training_rev1/', pattern = "007\\.jpg$") # about 69 files
all_img <- list()
for (file in all_files) {
  img <- readJPEG(paste('images_training_rev1/', file, sep = ''))
  reduced <- rgb2grey(resize(img, 50, 50))
  id <- strsplit(file, split='[.]')[[1]][1] # is there a better way to do this?
  # want something like ((id, matrix), (id, matrix), (id, matrix)) etc.
  #df <- data.frame()
  #df$data <- reduced
  #df$mean <- mean(reduced)
  #df$variance <- 0      # how to I compute variance for imagematrix ?
  #df$std
  #df$smooth <- FALSE
  all_img[[paste('id_', id, sep='')]] <- reduced
  # I could do something like reduced[reduced < mean(reduced)] <- 0 and reduced[reduced > mean(reduced)] <- 1 to get high contrast
  # TODO make it so id_* has data, mean, variance, smooth (BOOL), etc.
}

# sample data
sample1 <- sample(all_files, length(all_files) /  10)

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


