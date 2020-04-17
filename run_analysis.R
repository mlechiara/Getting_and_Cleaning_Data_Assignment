##########################################################
##            Import and merge datasets                 ##
##########################################################

# Create a list of files in the test & train directories
testList <- list.files(path = "./UCI HAR Dataset/test",
                        pattern = ".*.txt")
trainList <- list.files(path = "./UCI HAR Dataset/train",
                        pattern = ".*.txt")

# Get the name of the directories in the folder
dirString <- "./UCI HAR Dataset"
testPath <- paste(dirString, "test", sep = "/")
trainPath <- paste(dirString, "train", sep = "/")

# Create data tables for train and test
sTest <- read.table(paste(testPath, testList[1],sep = "/"))
xTest <- read.table(paste(testPath, testList[2],sep = "/"))
yTest <- read.table(paste(testPath, testList[3],sep = "/"))

sTrain <- read.table(paste(trainPath, trainList[1],sep = "/"))
xTrain <- read.table(paste(trainPath, trainList[2],sep = "/"))
yTrain <- read.table(paste(trainPath, trainList[3],sep = "/"))

# Read in the labels and features
actLbls <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# Add column names
colnames(sTest) <- "subject"
colnames(sTrain) <- "subject"

colnames(xTest) <- features[,2]
colnames(xTrain) <- features[,2]

colnames(yTest) <- "activity"
colnames(yTrain) <- "activity"

# Merge files
mergedTest <- cbind(yTest,sTest,xTest)
mergedTrain <- cbind(yTrain,sTrain,xTrain)
mergedData <- rbind(mergedTrain,mergedTest)

###########################################################
# Create Vector for Mean and Std Dev for Each Measurement #
###########################################################
meanAndStdDev <- (  grepl("activity", names(mergedData)) |
                    grepl("subject", names(mergedData) ) |
                    grepl("mean", names(mergedData)    ) |
                    grepl("std", names(mergedData)     )
                    )
mu_sigma_subset <- mergedData[, meanAndStdDev == TRUE]

###########################################################
##                 Name the Activities                   ##
###########################################################

mu_sigma_subset$activity <- factor(mu_sigma_subset$activity,
                                   levels = actLbls[, 1],
                                   labels = actLbls[, 2]
                                   )

##  Descriptive variable names completed in lines 31-38  ##

###########################################################
##            Tidy Data Set with Averages                ##
###########################################################
tidyDataSet <- aggregate(. ~activity + subject, mu_sigma_subset, mean)

# Write the data to a text file
write.table(tidyDataSet, "tidyDataSet.txt", row.name = FALSE)
