
# Getting and Cleaning Data  / Course Project

Files in this Repository refer to the Course Project of Getting and Cleaning Data from Coursera.

You can find:

* A R script (run_analysis.R) which creates a tidy data set starting from raw data (supposed to be in your working Directory). Raw data is from Human Activity Recognition Using Smartphones Data Set.
* A codebook
* This README.md file


__The script has been designed and tested for working properly on a Windows system.__


You will not find:

* Raw data, which can be downloaded from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/ 



## Assumption


As per assignment request, __the script can be run as long as the Raw data is in your working directory.__



## Raw data description: Human Activity Recognition Using Smartphones Data Set 


__Abstract__:
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
 
__Source__:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws 

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

__For more info on original data set, please have a look at the README.txt inlcuded in the data set directory.__:


## Script Overview

This script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


## Script step by step

The script is composed of 8 sections:

1. Data import
2. Data manipulation
3. Task 1: Merges the training and the test sets to create one data set.
4. Task 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
5. Task 3: Uses descriptive activity names to name the activities in the data set
6. Task 4: Appropriately labels the data set with descriptive variable names. 
7. Task 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
8. Exporting data


Please find below a short description for each section.
More details in the script lines.

### Section 1 - Data import
The script starts importing all txt files necessary in order to get a tidy data set as per assignment.
All imports are made through read.table function.

### Section 2 - Data manipulation
I decided to convert all data frames in data tables, since data.table object are easier to manipulate (subsetting, updating columns, etc).

Then I added joined all kind of available info (subject ids, feature names, activity labels) to the training and test data set.


### Section 3 - Task 1: Merges the training and the test sets to create one data set.

The merge is accomplished via a row binding (rbind function).



### Section 4 - Task 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

The measurements on the mean and standard deviation have been selected using grepl function in order to apply regular expressions to feature names.



### Section 5 - Task 3: Uses descriptive activity names to name the activities in the data set

I have joined activity_labels dataset, which links the class labels (1,2,3,4,5,6) with their activity name (WALKING, WALKING_UPSTAIRS, #WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING), to the measurements_subset.
Join is performed thanks to data.table package functionalities. 


### Section 6 - Task 4: Appropriately labels the data set with descriptive variable names. 

Allthough column names already contain feature names (done above in data manipulation section), they do contain characters that are illegal in R names (i.e. dashes and brackets): there are R functions that will reject working with those names.
In ordert to remove dashes and brackets from feature names subset, make.names functions has been applied.

Then I have decided to remove multiple punctuations inserted by make.names function and misspelling in the original feature names (for example, in some features the word "body" is repeated twice).

### Section 7 - Task 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

This task has been accomplished thanks to melt and dcast function from reshape2 package.


### Section 8 - Exporting data

This is the very end of the script: the tidy data set is written to a txt file.

