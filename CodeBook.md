Original variable names and descriptors are available in features_info.txt from
the UCI HAR Dataset.

The final data frame (newdata) produced by this analysis contains an average for 
each activity performed by each subject, so each row refers to an average for the
readings for that particular variable in the original dataset for that
activity/subject combination.

Referring to the original documentation:
tBodyAcc-mean()-X in the original dataset is the average of the time-domain body
acceleration signal in the X-direction. The variable labeled tBodyAcc-mean()-X 
in the newdata dataset is the average of the results for tBodyAcc-mean()-X for
all of the observations where the individual identified in the 'subject' variable
performed the activity identified in the 'activity' variable.

This analysis is performed for each of the mean() and std() variables present in
the original HAR dataset.