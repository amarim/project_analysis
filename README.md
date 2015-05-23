# project_analysis
Analysis data from Project Getting and Cleaning Coursera

# About this work
- The work is a way prepare tidy data that can be used for later analysis.
- Some spread files are read to build a unique data set with mean of several variables.

# Source data set
- The analisys was made with data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".
- The data contain several observation about wearable computing with subjects in diferent activities.
- More details about this data set can to be find out together zip file.

# Files this Repository
- run_analysis.r: This file is a R code that contain a function. This function have as output a independent tidy data set with the average of each variable for each activity and each subject.
- CodeBook.md: This file descript each variable in out data set.

# Example to call function and view data set in run_analysis.r file
- source("run_analysis.r")
- dataset <- run_analysis()
- View(dataset)
