# Getting-and-Cleaning-Data-Course-Project

This document describes all Files in this project



###Files:
* **./data**  
    This directory hold all Raw Data used for the creation of the Summary-Dataset. If it is not present, it will be generated by the run_analysis.R.
* **./README.md**  
    This document.
* **./codeBook.md**  
    This document describes contains two sections:  
    + Study design  
    This section explains where the Raw-Data comes from and whitch steps are performed to get the Summary-Dataset (summary_data.csv)
    + Code book  
    This Section contains all variables used summary_data.csv
* **./run_analysis.R**  
    This file contains the R-Script to create the summary_data.csv file.
* **./summary_data.txt**  
    This is the result-set. It contains the average of each variable for each activity and each subject.
    
    
###run_analysis.R      
This section explains where the Raw-Data comes from and whitch steps are performed to get the Summary-Dataset (summary_data.txt)

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
		+ The traindata is available in the file "data/UCI HAR Dataset/train/X_train.txt"
		+ The testdata is available in the file "data/UCI HAR Dataset/test/X_test.txt"
		+ The files are read with the fread function from the "data.table" package
			+ To select just the needed columns, the select argument is set to the "colNumbersToKeep" Vector
			+ The col.names argument is set to the "feature" vector to add Column names.
	+  Read the "subjects" for the train and test data
		+ The subjects for the traindata is available in the file "data/UCI HAR Dataset/train/subject_train.txt"
		+ The subjects for the testdata is available in the file "data/UCI HAR Dataset/test/subject_test.txt"
	+ Merge the Data
		+ Row-Bind the train and test activitys to make a union -> "y Data"
		+ Row-Bind the train and test Data to make a union -> "x Data"
		+ Row-Bind the train and test subjects to make a union -> "subject Data"
		+ Column-Bind "subject Data", "y Data"  and "x Data" to create  a single Dataset
 	+ The "factor" function is used to encode the activity numbers. The labels for the levels are stored in the "activity_lables" vector
* **Create a second Data set with the average of each variable**
	+ Calculate the Average of each Variable grouped by subject and activity
	+ Append "_mean" to each column name to name the new Variables
	+ Save the the result Dataset as csv-file named "summary_data.txt" 
 

		
