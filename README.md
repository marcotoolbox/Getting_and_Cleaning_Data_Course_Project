
# Getting and Cleaning Data  / Course Project

Files in this Repository refer to the Course Project of Getting and Cleaning Data from Coursera.

You can find:

* A R script run_analysis.R which creates a tidy data set starting from raw data (supposed to be in your working Directory). Raw data are from Human Activity Recognition Using Smartphones Data Set.
* A codebook
* This README.md file

__The script has been designed and tested for working properly on a Windows system.__


You will not find:

* Raw data, which can be downloaded from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/ 



## Assunmption

__As per assignment request, the script can be run as long as the Samsung data is in your working directory.__



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

__For more info on original data set, please have a look at the README.txt inlcuded in the data set.__:


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

This script accomplishes the following(more detail can be seen in the actual comments to run_analysis.R):
    * Text
    * More text
    * Yet more text
    * And another one
    * And another one
    * Start of an embedded list:
      * embedded list item 1
      * embedded list item 2
	  
	  
	      - how I processed the data
        - what assumptions I made
        - why I did things a certain way
        - who and where did I obtain original data