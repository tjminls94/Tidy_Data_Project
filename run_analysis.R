## Create one R script called run_analysis.R

## 1) Merge the training and the test sets to create one data set.

## 1a) Read in all text files and put into individual data frames

X_test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
X_train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

## 1b) assign row names to data frames
colnames(X_test) <- features[,2]
colnames(y_test) <- "Activity"
colnames(subject_test) <- "Subject"
colnames(X_train) <- features[,2]
colnames(y_train) <- "Activity"
colnames(subject_train) <- "Subject"

## 1c) Create master Test and Train data frames
Test <- cbind(X_test,y_test,subject_test)
Train <- cbind(X_train,y_train,subject_train)

## 1d) Combine Test and Train into Combined
Combined <- rbind(Test,Train)

## 2) Extract only the measurements on the mean "mean()" and 
##    standard deviation "std()" for each measurement. 

## 2a) Just get the columns that have mean or std
meanstdcols <- grep("mean|std",features[,2],value=TRUE)

## 2b) Add Activity and Subject columns
meanstdcols <- c(meanstdcols,"Activity","Subject")

## 2c) Extract only these columns into the data set
Combined <- Combined[,meanstdcols]

## 3) Uses descriptive activity names to name the activities in the data set
##    We will replace each value in "Activity" with the corresponding
##    descriptive value from activity_labels

Combined$Activity[Combined$Activity==1] <- "WALKING"
Combined$Activity[Combined$Activity==2] <- "WALKING_UPSTAIRS"
Combined$Activity[Combined$Activity==3] <- "WALKING_DOWNSTAIRS"
Combined$Activity[Combined$Activity==4] <- "SITTING"
Combined$Activity[Combined$Activity==5] <- "STANDING"
Combined$Activity[Combined$Activity==6] <- "LAYING"

## 4) Appropriately labels the data set with descriptive variable names. 
## accomplished in 1b above


## 5) From the data set, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

## 5a) Melt data frame using id's (Subject and Activity) and variables (all the rest)
Data <- Combined
meltData <- melt(Data, id = c("Subject", "Activity"), measure.vars = meanstdcols[1:46])

## 5b) Create tidy data set of the mean of each variable based by Subject & Activity
tidy <- dcast(meltData, formula = Subject + Activity ~ variable, mean)

## 5c) Write the table to a .txt file
write.table(tidy, file="tidy.txt", row.names=FALSE)
