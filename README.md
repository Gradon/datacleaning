# datacleaning
Getting and Cleaning Data Course Project

Contains one R script to transform the UCI Human Activity Recognition raw data
into a usable tidy dataset.

Assumes that the UCI HAR Dataset is available in a subdirectory of the current
active directory using the original file structure.

Merges training and test datasets into a single dataset.
  Extract measured variable data from files X_test.txt and X_train.txt into
  two separate tables (test, train). Each observation contains 561 variables
  Extract the activities being performed by each subject during each observation.
  These are pulled into two separate tables (testactivities, trainactivities).
  Extract the subject identifiers associated with each observation. These are
  pulled into two separate tables (testsubjects, trainsubjects).
  Datasets are merged after labeling is completed using the steps below.
  
Adds descriptive activity names for each activity in the dataset.
  Activity labels are pulled from activity_labels.txt in the original dataset.

Labels the dataset with descriptive variable names.
  Variable names are pulled from features.txt in the original dataset.

Extracts mean and standard deviation for each measurement.
  Mean and standard deviation measurements are selected from the full-sized dataset.

Generates a tidy dataset with the average of each variable for each activity and subject.
  Splits the original data frame into individual dataframes by activity/subject
  combination, then finds the mean of each variable and stores to a vector. All vectors
  are then combined into a finished dataframe.
