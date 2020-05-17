#Set main working directory
setwd("UCIDataset")

#Import dplyr package
library(dplyr)
#################################################################
#1.Merges the training and the test sets to create one data set.#
#################################################################

#Go to test working directory
setwd("test")

#Read x_test (features)
x_test <-
  read.delim("X_test.txt",
             header = FALSE,
             sep = "",
             strip.white = TRUE)

#Go to train working directory
setwd("../train")

#read x_train (features)
x_train <-
  read.delim(
    "X_train.txt",
    header = FALSE,
    sep = "",
    strip.white = TRUE
  )

#Add a column to specify dataset source
x_test <- mutate(x_test, type = "test")
x_train <- mutate(x_train, type = "train")

#Bind datasets in new one
features_dataset <- bind_rows(x_test, x_train)

rm(x_test)
rm(x_train)

###########################################################################################
#2.Extracts only the measurements on the mean and standard deviation for each measurement.#
###########################################################################################
setwd("../")

#Read features names from file
features <-
  read.delim(
    "features.txt",
    header = FALSE,
    sep = "",
    strip.white = TRUE
  )

#Add column type (just to preserve the diversity between test and train data)
r_temp <- data.frame(V1 = as.integer(562), V2 = "type")
features <- rbind(features, r_temp)

#Set column names
colnames(features_dataset) <- features$V2

rm(features)
rm(r_temp)

#Create selection vector for mean and standard deviation variables
selection <- grep("mean|std", names(features_dataset))

#Apply selection
means_and_stddevs <- features_dataset[selection]
rm(selection)

##########################################################################
#3.Uses descriptive activity names to name the activities in the data set#
##########################################################################
setwd("test")
#Read y_test (label)
y_test <- read.delim("y_test.txt", header=FALSE,sep = "", strip.white=TRUE)

setwd("../train")
#Read y_train (label)
y_train <- read.delim("y_train.txt", header=FALSE,sep = "", strip.white=TRUE)

setwd("../")
#Read activity labels
activity_labels <- read.delim("activity_labels.txt", header=FALSE,sep = "", strip.white=TRUE)

#Bind datasets in new one
label_ids <- bind_rows(y_test, y_train)

rm(y_test)
rm(y_train)

#Set column names before merge
colnames(activity_labels) <- c("id","activity")
colnames(label_ids) <- c("id")

#Merge activity dataset with description
labels <- merge(label_ids, activity_labels)

rm(activity_labels)
rm(label_ids)

#Bind activity labels with feature dataset
features_dataset_with_activity_names <- bind_cols(features_dataset, labels)

rm(labels)
######################################################################
#4.Appropriately labels the data set with descriptive variable names.#
######################################################################
# IN ORDER TO ACHIEVE POINT 2 BY USING REGEX I'VE JUST LABELED THE   #
# DATASET WITH DESCRIPTIVE VARIABLE NAMES.                           #
######################################################################

############################################################################
#5.From the data set in step 4, creates a second, independent tidy data set# 
#with the average of each variable for each activity and each subject.     #
############################################################################

setwd("test")
#Read subject_test  (subject)
subject_test <- read.delim("subject_test.txt", header=FALSE,sep = "", strip.white=TRUE)

setwd("../train")
#Read subject_train (subject)
subject_train <- read.delim("subject_train.txt", header=FALSE,sep = "", strip.white=TRUE)

#Bind datasets in new one
subjects <- bind_rows(subject_test, subject_train)
colnames(subjects) <- c("subject")

rm(subject_test)
rm(subject_train)

#Bind subjects to features dataset (with previously added activities)
features_dataset_with_activity_names_and_subjects <- bind_cols(features_dataset_with_activity_names, subjects)

rm(subjects)

#Create grouping criteria
by_activity_and_subject <- 
  group_by(features_dataset_with_activity_names_and_subjects, activity, subject)

#Summarise the dataset
summarised_dataset <- summarise_all(by_activity_and_subject, funs(mean))

setwd("../../")

write.table(features_dataset_with_activity_names_and_subjects, row.name=FALSE)