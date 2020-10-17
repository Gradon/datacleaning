# datacleaning
Getting and Cleaning Data Course Project

Contains one R script to transform the UCI Human Activity Recognition raw data
into a usable tidy dataset.

Assumes that the UCI HAR Dataset is available in a subdirectory of the current
active directory using the original file structure.

Merges training and test datasets into a single dataset.
  Extract measured variable data from files X_test.txt and X_train.txt into
  two separate tables (test, train).
  
  Extract the activities being performed by each subject during each observation
  (files Y_test.txt and Y_train.txt)
  
  Extract the subject identifiers associated with each observation. These are
  pulled into two separate tables (testsubjects, trainsubjects).
  
  Datasets are merged after labeling is completed using the steps below.
  
Adds descriptive activity names for each activity in the dataset.
  Activity labels are pulled from activity_labels.txt in the original dataset.

Labels the dataset with descriptive variable names.
  Variable names are pulled from features.txt in the original dataset.
  Replaces abbreviations with full descriptors.

Extracts mean and standard deviation for each measurement.
  Mean and standard deviation measurements are selected from the full dataset.

Generates a tidy dataset with the average of each variable for each activity and subject.
  Groups the data in the combined dataset by activity/subject
  Creates a new dataset with the means of the variables using summarize_all
  on the grouped dataset.
