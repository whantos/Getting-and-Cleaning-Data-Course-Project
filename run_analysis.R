# This File contains all Function for getting and prepare the Data
# needet fpor the Course Project
library(data.table)
library(httr)

# This function Downloads the raw-Data as zip and extrakt them
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file = "data/projectfiles.zip"

if(!dir.exists("data")) { dir.create("data") }
if(!file.exists(file)) { download.file(url,file) }

# check if extrakted
#if(!dir.exists("data/UCI HAR Dataset")) { 
    print("Unzip Data ...")
    unzip(file, exdir = "data")
    print("Unzip complete")
#}
print("Raw Data is now avilable.")


# read the variable-labels
features <- fread("data/UCI HAR Dataset/features.txt")
# read the activity-labels
activity_labels <- fread("data/UCI HAR Dataset/activity_labels.txt")

# select the column names that we want to keep
colNumbersToKeep <- grep("-((mean(Freq)?)|(std))\\(\\)", features$V2, value = FALSE)

# read the measurement
trainXData <- fread("data/UCI HAR Dataset/train/X_train.txt"
                    , col.names = features$V2[colNumbersToKeep]
                    , select = colNumbersToKeep)
testXData  <- fread("data/UCI HAR Dataset/test/X_test.txt"
                   ,  col.names = features$V2[colNumbersToKeep]
                   , select = colNumbersToKeep)

# read the activity 
trainYData <- fread("data/UCI HAR Dataset/train/Y_train.txt"
                    , col.names = c("activity"))
testYData  <- fread("data/UCI HAR Dataset/test/Y_test.txt"
                    , col.names = c("activity"))

# read the subjects
trainSubjectData <- fread("data/UCI HAR Dataset/train/subject_train.txt"
                          , col.names = c("subject"))
testSubjectData  <- fread("data/UCI HAR Dataset/test/subject_test.txt"
                          , col.names = c("subject"))

# merge the train and test data
yData <- rbind(trainYData,testYData)
xData <- rbind(trainXData,testXData) 
subjectData <- rbind(trainSubjectData, testSubjectData)

# join subject, activity and measurements
mergedData <- cbind(subjectData, yData, xData)

# use "factor" to encode the activity-row as a factor
mergedData$activity <- factor(  mergedData$activity
                              , levels = activity_labels$V1
                              , labels = activity_labels$V2)

# create a second Data set with the average of each variable 
# for each activity and each subject.
summary_data <- mergedData[,lapply(.SD, mean), by=c("subject","activity")] 
# rename the column-names to show the used summary method 
colnames(summary_data)[-c(1:2)] <- paste(colnames(summary_data)[-c(1:2)]
                                         ,"_mean",sep="")
# save the result as csv-file 
write.table(summary_data, "./summary_data.txt", row.names = FALSE)
print("summary_data.txt is now avilable.")