# Getting-and-Cleaning-Data-Project
Getting and Cleaning Data Project

This is the project for the Getting and Cleaning Data course. The R script, run_analysis.R, does the following:

Sets working database
Loads the activity and feature info
Loads both the training and test datasets, keeping the columns which reflect a mean or standard deviation
Loads the activity data and subject data for each dataset, and then merges those columns with the dataset
It merges the two datasets
Converts the activity and subject columns into factors
Creates a tidy dataset that consists of the mean value of each variable for each subject and activity pair.
The end result is shown in the file tidy.txt.
