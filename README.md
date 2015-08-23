# Getting and Cleaning Data Readme File - Course Project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

The run_analysis.R script prepared for this project will do the following:

1. Set project working directory
2. Download file from project site
3. Extract archived data file
4. Get list of all files in extracted folder
5. Load train and test data into their respective tables
6. Load features and activity data into their own table for later use
7. Merging all data into one data set
8. Extract data containing only mean and standard deviation columns of each measurement
9. Use descriptive activity names to name the activities in the data set
10. Appropriately labels the data set with descriptive/meaningful variable names
11. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The file name for the tidy data set is tidydataset.txt.

Below is the output when running the run_analysis.R script
> source('C:/wd/R_Analysis.R')
... Setting Working Directory
... Downloading file
trying URL 'http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB
... File downloaded from project site
... Unzipping archived file ... done!
... Archive file extracted
... There are 28 number of files in extracted folder
... Loading all data from train folder ...
... Loading all data from test folder ...
... Loading features.txt containing descriptive names
... Loading activity_labels.txt containing descriptive names
... Merging activity data from train and test
... Merging subject data from train and test
... Merging all test and train data
... Merging all data - train, subject and features into one dataset ... done!
... Getting the name of features (label) that contain mean and std names
... Extracting measurement containing activity, subject and all labels containing mean and std
... Changing activity value to descriptive/meaningful activity names
... Replacing ambiguous label with descriptive meaning
... Create new tidy data set containing mean of each variable
... New tidy data set created ... done!