

## INDEX
## 1. Data import
## 2. Data manipulation
## 3. Task 1: Merges the training and the test sets to create one data set.
## 4. Task 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
## 5. Task 3: Uses descriptive activity names to name the activities in the data set
## 6. Task 4: Appropriately labels the data set with descriptive variable names. 
## 7. Task 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## 8. Exporting data


##########################################################################################
#1. Data import
##########################################################################################

#Check if UCI HAR Datasetdirectory is present/missing in current Working Directory
if (!file.exists("UCI HAR Dataset")) {
      print("KO: Data direcotry UCI HAR Dataset is missing in current Working Direcotry",quote=FALSE)
      print("Please consider set a different Working Directory",quote=FALSE)
} else {print("OK: Data direcotry UCI HAR Dataset is present in current Working Direcotry",quote=FALSE)}


#Impoting 'activity_labels.txt' (this file links the class labels with their activity name, will be useful later).
if ( ! file.exists("./UCI HAR Dataset/activity_labels.txt") ) {
      print("Cannot find activity_labels.txt in ./UCI HAR Dataset/",quote=FALSE)
} else {
      activity_labels <-read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", quote = "\"'",
                  colClasses = c("integer","character"),col.names=c("class_labels","activity_name"))
                }


#Impoting 'features.txt' (this file contains a list of all 561 features, will be useful later).
if ( ! file.exists("./UCI HAR Dataset/features.txt") ) {
      print("Cannot find features.txt in ./UCI HAR Dataset/",quote=FALSE)
} else {
      features <-read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = "", quote = "\"'",
                                   colClasses = c("factor","character"),col.names=c("class_feature","feature_name"))
      }


#Impoting Training set
if ( ! file.exists("./UCI HAR Dataset/train/X_train.txt") ) {
      print("Cannot find X_train.txt in ./UCI HAR Dataset/train/",quote=FALSE)
} else {
      training_set <-read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", quote = "\"'")
      }


#Impoting Training labels
if ( ! file.exists("./UCI HAR Dataset/train/y_train.txt") ) {
      print("Cannot find y_train.txt in ./UCI HAR Dataset/train/",quote=FALSE)
} else {
      training_labels <-read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", quote = "\"'")
      }


#Impoting Subject associated to Training Set
if ( ! file.exists("./UCI HAR Dataset/train/subject_train.txt") ) {
      print("Cannot find subject_train.txt in ./UCI HAR Dataset/train/",quote=FALSE)
} else {
      train_subject <-read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", quote = "\"'")
      }



#Impoting Test set
if ( ! file.exists("./UCI HAR Dataset/test/X_test.txt") ) {
      print("Cannot find X_train.txt in ./UCI HAR Dataset/test/",quote=FALSE)
} else {
      test_set <-read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", quote = "\"'")
      }


#Impoting Test labels
if ( ! file.exists("./UCI HAR Dataset/test/y_test.txt") ) {
      print("Cannot find y_train.txt in ./UCI HAR Dataset/test/",quote=FALSE)
} else {
      test_labels <-read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", quote = "\"'")
      }


#Impoting Subject associated to Test Set
if ( ! file.exists("./UCI HAR Dataset/test/subject_test.txt") ) {
      print("Cannot find subject_train.txt in ./UCI HAR Dataset/test/",quote=FALSE)
} else {
      test_subject <-read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", quote = "\"'")
      }



##########################################################################################
#2. Data manipulation
##########################################################################################

#Converting all imported data.frames in data.tables. Data.table package is easier and faster,
# I will use data.table package for easy computation. 

#Requiring data.table package
if(require("data.table")){
      print("data.table is loaded correctly")
} else {
      print("trying to install data.table")
      install.packages("data.table")
      if(require(data.table)){
            print("data.table installed and loaded")
      } else {
            stop("could not install data.table")
      }
}


#Converting data.frames in data.tables
#This could have be already done when datasets were imported.
#I put this year in order to let the code easy to read.
activity_labels <- data.table(activity_labels)
features <- data.table(features)
training_set <- data.table(training_set)
training_labels <- data.table(training_labels)
train_subject <- data.table(train_subject)
test_set <- data.table(test_set)
test_labels <- data.table(test_labels)
test_subject <- data.table(test_subject)


#Adding feature names to Training and Test Set columns
features_vector <- features$feature_name
setnames(training_set,names(training_set),features_vector)
setnames(test_set,names(test_set),features_vector)
rm(features_vector)

