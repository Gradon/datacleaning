## This R script performs data cleaning functions on the UCI Human Activity
## Recognition data set.

## assume that the data is contained in a subdirectory called "UCI HAR Dataset".

library(dplyr)

## read the data from the test dataset and training dataset into R tables
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")

## pull the activities associated with each observation
testactivities <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainactivities <- read.table("./UCI HAR Dataset/train/y_train.txt")

## pull the subjects associated with each observation
testsubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
trainsubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## pull labels for what each activity 'number' means from activity_labels.txt
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## read the variable names from features.txt
varnames <- read.table("./UCI HAR Dataset/features.txt")

## set names of the variables in test and train datasets
names(test) <- varnames$V2
names(train) <- varnames$V2

## replace the numbered activity names with their labels (sort of ugly)
testactivities <- merge(testactivities, activitylabels, by = "V1", sort = FALSE)
trainactivities <- merge(trainactivities, activitylabels, by = "V1", sort = FALSE)
testactivities <- testactivities[,2]
trainactivities <- trainactivities[,2]

## add the activity and subjects tracked as a column to each dataset
test <- cbind(activity = testactivities, subject = testsubjects$V1, test)
train <- cbind(activity = trainactivities, subject = trainsubjects$V1, train)

## combine the test and training datasets into a single table
combinedata <- rbind(test, train)

## extract the mean and stdev measurements and the activity/subject identifiers
combinedata <- select(combinedata, activity | subject | contains("mean()") | contains ("std()"))

## make names readable
names(combinedata) <- gsub("^t", "Time", names(combinedata))
names(combinedata) <- gsub("^f", "Frequency", names(combinedata))
names(combinedata) <- gsub("Acc", "Acceleration", names(combinedata))
names(combinedata) <- gsub("Gyro", "Gyroscope", names(combinedata))
names(combinedata) <- gsub("Mag", "Magnitude", names(combinedata))
names(combinedata) <- gsub("-mean", "Mean", names(combinedata))
names(combinedata) <- gsub("-std", "StdDev", names(combinedata))
names(combinedata) <- gsub("-", "", names(combinedata))
names(combinedata) <- gsub("\\(", "", names(combinedata))
names(combinedata) <- gsub("\\)", "", names(combinedata))

## build data frame to perform mean over each activity/subject

## create grouping by subject and activity
combinedata <- group_by(combinedata, subject, activity)

## apply mean to the combined data using the sorted groupings
finishdata <- summarize_all(combinedata, .funs = mean)

## write tidy data set to file
write.table(finishdata, "./tidydata.txt")