Data Source

Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Summary of project

Purpose:  You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Requires data.table, reshape2 and plyr libraries to be loaded.

Output
Output of run_analysis.R will be the text file tidy.txt

Other variables created during the execution of run_analysis.R:

* Combined: data frame of Test and Training data
* Test: data frame of Test data only
* Train: data frame of Train data only
* tidy: output data frame of the mean of each sample according to Subject and Activity
