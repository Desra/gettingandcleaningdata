#1. Set project working directory
directory <- c("C:/wd")
setwd(directory)
message("... Setting Working Directory")

#2. Download file from project site

fileName <- "UCI_HAR_Dataset.zip"
urlLink <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
options('download.file.method'='curl')
message("... Downloading file")
download.file(urlLink, fileName, method="auto")
message("... File downloaded from project site ... done!")

#3. Extract archived data file
message("... Unzipping archived file ... done!")

unzip(fileName)
message("... Archive file extracted")

#4. Get list of all files in extracted folder
file_list <- list.files("./UCI HAR Dataset", recursive = TRUE)
num_files <- length(file_list)
messages <- paste("... There are",num_files)
messages <- paste(messages,"number of files in extracted folder")
message(messages)

#5. Load train and test data into their respective tables

message("... Loading all data from train folder ...")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
train_activity <- read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

message("... Loading all data from test folder ...")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
test_activity <- read.table("./UCI HAR Dataset/test/Y_test.txt",header = FALSE)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

#6. Load features and activity data into their own table for later use

message("... Loading features.txt containing descriptive names")
features_name <- read.table("./UCI HAR Dataset/features.txt",head=FALSE)

message("... Loading activity_labels.txt containing descriptive names")
activity_name <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)

#7. Merging all data into one data set

message("... Merging activity data from train and test")
activity_all <- rbind(train_activity, test_activity)
names(activity_all) <- c("activity")

message("... Merging subject data from train and test")
subject_all <- rbind(train_subject, test_subject)
names(subject_all) <- c("subject")

message("... Merging all test and train data")
data_all <- rbind(train_data, test_data)
names(data_all) <- features_name$V2

message("... Combining all data - train, subject and features into one dataset ... done!")
merged_dataset <- cbind(activity_all,subject_all,data_all)

#8. Extract data containing only mean and standard deviation columns of each measurement

message("... Getting the name of features (label) that contain mean and std names")
meanStd <-features_name$V2[grep(".*mean.*|.*std.*", features_name$V2)]

message("... Extracting measurement containing activity, subject and all labels containing mean and std")
meanStd_all <- c("activity","subject",as.character(meanStd))
extracted_data <- subset(merged_dataset,select=meanStd_all)
head(extracted_data)


#9. Use descriptive activity names to name the activities in the data set
message("... Changing activity value to descriptive/meaningful activity names")
extracted_data$activity <- factor(extracted_data$activity, levels = activity_name[,1], labels = activity_name[,2])

#10. Appropriately labels the data set with descriptive/meaningful variable names
message("... Replacing ambiguous label with descriptive meaning")
names(extracted_data)<-gsub("^t", "time", names(extracted_data))
names(extracted_data)<-gsub("^f", "frequency", names(extracted_data))
names(extracted_data)<-gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data)<-gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data)<-gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data)<-gsub("BodyBody", "Body", names(extracted_data))

#11. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

message("... Create new tidy data set containing mean of each variable")
library(plyr);
extracted_data2<-aggregate(. ~subject + activity, extracted_data, mean)
extracted_data2<-extracted_data2[order(extracted_data2$subject,extracted_data2$activity),]
write.table(extracted_data2, file = "tidydataset.txt",row.name=FALSE)
message("... New tidy data set created ... done!")