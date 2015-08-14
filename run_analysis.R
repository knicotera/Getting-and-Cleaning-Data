setwd('/Users/knicoter/GettingAndCleaningData/UCI HAR Dataset/');

## 1. Merge the training and the test sets to create one data set

# Read in activity type and features data
features <- read.table('./features.txt')
activityType <- read.table('./activity_labels.txt')
colnames(activityType) <- c('activityId','activityType') #assign column names

# Read in training data
xTrain <- read.table('./train/x_train.txt')
yTrain <- read.table('./train/y_train.txt')
subjectTrain <- read.table('./train/subject_train.txt')

# Assign  column names
colnames(xTrain) <- features[,2] 
colnames(yTrain) <- "activityId" 
colnames(subjectTrain) <- "subjectId" 

training <- cbind(yTrain, subjectTrain, xTrain) #merge all training data

# Read in test data
xTest <- read.table('./test/x_test.txt')
yTest <- read.table('./test/y_test.txt')
subjectTest <- read.table('./test/subject_test.txt')

# Assign  column names
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"
colnames(subjectTest) <- "subjectId"

test <- cbind(yTest, subjectTest, xTest) #merge all test data
 
data <- rbind(training, test) #combine training data and test data
colNames  = colnames(data); #store all column names

## 2. Extract only the measurements on the mean and standard deviation 
## for each measurement. 

extract = (grepl("activity..",colNames) | grepl("subject..",colNames) 
           | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) 
           & !grepl("mean..-",colNames) | grepl("-std..",colNames) 
           & !grepl("-std()..-",colNames))

data <- data[extract==TRUE]; # subset data to keep only needed columns

## 3. Use descriptive activity names to name the activities in the data set

# Merge data set with acitivityType data
data <- merge(data, activityType, by='activityId', all.x=TRUE);
colNames <- colnames(data) # update colNames

## 4. Appropriately label the data set with descriptive variable names. 

# Clean up variable names
for (i in 1:length(colNames)) 
{
    colNames[i] <- gsub("\\()","",colNames[i])
    colNames[i] <- gsub("-std$","StdDev",colNames[i])
    colNames[i] <- gsub("-mean","Mean",colNames[i])
    colNames[i] <- gsub("^(t)","Time",colNames[i])
    colNames[i] <- gsub("^(f)","Freq",colNames[i])
    colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] <- gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(data) <- colNames 

## 5. Create an independent tidy data set with the average of each variable 
## for each activity and each subject. 

data_minus_act <- data[,names(data) != 'activityType']
tidy <- aggregate(data_minus_act[,names(data_minus_act) 
                != c('activityId','subjectId')], 
                by=list(activityId=data_minus_act$activityId, 
                        subjectId = data_minus_act$subjectId), mean)

# Merge in descriptive acitvity names
tidy <- merge(tidy, activityType, by='activityId', all.x=TRUE)

# Reorder data
n<-ncol(tidy)
m <- n-1
tidy <- tidy[,c(1,n,3:m)]

#Export tidy data
write.table(tidy, './tidyData.txt', row.names=FALSE, sep=',')
