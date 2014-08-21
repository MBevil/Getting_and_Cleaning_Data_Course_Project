print("Start run_analysis...")

## constants
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "./sourceData.zip"
data_path <- "UCI HAR Dataset"

##Install required packages  
if(!is.element("plyr", installed.packages()[,1])){
  print("Installing packages")
  install.packages("plyr")
}

library(plyr)

## download the data file if not already done
if (!file.exists(destFile)){

  print(paste("Downloading data file from: ", fileUrl))
  download.file(fileUrl, destFile, method="curl", quiet=TRUE, mode="wb")
  print(paste("Downloading data file complete to: ", destFile))
  dateDownloaded <- date()
  
}

##create a vector of the feature names
print("Reading feature names...")
cols <- read.table(unz(destFile, paste(data_path,"features.txt",sep="/")))

## Read in in the data sets
print("Reading training data set...")
subjects1 <- read.table(unz(destFile, paste(data_path,"train/subject_train.txt",sep="/")), sep="", col.names="subject") 
activities1 <- read.table(unz(destFile, paste(data_path,"train/y_train.txt",sep="/")), sep="", col.names="activity")
data1 <-    read.table(unz(destFile, paste(data_path,"train/X_train.txt",sep="/")), sep="", col.names=cols$V2) 

trainingData <- cbind(subjects1, activities1, data1)

print("Reading test data set...")
subjects2 <- read.table(unz(destFile, paste(data_path,"test/subject_test.txt",sep="/")), sep="", col.names="subject")
activities2 <- read.table(unz(destFile, paste(data_path,"test/y_test.txt",sep="/")), sep="", col.names="activity")
data2 <- read.table(unz(destFile, paste(data_path,"test/X_test.txt",sep="/")), sep="", , col.names=cols$V2)

testData <- cbind(subjects2, activities2, data2)

## Merge the train and test data sets
print("Merging the training and test data sets...")
data <- rbind(trainingData, testData)  ## 10299 observations of 563 variables

## arrange the data by id
data <- arrange(data, subject)

## update the activities to use the activity names
activity_labels <- read.table(unz(destFile, paste(data_path,"activity_labels.txt",sep="/"))) 


## update activities with the labels
data$activity <- factor(data$activity, levels=activity_labels$V1, labels=activity_labels$V2)

## subset data by extracting columns with mean and standard deviation information
print("Subsetting Mean and Std Dev columns...")
subsetData <- data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]

## Calculate the mean of the replicates for each variable by subject and activity
print("Getting mean of replicates...")
newData <- ddply(subsetData, .(subject, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })

## Adds "_mean" to colnames
colnames(newData)[-c(1:2)] <- paste(colnames(newData)[-c(1:2)], "_mean", sep="")

# Save tidy dataset
print("Saving new dataset...")
write.table(newData,"tidy_data.txt", sep ="\t", row.names = FALSE)

print("End run_analysis...")

