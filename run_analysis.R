## find out working database
getwd()

## save file to class folder
## set working database to saved file
setwd("~/Documents/Coursera Class/UCI HAR Dataset")

## 1. Merges the training and test sets to create on data set
## Reading in data from file
features     = read.table('./features.txt',header=FALSE)
activityType = read.table('./activity_labels.txt',header=FALSE)
subjectTrain = read.table('./train/subject_train.txt',header=FALSE)
xTrain       = read.table('./train/x_train.txt',header=FALSE)
yTrain       = read.table('./train/y_train.txt',header=FALSE)

## Assigning names to the columns from imported data
colnames(activityType)  = c('activityId','activityType')
colnames(subjectTrain)  = "subjectId"
colnames(xTrain)        = features[,2] 
colnames(yTrain)        = "activityId"

##Final Training set(Merge yTrain, subjectTrain, xTrain)
trainingData = cbind( yTrain, subjectTrain, xTrain)

## Reading in the test data
subjectTest= read.table('./test/subject_test.txt', header=FALSE)
xTest=read.table('./test/X_test.txt', header=FALSE)
yTest=read.table('./test/y_test.txt', header=FALSE)

##Assign column names to imported test data
colnames(subjectTest)= "subjectId"
colnames(xTest)= features[,2]
colnames(yTest)= "activityId"

## Final test set(Merging subjectTest,xTest,yTest data)
testData= cbind(yTest,subjectTest,xTest)

##Combine training data and test data to create a final data set
finalData= rbind(trainingData, testData)

##Create a vector from the finalData for column names.
colNames= colnames(finalData)

## 2. Extracts only the measurements on the mean and standard deviation
## each measurement.
## Create a logicalVector that contains True values for the ID, mean() and stddev()
## columns and False for others
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

## Subset finalData table based on the logicalVector to keep only desired columns
finalData = finalData[logicalVector==TRUE]

## 3. Uses descriptive activity names to name the activities in the data set.
## Merge finalData set with the activityType table to include descriptive activity names.
finalData= merge(finalData,activityType, by='activityId', all.x=TRUE)

##Updating the colNames to include new column names
colNames= colnames(finalData)

## 4. Appropriately labels the data set with descriptive variable names.
## Tidying up variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

## Reassigning new descriptive column names to finalData set
colnames(finalData)= colNames

## 5. From the data set in step 4, creates a second, independent tidy 
## data set with the average of each variable for each activity and each subject.
## Create a new table, finalDataNoActivityType without the activityType column.
finalDataNoActivityType = finalData [,names(finalData) != 'activityType']

##Summarizing finalDataNoActivityType table to include only the mean of each variable 
##for each activity and each subject
tidyData= aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId', 'subjectId')], by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean)

## Merge the tidyData with activityType to include descriptive activity names.
tidyData= merge(tidyData,activityType, by='activityId',all.x=TRUE)

## Export the tidyData set
write.table(tidyData, './tidyData.txt', row.names=TRUE, sep='\t')
