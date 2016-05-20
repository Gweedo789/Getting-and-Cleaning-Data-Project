# Getting-and-Cleaning-Data-Project
Getting and Cleaning Data Project

This is the project for the Getting and Cleaning Data course. 
The R script, run_analysis.R, does the following:

1. Sets working database.
2. Loads the activity and feature info.
3. Loads both the training and test datasets, keeping the columns which reflect a mean or standard deviation.
4. Loads the activity data and subject data for each dataset, and then merges those columns with the dataset.
5. Merges the two datasets.
6. Converts the activity and subject columns into factors.
7. Creates a tidy dataset that consists of the mean value of each variable for each subject and activity pair.

The result is the file tidy.txt.
