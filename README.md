# Getting and Cleaning Data Course Project

## run_analysis.R Script Description

This script can be run using the following command: source("run_analysis.R")

The script requires the following files from the original Samsung data set to
be located in the same directory as the run_analysis script:
acitvity_labels.txt, features.txt,
subject_test.txt, X_test.txt, y_test.txt,
subject_train.txt, X_train.txt, and y_train.txt

The script will take several seconds to run due to the time required for
reading in the data from the above files.

The result of the run_analysis.R script is a tidy data set file called 
mean_data.txt which contains the average of the mean and standard deviation 
measurements from the Samsung training and test data for each subject and 
each activity. It creates this data file by performing the following functions:

1. Reads in the Samsung data measurement variables from the features.txt file
and extracts only the names and numbers corresponding to the mean and standard 
deviation measurements.

2. Reads in the activity names from the activity_labels.txt file.

3. Reads in the training data from the subject_train.txt, y_train.txt, and
X_train.txt files into 3 separate tables and extracts only the mean and 
standard deviation measurements (using the info obtained in Step 1 above) from 
the third measurement table.

4. Reads in the test data from the subject_test.txt, y_test.txt, and X_test.txt 
files into 3 additional tables and extracts only the mean and standard 
deviation measurements (using the info obtained in Step 1 above) from the 
third additional measurement table.

5. Combines the data in the tables from Steps 3 and 4 above by first merging 
the 3 training tables into one training table and the 3 test tables into one
test table, and then merging the training table with the test table.

6. Sorts the single data table from Step 5 above by Subject and Activity
and uses this table to compute and store in a new table the mean of each 
measurement variable for each subject and each activity.

7. Sets the column names in the new table from Step 6 above using the info
obtained from Steps 1 and 2, and then writes the resulting table to a file
called mean_data.txt.
