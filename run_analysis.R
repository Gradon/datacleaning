## This R script performs data cleaning functions on the UCI Human Activity
## Recognition data set.

## assume that the data is contained in a subdirectory called "UCI HAR Dataset".

## read the data from the test dataset and training dataset into R tables
## each observation contains 561 variables, stored in X_test or X_train
## the activity tracked for each observation is stored in Y_test or Y_train
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

## replace the numbered activity names with their labels (sort of ugly)
testactivities <- merge(testactivities, activitylabels, by = "V1", sort = FALSE)
trainactivities <- merge(trainactivities, activitylabels, by = "V1", sort = FALSE)
testactivities <- testactivities[,2]
trainactivities <- trainactivities[,2]

testsubjects <- rename(testsubjects, subject = V1)
trainsubjects <- rename(trainsubjects, subject = V1)

## read the variable names from features.txt
## this table will have 561 rows corresponding to the variables in the datasets
varnames <- read.table("./UCI HAR Dataset/features.txt")

## names of the variables are in the second column of the features.txt table
namesvector <- varnames[,2]

## set names of the variables in test and train datasets
names(test) <- namesvector
names(train) <- namesvector

## add the activity tracked as a column to each dataset
test <- cbind(test, activity = testactivities)
train <- cbind(train, activity = trainactivities)

## add the subject identifies as a column to each dataset
test <- cbind(test, subject = testsubjects)
train <- cbind(train, subject = trainsubjects)

## combine the HAR data test and training datasets into a single table
combinedata <- rbind(test, train)

## extract the mean and stdev measurements and the activity/subject identifiers
extractdata <- select(combinedata, contains("mean()") | contains ("std()") | contains ("activity") | contains("subject"))

## save the variable names since we'll be making a new data frame
namesvector <- names(extractdata)

## create a new independent tidy data set with the average of each variable for each activity and subject
## start by splitting the data frame into a list of data frames for each activity/subject combo
splitframe <- split(extractdata, list(extractdata$activity, extractdata$subject))

## for each activity/subject combination there will be a row of our new data frame
## iterate over the list of data frames corresponding to each subject/activity
## not every subject has data for every activity
tempframe <- data.frame()
tempframe2 <- data.frame()
newdata <- data.frame()
for(i in 1:length(splitframe))
{
    tempframe <- as.data.frame(splitframe[i])
    if(nrow(tempframe) > 0)
    {
      ## store the activity and subject to the side, don't need their mean
      currentactivity <- tempframe[1,67]
      currentsubject <- tempframe[1,68]
      tempframe <- select(tempframe, 1:66)
      ## iterate over the variables and put their mean into a new frame
      for(j in 1:ncol(tempframe))
      {
          tempframe2[1,j] <- mean(tempframe[,j])
      }
      tempframe2[1,67] <- currentactivity
      tempframe2[1,68] <- currentsubject
      ## tempframe2 should be a single-row data frame with the means of each variable
      newdata <- rbind(newdata, tempframe2)
    }
}
names(newdata) <- namesvector
