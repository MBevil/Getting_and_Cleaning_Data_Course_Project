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


**Basic Code Walkthrough for run_analysis.R**

  1. Install and load plyr package.
  2. Download source data files (activity labels, features, test, training) if not present.
  3. Create a vector of the feature names.
  4. Read in the training data set adding the subject and activity columns.
  5. Read in the test data set adding the subject and activity columns.
  6. Merge the test and training data into a single dataset.
  7. Update the activities to utilize the names.
  8. Subset the merged data to extract columns with mean or standard deviation data.
  9. Calculate the mean of the replicates for each variable by subject and activity.
  10. Update the column names to reflect the transformation (mean).
  11. Write out the "tidy" dataset to the "tidy_data.txt" file.

**Assumptions:**

  1. Internet connectivity to download source files
  2. R Package Dependancies:
    *plyr v1.8.1 or later


