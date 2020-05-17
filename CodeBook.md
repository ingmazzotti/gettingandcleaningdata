---
title: "CodeBook.md"
author: "Marcello Mazzotti"
date: "17/5/2020"
output: html_document
---


## Input data

All the input data are in text format with values separated by one or more white
spaces and newlines separating observations.
All the files are without header and have been read with the function 
**read.delim**:

*read.delim("filename.txt", header = FALSE, sep = "", strip.white = TRUE)*

## Datasets Structure and Transformation

### Test and Train Dataset
*X_test.txt*
*X_train.txt*

Test and Train data are two omogeneous sets of features binded using the dplyr
function **bind_rows**. The result is the complete dataset with all the 
features. In order to preserve the origin of the data, I've added a *type* 
column with the values "test" and "train".

**feature_dataset** is the data.frame containing train and test data together.

### Feature Descriptions
*features.txt*

Features file contains the names of our features variables.
I've read the file and set his values as features_dataset variables names.

### Means and Standard Deviations
In order to extract mean and standard deviation values i've used the **grep**
function to create a selection vector i've applied to features_dataset.

**means_and_stddevs** is the data.frame containing just means and standard
deviations variables

### Activity Names
*y_test.txt*
*y_train.txt*
*activity_labels.txt*

Test and Train activity datasets contains just the activity identifier 
corresponding to the observations.
Activity Labels contains the descriptions of every activity.

After binding test and train activity data i've merged the resulting activity 
data with the descriptions. Finally i've have binded descriptive activity data 
with feature_dataset using **bind_cols** function.

**features_dataset_with_activity_names** is the data.frame containing features 
data and descriptive activity data

### Subjects
*subject_test.txt*
*subject_train.txt*

Test and Train subject datasets contains just the subject corresponding 
to the observations.
After binding test and train subjects data i've have binded the result 
with features_dataset_with_activity_names using **bind_cols** function.

**features_dataset_with_activity_names_and_subjects** is the data.frame
containing features data, descriptive activity data and subcet data.

### Summarizing

In order to summarize data by activity and subject and obtain mean values for 
every variable in dataset i've used the function **group_by** and the 
function **summarise_all**

**summarised_dataset** contains summarized values