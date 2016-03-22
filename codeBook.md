# Getting-and-Cleaning-Data-Course-Project

##Study design  
This section explains where the Raw-Data comes from and whitch steps are performed to get the Summary-Dataset (summary_data.csv)

* **Download an extract the Raw-Data**
    + Check if directory "data" exists in curent directory and creates it if not.
    + Check if the fiel "data/prjectfiles.zip" exists. If not, download file   
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
and save it as "data/prjectfiles.zip"
    + Unzip the Raw-Data into the "data" directory 
* **Read and merge the train and test data**
	+ Read the file "data/UCI HAR Dataset/features.txt" and store the data in a character vector "features". This file contains the labels for all features   
	and are used as column headers for the train and test dataset. 
	+ Read the file "data/UCI HAR Dataset/activity_labels.txt". This file contains the labels for all activities  
	used in the test and train dataset. The Data ist stored in the character vector "activity_lables".
	+ Create a numeric vector "colNumbersToKeep" that contains just the columns we want to read. For this Project we want  
	just the Columns that contains the mean and standard deviation for each measurement. To get just the wanted Columns  
	this regexp is used : `"-((mean(Freq)?)|(std))\\(\\)"`
	+ Read the train and test data
		+ The traindata is avilable in the file "data/UCI HAR Dataset/train/X_train.txt"
		+ The testdata is avilable in the file "data/UCI HAR Dataset/test/X_test.txt"
		+ The files are read with the fread function from the "data.table" package
			+ To select just the needed columns, the select argument is set to the "colNumbersToKeep" Vector
			+ The col.names argument is set to the "feature" vector to add Column names.
	+  Read the "subjects" for the train and test data
		+ The subjects for the traindata is avilable in the file "data/UCI HAR Dataset/train/subject_train.txt"
		+ The subjects for the testdata is avilable in the file "data/UCI HAR Dataset/test/subject_test.txt"
	+ Merge the Data
		+ Row-Bind the train and test activitys to make a union -> "y Data"
		+ Row-Bind the train and test Data to make a union -> "x Data"
		+ Row-Bind the train and test subjects to make a union -> "subject Data"
		+ Column-Bind "subject Data", "y Data"  and "x Data" to create  a single Dataset
 	+ The "factor" function is used to encode the activity numbers. The labels for the levels are stored in the "activity_lables" vector
* **Create a second Data set with the average of each variable**
	+ Calculate the Average of each Variable grouped by subject and activity
	+ Append "_mean : number [-1..1]" to each column name to name the new Variables
	+ Save the the result Dataset as csv-file named "summary_data.csv" with "," as separator
 

		
##Code book  
This Section contains all variables in the file summary_data.csv.  
It contains 181 rows including one header row and 81 Columns.


