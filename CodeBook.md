# CodeBook

This CodeBook is about the data set presented in **tidy_data_mean.txt** and transformations applied to reach there.  
CodeBook of original data can be found here - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Variables:  
- ActivityType: Type of activity being recorded.  
Range: 1 to 6  
Name of activity can be found in **activity_labels.txt** in original data.  
- SubjectId: ID of the subject performing this test.  
Range: 1 to 30

Other variable names have been derived from **features.txt**  
To make them 'R-frindly', following **transformation** was required.  
Here '(', ')' and '-' are not valid, so make.names() converts it to '.'  
>"fBodyGyro-mean()-Z" --> "fBodyGyro.mean...X"  

Value of these variables is the average of all observations for 'activity+subject'.  
Note that original data contained many observations sampled in fixed-width sliding windows of 2.56 sec.  
We have taken **mean** over all these samples for all 'activity+subject' combinations.
