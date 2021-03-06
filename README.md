# coursera_getdata-030
Assignment for Getting and Cleaning Data

Here I provide a script that works on raw data provided by following portal:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### How to run
To run this script, put it in a directory where you download the original data - 'UCI HAR Dataset'  
Then simply source it -  
> source(run_analysis.R)  

It may take few seconds to complete the execution. Once completed, in the same directory it will create a new file named - **tidy_data_mean.txt**  


### How script works
Steps:  
1. Reading data from source (txt files).  
2. Combine 'train' and 'test' data for each of the 3 different types of data  
3. Change variable (column) names to a more meaningful format.  
4. Now combine SubjectID, ActivityType and observation variables into one single data set  
5. Some more cleanup - column names are not R-friendly.. # Eg. "**fBodyGyro-mean()-Z**" --> "**fBodyGyro.mean...X**"  
6. Select only Mean and Standard deviation values. And then summarize to find out average of each variable for such a 'group'.  
7. Now first 'group' this by Activity and Subject  
8. Final data is ready, write it to a file.  

### Codebook
A detailed description of each variable and transformations is provided in **CodeBook.md**

### Data set
Resultant tidy data set is uploaded as **tidy_data_mean.txt**  
This is a **data set with the average of each variable for each activity and each subject**
