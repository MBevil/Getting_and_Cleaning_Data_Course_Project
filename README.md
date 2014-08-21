Getting and Cleaning Data Course Project
----------------------------------------

**Description:** Course Project for the getting and Cleaning Data Class in the Johns Hopkins Data Science Curriculum. The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

**Author:** Mike Bevil

**Requirements:** 

Create one R script called run_analysis.R that does the following: 

  1. Merges the training and the test sets to create one dataset. 
  2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
  3.  Uses descriptive activity names to name the activities in the dataset 
  4.  Appropriately labels the dataset with descriptive variable names. 
  5. Creates a second, independent tidy dataset with the average of each variable for each activity and each subject.

**Assumptions:**

  * Internet connectivity to download source files

**R Package Dependancies:**
  
  * plyr v1.8.1 or later


**Basic Code Walkthrough for run_analysis.R**

  **Step 1:** Install and load plyr package:
  
    if(!is.element("plyr", installed.packages()[,1])){
      print("Installing packages")
      install.packages("plyr")
    }
  

  **Step 2:** Download source data files (activity labels, features, test, training) if not present:
  
    if (!file.exists(destFile)){
    
      print(paste("Downloading data file from: ", fileUrl))
      download.file(fileUrl, destFile, method="curl", quiet=TRUE, mode="wb")
      
      print(paste("Downloading data file complete to: ", destFile))
      dateDownloaded <- date()
    }
    
  **Step 3:** Create a vector of the feature names:
  
    print("Reading feature names...")
    cols <- read.table(unz(destFile, paste(data_path,"features.txt",sep="/")))
    
    
  **Step 4:** Read in the training data set adding the subject and activity columns:
  
    print("Reading training data set...")
    subjects1 <- read.table(unz(destFile, paste(data_path,"train/subject_train.txt",sep="/")), sep="", col.names="subject") 
    activities1 <- read.table(unz(destFile, paste(data_path,"train/y_train.txt",sep="/")), sep="", col.names="activity")
    data1 <-    read.table(unz(destFile, paste(data_path,"train/X_train.txt",sep="/")), sep="", col.names=cols$V2) 

    trainingData <- cbind(subjects1, activities1, data1)
    
    
  **Step 5:** Read in the test data set adding the subject and activity columns:
  
    print("Reading test data set...")
    subjects2 <- read.table(unz(destFile, paste(data_path,"test/subject_test.txt",sep="/")), sep="", col.names="subject")
    activities2 <- read.table(unz(destFile, paste(data_path,"test/y_test.txt",sep="/")), sep="", col.names="activity")
    data2 <- read.table(unz(destFile, paste(data_path,"test/X_test.txt",sep="/")), sep="", , col.names=cols$V2)

    testData <- cbind(subjects2, activities2, data2)
    
    
  **Step 6:** Merge the test and training data into a single dataset:
  
    print("Merging the train and test data sets...")
    data <- rbind(trainingData, testData)  ## 10299 observations of 563 variables
    
    
  7. Update the activities to utilize the names.
  8. Subset the merged data to extract columns with mean or standard deviation data.
  9. Calculate the mean of the replicates for each variable by subject and activity.
  10. Update the column names to reflect the transformation (mean).
  11. Write out the "tidy" dataset to the "tidy_data.txt" file.




