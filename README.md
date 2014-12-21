### Readme for

## Getting and Cleaning Data Programming Assignment

---

The basis of our analysis is Human Activity Recognition Using Smartphones experiment.
There were 30 volunteers, from 19 to 48 years old. They performed 6 kinds of activity wearing Samsung Galaxy S II smartphones on their waists.
The data has been collected from accelerometer and gyroscope of those phones during the volunteers' activity. Parameters (features) were collected with frequency of 50 Hz. At the same time, the volunteers' activity has been recorded by video camera. So we know the real kind of activity at every moment of experiment.
After collecting raw data, there was a filtering and preprocessing routines performed. The resulting dataset was split into two pieces - test and training datasets.

Further details about the experiment are available in README.txt file provided with source data.

### Our goal

So we have two datasets with values of 561 features, list of activities, additional datasets with subjects(volunteers) and activities data for each observation during the experiment.

Our goal is to process data to get tidy dataset with average values of measurements on the mean and standard deviation for each measurement, each subject and each kind of activity.

### Script

* First of all we extract the main data from two datasets - "test" and "train" - and gather them into one - "data".

* Then we read features list and filter it according to the task wording. After that, we exclude excess variables from the "data" dataset.

* Now we extract two activity datasets ("test" and "train") and add descriptive names to every observation. After that, we merge "test" and "train" activities datasets into one - "activity" - and append the respective column to the main dataset "data".

* Then we similarly extract and merge two subjects datasets and append the respective column to the main dataset.

* Then we give descriptive names for all variables in the main dataset.
After that, we use melt() function on "data" assigning "Subjects" and "Activity" columns as IDs and the rest of the features as measure.vars. Thus we get the "data_melt" dataset.

* And now we summarize data by computing means for each feature ("variable") for every combination of volunteer ("Subjects") and every kind of activity.

* Following this, we save the resulting tidy dataset "data_tidy" to the txt file "GCD_result_tidy_dataset.txt"

### Checking

If you download my resulting file, here is the R code for checking it:
```r
data_check <- read.table(file_path, header = TRUE)
View(data_check)
```