* **Variables:**
+	subject : integer [1..30]
+	activity : Factor with 6 levels [1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING] 
+	tBodyAcc-mean()-X_mean : numeric [-1..1]
+	tBodyAcc-mean()-Y_mean : numeric [-1..1]
+	tBodyAcc-mean()-Z_mean : numeric [-1..1]
+	tBodyAcc-std()-X_mean : numeric [-1..1]
+	tBodyAcc-std()-Y_mean : numeric [-1..1]
+	tBodyAcc-std()-Z_mean : numeric [-1..1]
+	tGravityAcc-mean()-X_mean : numeric [-1..1]
+	tGravityAcc-mean()-Y_mean : numeric [-1..1]
+	tGravityAcc-mean()-Z_mean : numeric [-1..1]
+	tGravityAcc-std()-X_mean : numeric [-1..1]
+	tGravityAcc-std()-Y_mean : numeric [-1..1]
+	tGravityAcc-std()-Z_mean : numeric [-1..1]
+	tBodyAccJerk-mean()-X_mean : numeric [-1..1]
+	tBodyAccJerk-mean()-Y_mean : numeric [-1..1]
+	tBodyAccJerk-mean()-Z_mean : numeric [-1..1]
+	tBodyAccJerk-std()-X_mean : numeric [-1..1]
+	tBodyAccJerk-std()-Y_mean : numeric [-1..1]
+	tBodyAccJerk-std()-Z_mean : numeric [-1..1]
+	tBodyGyro-mean()-X_mean : numeric [-1..1]
+	tBodyGyro-mean()-Y_mean : numeric [-1..1]
+	tBodyGyro-mean()-Z_mean : numeric [-1..1]
+	tBodyGyro-std()-X_mean : numeric [-1..1]
+	tBodyGyro-std()-Y_mean : numeric [-1..1]
+	tBodyGyro-std()-Z_mean : numeric [-1..1]
+	tBodyGyroJerk-mean()-X_mean : numeric [-1..1]
+	tBodyGyroJerk-mean()-Y_mean : numeric [-1..1]
+	tBodyGyroJerk-mean()-Z_mean : numeric [-1..1]
+	tBodyGyroJerk-std()-X_mean : numeric [-1..1]
+	tBodyGyroJerk-std()-Y_mean : numeric [-1..1]
+	tBodyGyroJerk-std()-Z_mean : numeric [-1..1]
+	tBodyAccMag-mean()_mean : numeric [-1..1]
+	tBodyAccMag-std()_mean : numeric [-1..1]
+	tGravityAccMag-mean()_mean : numeric [-1..1]
+	tGravityAccMag-std()_mean : numeric [-1..1]
+	tBodyAccJerkMag-mean()_mean : numeric [-1..1]
+	tBodyAccJerkMag-std()_mean : numeric [-1..1]
+	tBodyGyroMag-mean()_mean : numeric [-1..1]
+	tBodyGyroMag-std()_mean : numeric [-1..1]
+	tBodyGyroJerkMag-mean()_mean : numeric [-1..1]
+	tBodyGyroJerkMag-std()_mean : numeric [-1..1]
+	fBodyAcc-mean()-X_mean : numeric [-1..1]
+	fBodyAcc-mean()-Y_mean : numeric [-1..1]
+	fBodyAcc-mean()-Z_mean : numeric [-1..1]
+	fBodyAcc-std()-X_mean : numeric [-1..1]
+	fBodyAcc-std()-Y_mean : numeric [-1..1]
+	fBodyAcc-std()-Z_mean : numeric [-1..1]
+	fBodyAcc-meanFreq()-X_mean : numeric [-1..1]
+	fBodyAcc-meanFreq()-Y_mean : numeric [-1..1]
+	fBodyAcc-meanFreq()-Z_mean : numeric [-1..1]
+	fBodyAccJerk-mean()-X_mean : numeric [-1..1]
+	fBodyAccJerk-mean()-Y_mean : numeric [-1..1]
+	fBodyAccJerk-mean()-Z_mean : numeric [-1..1]
+	fBodyAccJerk-std()-X_mean : numeric [-1..1]
+	fBodyAccJerk-std()-Y_mean : numeric [-1..1]
+	fBodyAccJerk-std()-Z_mean : numeric [-1..1]
+	fBodyAccJerk-meanFreq()-X_mean : numeric [-1..1]
+	fBodyAccJerk-meanFreq()-Y_mean : numeric [-1..1]
+	fBodyAccJerk-meanFreq()-Z_mean : numeric [-1..1]
+	fBodyGyro-mean()-X_mean : numeric [-1..1]
+	fBodyGyro-mean()-Y_mean : numeric [-1..1]
+	fBodyGyro-mean()-Z_mean : numeric [-1..1]
+	fBodyGyro-std()-X_mean : numeric [-1..1]
+	fBodyGyro-std()-Y_mean : numeric [-1..1]
+	fBodyGyro-std()-Z_mean : numeric [-1..1]
+	fBodyGyro-meanFreq()-X_mean : numeric [-1..1]
+	fBodyGyro-meanFreq()-Y_mean : numeric [-1..1]
+	fBodyGyro-meanFreq()-Z_mean : numeric [-1..1]
+	fBodyAccMag-mean()_mean : numeric [-1..1]
+	fBodyAccMag-std()_mean : numeric [-1..1]
+	fBodyAccMag-meanFreq()_mean : numeric [-1..1]
+	fBodyBodyAccJerkMag-mean()_mean : numeric [-1..1]
+	fBodyBodyAccJerkMag-std()_mean : numeric [-1..1]
+	fBodyBodyAccJerkMag-meanFreq()_mean : numeric [-1..1]
+	fBodyBodyGyroMag-mean()_mean : numeric [-1..1]
+	fBodyBodyGyroMag-std()_mean : numeric [-1..1]
+	fBodyBodyGyroMag-meanFreq()_mean : numeric [-1..1]
+	fBodyBodyGyroJerkMag-mean()_mean : numeric [-1..1]
+	fBodyBodyGyroJerkMag-std()_mean : numeric [-1..1]
+	fBodyBodyGyroJerkMag-meanFreq()_mean : numeric [-1..1]
