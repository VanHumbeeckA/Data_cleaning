library(plyr)
library(data.table)

# Merges the training and the test sets to create one data set.

# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

testdir <- ".\\UCI HAR Dataset\\test\\"
traindir <- ".\\UCI HAR Dataset\\train\\"
namedir <- ".\\UCI HAR Dataset\\"

features.list <- read.table(paste(namedir, 'features.txt', sep='')) # dim (561   2)
variables <- as.character(features.list[,2])
features.names <- c(variables, "activity", "subject")
activity.labels <- read.table(paste(namedir, 'activity_labels.txt', sep=''))
names(activity.labels) <- c("activity", "label")

x_test <- read.table(paste(testdir, 'X_test.txt', sep='')) # dim (2947  561)
y_test <- read.table(paste(testdir, 'y_test.txt', sep='')) # dim (2947    1)
subject_test <- read.table(paste(testdir, 'subject_test.txt', sep=''))
test <- cbind(x_test, y_test, subject_test)
names(test) <- features.names

x_train <- read.table(paste(traindir, 'X_train.txt', sep='')) # dim (7352  561)
y_train <- read.table(paste(traindir, 'y_train.txt', sep='')) # dim (7352    1)
subject_train <- read.table(paste(traindir, 'subject_train.txt', sep=''))
train <- cbind(x_train, y_train, subject_train)
names(train) <- features.names

data <- rbind(train, test) # dim (10299   563)

# Extracts only the measurements on the mean and standard deviation for each measurement. 

all.mean.cols <- grepl("mean", features.names) # boolean vector of length 562
all.std.cols <- grepl("std", features.names) # boolean vector of length 562
all.activity <- grepl("activity", features.names)
all.subject <- grepl("subject", features.names)
all.mean.std <- Reduce('|',list(all.mean.cols, all.std.cols,all.activity,all.subject))

data.extract <- data[all.mean.std]

# Uses descriptive activity names to name the activities in the data set
data.merged <- join(data.extract, activity.labels, type="left") # dim (10299    81)

# Appropriately labels the data set with descriptive variable names. 

# ==> allready done in step1

# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

result <- ddply(data.merged, .(activity, subject, label), colwise(mean))
result
