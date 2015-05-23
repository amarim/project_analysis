run_analysis <- function(){ 

## Download and unzip file 
if(!file.exists("UCI HAR Dataset")){
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, destfile = paste(getwd(),"getdata-projectfiles-UCI HAR Dataset.zip",sep="/"))
  unzip(paste(getwd(),"getdata-projectfiles-UCI HAR Dataset.zip",sep="/"), exdir = getwd())  
}

directory <- c("train","test")

## read feature and activity file
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = "character")
features <- read.table("UCI HAR Dataset/features.txt", colClasses = "character")

## Loop to each directory (train and test)
for(f in 1:length(directory)){
  
  if(directory[f] == "train"){
    y_t <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses = "character", col.names = c("activity"))
    subject_t <- read.table("UCI HAR Dataset/train/subject_train.txt", colClasses = "character", col.names = c("subject"))
    X_t <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
  }
  else{
    y_t <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses = "character", col.names = c("activity"))
    subject_t <- read.table("UCI HAR Dataset/test/subject_test.txt", colClasses = "character", col.names = c("subject"))
    X_t <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
  }
  
  ## select fields like (mean) or (Standard deviaton)
  names <- names(X_t) ## Take field names
  colvalida <- grep("mean|std", names) ## select mean e std with using regular expression
  X_t <- X_t[,colvalida] ## Builds new data frame just with select fields
  
  ## Join the data.frame read
  train_test <- data.frame(subject_t, y_t, X_t)
  
  ## Change the activity number for activity name
  train_test[,"activity"] <- activity_labels[train_test[,"activity"],2]
  
  ## Builds new data frame with means each variable, for each activity, for each subject
  names <- names(train_test)
  
  finalset <- NULL
  labelset <- c("subject", "activity")
  for(i in 3:length(names)){
    setmean <- tapply(train_test[,names[i]], train_test[,1:2], mean)
    subjects <- as.numeric(row.names(setmean))
    activity <- colnames(setmean)
    labelset <- c(labelset, paste("MEAN", names[i], sep="_"))
    endset <- NULL
    
    for(j in 1:length(subjects)){
      subject <- rep(subjects[j], 6)
      feature <- as.numeric(setmean[j,])
      
      if(i == 3)
        endset <- rbind(endset, data.frame(subject = subject, activity = activity, feature = feature)) 
      else
        endset <- rbind(endset, data.frame(feature = feature))
    }
    
    if(i == 3)
      finalset <- endset
    else
      finalset <- cbind(finalset, endset)
    
  }
  
  ## change labels of finalset 
  names(finalset) <- labelset
  
  if(f == 1)
    train_test_final <- finalset
  else
    train_test_final <- rbind(train_test_final, finalset)
  
}

train_test_final <- train_test_final[order(train_test_final[,"subject"], train_test_final[,"activity"]),]

}
