library(reshape2)
library(plyr)


## Downloading and unzipping data files if necessary

## We assume that data file is already downloaded, because task description tells us that
## "The code should have a file run_analysis.R in the main directory that can be run
## as long as the Samsung data is in your working directory"

## if(!file.exists("GCData_PA"))
## {  dir.create("GCData_PA")  }

## file_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## download.file(file_url, destfile="GCData_PA/data.zip", method="internal")

## unzip("GCData_PA/data.zip")


## Reading data from test and train source files
## explicitly assigning sep="" to handle with one and multiply spaces delimiters

test<-read.table("GCData_PA/UCI HAR Dataset/test/X_test.txt", sep="")

train<-read.table("GCData_PA/UCI HAR Dataset/train/X_train.txt", sep="")


## Merging two datasets in one

data<-rbind(train,test)


## Reading features list

feat<-read.table("GCData_PA/UCI HAR Dataset/features.txt", sep="")

## Extracting mean and std features

## The task notation allows different understanding of what features to get from the source file.
## So I take a wider set of features because one can always get rid of unnecessary parameters.
## ..but here I put a strict option in comments:

## mean_std_vars<-feat[grep("(mean\\(\\)|std\\(\\))",feat$V2),]

mean_std_vars<-feat[grep("(mean|std)",feat$V2),]

data<-data[,mean_std_vars[,1]]


## Extracting the list of possible activities

activity_list<-read.table("GCData_PA/UCI HAR Dataset/activity_labels.txt", sep="")


## Extracting activities data for training dataset

activity_train<-read.table("GCData_PA/UCI HAR Dataset/train/y_train.txt", sep="")

## Getting dataset with descriptive activity names
## Using "join" from plyr package instead of "merge"
## so as to preserve the order of activity_train dataset

activity_train<-join(activity_train,activity_list,by="V1",type="left")


## Extracting activities data for test dataset

activity_test<-read.table("GCData_PA/UCI HAR Dataset/test/y_test.txt", sep="")

## Getting dataset with descriptive activity names
## Explicitly forbidding the sorting!
## Otherwise, we couldn't concatenate activities with main data

activity_test<-join(activity_test,activity_list,by="V1",type="left")


## Merging activities datasets into one. Attention!
## The same order of binding in which the main datasets have been merged before.

activity<-rbind(activity_train,activity_test)


## Append activity column to the main dataset

data<-cbind(activity[,2],data)


## Extracting subjects datasets and merging them into one

subjects_train<-read.table("GCData_PA/UCI HAR Dataset/train/subject_train.txt", sep="")

subjects_test<-read.table("GCData_PA/UCI HAR Dataset/test/subject_test.txt", sep="")

subjects<-rbind(subjects_train,subjects_test)


## Appending subjects column to the main dataset

data<-cbind(subjects,data)


## Labelling dataset with variable names: "Subjects", "Activity" and features list

colnames(data)<-c("Subjects","Activity",as.character(mean_std_vars[,2]))


## Cooking the tidy dataset.
## First we need to melt data to get long skinny data set of two IDs, feature names and values

data_melt<-melt(data,id=c("Subjects","Activity"),
            measure.vars=as.character(mean_std_vars[,2]))

## And now we get tidy data set with averages of all features broken by
## subjects and activities

data_tidy<-ddply(data_melt,.(Subjects, Activity, variable), summarize,
             mean=mean(value))


## Writing the resulting dataset to a file

write.table(data_tidy, file="GCData_PA/GCD_result_tidy_dataset.txt", row.name=FALSE)


## Checking the results

data_check <- read.table("GCData_PA/GCD_result_tidy_dataset.txt", header = TRUE)

View(data_check)

