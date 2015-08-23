##
## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Some settings to save typing and allow modification if the source file is no longer
# available at the location specified
sourceFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfilename <- "UCI_HAR_Dataset.zip"
tidyfilename <- "tidy_dataset.txt"

# Make sure we have the libraries we need to complete the work
library(dplyr)

###############################################################
# Step 0: Get the file & unzip it. We'll also load in the data.

download.file(sourceFileUrl, method="libcurl", destfile=destfilename)
unzip(destfilename)

# Files will now be in UCI HAR Dataset folder
setwd(paste(getwd(), "UCI HAR Dataset", sep="/"))

# Read in features.txt file which contains list of all features
features <- read.table("features.txt", header = FALSE)
feature_names <- features$V2


# Read in the activity_labels.txt file which contains list of activities
activity_labels <- read.table("activity_labels.txt", header = FALSE)
# Column1 of activity_labels contains activityId and column2 contains activityName
activity_labels <- setNames(activity_labels, c("activityId", "activityName"))


# Read in the test files
subject_test <- read.table("test/subject_test.txt", header = FALSE)
subject_test <- setNames(subject_test, "subjectId")

x_test <- read.table("test/X_test.txt", header = FALSE)
x_test <- setNames(x_test, feature_names)

y_test <- read.table("test/y_test.txt", header = FALSE)
y_test <- setNames(y_test, "activityId")

# Read in the train files
subject_train <- read.table("train/subject_train.txt", header = FALSE)
subject_train <- setNames(subject_train, "subjectId")

x_train <- read.table("train/X_train.txt", header = FALSE)
x_train <- setNames(x_train, feature_names)

y_train <- read.table("train/y_train.txt", header = FALSE)
y_train <- setNames(y_train, "activityId")

##############################
# Step 1: Merge the data steps


# Make the test data one set
test_data <- cbind(subject_test, y_test, x_test)

# Make the train data one set
train_data <- cbind(subject_train, y_train, x_train)

# Now join the test and train data sets
merged_data <- rbind(test_data, train_data)


###############################################################
# Part 2 : Extract only mean and standard deviation measurments

mean_std <- merged_data[, grep("subjectId|activityId|-mean\\(\\)|-std\\(\\)", colnames(merged_data))]


########################################
# Part 3: Add descriptive activity names
mean_std$activity <- factor(mean_std$activityId, levels = activity_labels[, 1], labels = activity_labels[, 2])


########################################
# Part 4: Add descriptive variable names

names(mean_std) <- gsub("^t", "time", names(mean_std))
names(mean_std) <- gsub("^f", "frequency", names(mean_std))
names(mean_std) <- gsub("Acc", "Accelerometer", names(mean_std))
names(mean_std) <- gsub("Gyro", "Gyrometer", names(mean_std))
names(mean_std) <- gsub("Mag", "Magnitude", names(mean_std))
names(mean_std) <- gsub("BodyBody", "Body", names(mean_std))
names(mean_std) <- gsub("[-()]", "", names(mean_std))
names(mean_std) <- gsub("mean", "_mean", names(mean_std))
names(mean_std) <- gsub("std", "_std", names(mean_std))


#######################################################################
# Step 5: Create a new data set grouping readings by subject & activity

final_data <- mean_std[, !colnames(mean_std) == "activityId"] %>%
    group_by(subjectId, activity) %>%
    summarise_each(funs(mean))


##########################################################
# Finally: Create the output file with the summarised data

setwd("..")
write.table(final_data, file = tidyfilename, sep=",", row.names = FALSE)