#Adding training_labels to Training Set by column binding
training_set <- cbind(training_labels,training_set)
setnames(training_set,"V1","class_labels")
rm(training_labels)


#Adding test_labels to Test Set by column binding
test_set <- cbind(test_labels,test_set)
setnames(test_set,"V1","class_labels")
rm(test_labels)


#Adding train_subject to Training Set by column binding
training_set <- cbind(train_subject,training_set)
setnames(training_set,"V1","subject")
rm(train_subject)


#Adding test_subject to Test Set by column binding
test_set <- cbind(test_subject,test_set)
setnames(test_set,"V1","subject")
rm(test_subject)


##########################################################################################
#3. Task 1: Merges the training and the test sets to create one data set.
##########################################################################################

#Merging the training and the test sets to create one data set by row binding
full_set <- rbind(training_set,test_set)


#Checking Number of Instances
if ( nrow(full_set)==10299 ) {
      print("well Done! 10299 rows in full data set. Removing Training and Test data sets.",quote=FALSE)
      rm(training_set)
      rm(test_set)
} else {
      print("Ooops, something went wrong: it seems some instances are missing",quote=FALSE)
}
 

##########################################################################################
#4. Task 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
##########################################################################################

#Selecting only the features on the mean and standard deviation
features_subset <- features[ (grepl('[\\-]+(mean|std)[\\(]+', feature_name ,ignore.case=TRUE))]$feature_name
measurements_subset <- full_set[,c("subject","class_labels",features_subset), with=FALSE ]
rm(full_set)
rm(features)

#Please note I decided to not include "meanFreq()" variables [Weighted average of the frequency components to obtain a mean frequency]
# and any other variable including the word "mean" (such as "angle()" variables)



##########################################################################################
# 5. Task 3: Uses descriptive activity names to name the activities in the data set
##########################################################################################

#Let's JOIN activity_labels dataset, whichc links the class labels (1,2,3,4,5,6) with their activity name (WALKING, WALKING_UPSTAIRS, 
#WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING), to the measurements_subset.
#Before joining we need to set the same key to the two datasets we want to join
setkey(activity_labels,class_labels)
setkey(measurements_subset,class_labels)
measurements_subset <- activity_labels[measurements_subset] #this is a data.table feature
rm(activity_labels)


##########################################################################################
# 6. Task 4: Appropriately labels the data set with descriptive variable names. 
##########################################################################################

#Column names already contain feature names (done above in data manipultion section).
#However they do contain characters that are illegal in R names (i.e. dashes and brackets): there are R functions that will reject working with those names.
#Removing dashes and brackets from feature names subset
syntactically_valid_names <- make.names(features_subset,unique = TRUE)
setnames(measurements_subset,features_subset,syntactically_valid_names)
rm(syntactically_valid_names)
rm(features_subset)

#Please note that there are still some feature names that seems to be wrong, 
# for example those containing the word "Body" twice. 
# Let's remove "body" repetition as well as multiple punctuation.
measurements_subset_names <- names(measurements_subset)
modified_names <- gsub("BodyBody","Body",measurements_subset_names, ignore.case = TRUE)
modified_names <- gsub("\\.\\.\\.","\\.",modified_names, ignore.case = TRUE)
modified_names <- gsub("\\.\\.","\\.",modified_names, ignore.case = TRUE)
setnames(measurements_subset,measurements_subset_names,modified_names)
rm(modified_names)
rm(measurements_subset_names)


##########################################################################################
# 7. Task 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##########################################################################################

#Removing class_label column, we do not need it anymore
measurements_subset[,class_labels:=NULL]

#Requiring reshape2 package
if(require("reshape2")){
      print("reshape2 is loaded correctly")
} else {
      print("trying to install reshape2")
      install.packages("reshape2")
      if(require(reshape2)){
            print("reshape2 installed and loaded")
      } else {
            stop("could not install reshape2")
      }
}

#Melting...
molten_data <- melt(measurements_subset,id=c("activity_name","subject"))
rm(measurements_subset)

#...and casting aggregating by mean.
tidy_data_set <- dcast(molten_data, subject + activity_name  ~ ...,mean)
rm(molten_data)

##########################################################################################
## 8. Exporting data
##########################################################################################
write.table(tidy_data_set, file = "./tidy_data_set.txt", quote = FALSE, sep = ";",
            col.names = TRUE, row.names = FALSE)


#That's all! :)





