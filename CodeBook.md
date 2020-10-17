Original variable names and descriptors are available in features_info.txt from
the UCI HAR Dataset.

Writes a finished data set containing the mean of each variable by activity and
by subject. This is done for each variable containing mean() and std() in the
original dataset.

Actions:
reads variable data from X_test, X_train.txt
reads activities associated with each observation from y_test.txt and y_train.txt
reads subjects associated with each observation from subject_test.txt and subject_train.txt
replaces each numeric value for activity with description in activity_labels.txt
sets names of the variables in the dataset according to features.txt

combines activities and subjects with variables to build a dataset for test and train
combines test and training datasets into a single dataset

extracts only the mean and standard deviation variables (mean() and std() in the dataset)

relabels the variables with longer variable names instead of abbreviations

groups the data set by subject and activity
applies the mean for each variable using the sorted grouping of subject/activity

writes dataset to file for output