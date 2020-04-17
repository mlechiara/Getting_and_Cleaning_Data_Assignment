###Explanation of Analysis Files
The run_analysis.R script form a tidy data set from the given raw data in "UCI HAR Dataset"

It performs the steps below to achieve a text table of the averages of each variable for every activity and subject pair.

##Step 1:
Finds the UCI HAR Dataset folder and searches the sub-folders for the x, y, and subject text files for both test and train

It then creates and merges the 6 text files into a consolidated data set

...and finally reads in the activity labels and features names and applies them to the variable column names.

##Step 2:
Creates a vector for the mean and std deviation for each variable

##Step 3:
Imports the names associated with the numerical values for each activity

##Step 4:
Creates the tidy data set with the means for each variable that corresponds to the activity and subject pair.

Finally, this script writes the tidy data set to a text file names "tidyDataSet.txt"