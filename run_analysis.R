# This script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Read in the features list
features <- read.table("./UCI HAR Dataset/features.txt")
# Extract the numbers corresponding to the mean and standard deviation mesaurements
features_subset <- features[grep("mean|std",features[,2]),1]
# Extract the names corresponding to the mean and standard deviation mesaurements
features_subset_names <- features[grep("mean|std",features[,2]),2]

# Read in the activity labels
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Read in the trainig data
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
# Extract only the mean and standard deviation training mesaurements
train_subset <- train_data[,features_subset]
# Label the columns in the training subset with the corresponding feature names
colnames(train_subset) <- features_subset_names
# Label the column in the training subject table
colnames(train_subject) <- "Subject"
# Label the column in the training activity table
colnames(train_activity) <- "Activity"

# Read in the test data
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
# Extract only the mean and standard deviation test mesaurements
test_subset <- test_data[,features_subset]
# Label the columns in the test subset with the corresponding feature names
colnames(test_subset) <- features_subset_names
# Label the column in the test subject table
colnames(test_subject) <- "Subject"
# Label the column in the test activity table
colnames(test_activity) <- "Activity"

# Merge training subset data into one table
train_table <- cbind(train_subject,train_activity,train_subset)

# Merge test subset data into one table
test_table <- cbind(test_subject,test_activity,test_subset)

# Merge test_table and train_table into one table
data_table <- rbind(train_table,test_table)

# Sort the data table by Subject and Activity
data_table <- data_table[order(data_table$Subject,data_table$Activity),]

# Compute the average of each measurement for each activity and each subject
mean_table <- data.frame()

for (i in 1:30) {
    for (j in 1:6) {
        result <- apply(data_table[(data_table$Subject == i & data_table$Activity == j),3:ncol(data_table)],2,mean)
        new_row <- c(i,j,result)
        mean_table <- rbind(mean_table,new_row)
    }
}

# Label the mean table columns
names(mean_table) <- names(data_table)

# Use names for the mean table Activity column values
mean_table[,2] <- factor(mean_table[,2], labels=activity[,2])

# Write the table to a file
write.table(mean_table, file = "./mean_data.txt", row.names = FALSE)