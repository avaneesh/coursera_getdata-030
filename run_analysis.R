
# This script works on data is downloaded from: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Result is a data set that comprises of average over values provided in original data set.

# This script assumes you have downloaded and extracted the data from above portal.
# It is assumed that directory named 'project/UCI HAR Dataset' is present in the folder from this script is run.

# Load dplyr, we shall use few functions for manipulating data
library(dplyr)

print('Please wait... This may take a few seconds...')

# Save path for future reference 
data_dir_name <- file.path("project", "UCI HAR Dataset")
train_dir_name <- file.path(data_dir_name, "train")
test_dir_name <- file.path(data_dir_name, "test")

# Step 1: Reading data from source.

# Load provided data from text file into a data frame.
### NOTE: tbl_df() is used to convert normal "data frame" to "data frame tbl", which is 
### a dplyr's way of representating data frame.
### This was used for easier debugging and is kept here for future debugging,
### although not required in intermediate steps.
train_set_tdf <- read.table(file.path(train_dir_name, "X_train.txt")) %>% tbl_df()
train_labels_tdf <- read.table(file.path(train_dir_name, "y_train.txt")) %>% tbl_df()
train_subjects_tdf <- read.table(file.path(train_dir_name, "subject_train.txt"))  %>% tbl_df()


# Now load test data similarly
test_set_tdf <- read.table(file.path(test_dir_name, "X_test.txt")) %>% tbl_df()
test_labels_tdf <- read.table(file.path(test_dir_name, "y_test.txt"))  %>% tbl_df()
test_subjects_tdf <- read.table(file.path(test_dir_name, "subject_test.txt"))  %>% tbl_df()


# Load feature names and activity names. This will be used to create column names in final data frame
features_tdf <- read.table(file.path(data_dir_name, "features.txt")) %>% tbl_df()
activity_labels_tdf <- read.table(file.path(data_dir_name, "activity_labels.txt")) %>% tbl_df()

# Step 2: Combine 'train' and 'test' data for each of these 3 different types of data
set_df <- rbind(train_set_tdf, test_set_tdf) %>% tbl_df()
labels_df <- rbind(train_labels_tdf, test_labels_tdf) %>% tbl_df()
subject_df <-  rbind(train_subjects_tdf, test_subjects_tdf) %>% tbl_df()


# Step 3: Change variable (column) names to a more meaningful format.
names(set_df) <- features_tdf$V2 # set_df can use column names mentioned in features.txt
names(labels_df) <- c("ActivityType") # labels_df is nothing but list of types of Activity
names(subject_df) <- c("SubjectId") # subject_df, not surprizingly contains ID of subject performing this observation


# Step 4: Now combine SubjectID, ActivityType and observation variables into one single data set
data_tdf <- cbind(subject_df, labels_df)
data_tdf <- cbind(data_tdf, set_df) %>% tbl_df()


# Step 5: Some more cleanup - column names are not R-friendly
# Eg. "fBodyGyro-mean()-Z" --> "fBodyGyro.mean...X"
# Here '(', ')' and '-' are not valid, so make.names() converts it to '.'
# following post was helpful
### http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name
valid_column_names <- make.names(names=names(data_tdf), unique=TRUE, allow_ = TRUE)
names(data_tdf) <- valid_column_names

# Step 6: Select only Mean and Standard deviation values. 
data_selected <- select(data_tdf, SubjectId, ActivityType, contains("mean", ignore.case = TRUE), contains("std", ignore.case = TRUE))


# Step 7: Now first 'group' this by Activity and Subject 
# and then summarize to find out average of each variable for such a 'group'.
activity_subject_group <- group_by(data_selected, ActivityType, SubjectId)
mean_data_summary <- summarise_each(activity_subject_group, funs(mean))


# Step 8: Final data is ready, write it to a file.
write.table(mean_data_summary, file="tidy_data_mean.txt", row.name=FALSE)

print('---- Done ----')