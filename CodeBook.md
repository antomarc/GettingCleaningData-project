Code book that describes the variables, the data, and any transformations or work  performed to clean up the data. 
Code book for tidy dataset tds.txt

The dataset has 180 rows and 81 columns, corresponding to a format wide with 180 observations of 81 variables.
180 = 30 subjects * 6 activities. All the values are means, aggregated over 30 subjects and 6 activities.

Variables

subject	number integer	1 to 30	ID person wearing a smartphone
activity	Factor words 6 levels "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING"


time-BodyAcc-mean-X	
time-BodyAcc-mean-Y	
time-BodyAcc-mean-Z	

time-BodyAcc-std-X	
time-BodyAcc-std-Y	
time-BodyAcc-std-Z	

time-GravityAcc-mean-X	
time-GravityAcc-mean-Y	
time-GravityAcc-mean-Z	

time-GravityAcc-std-X	
time-GravityAcc-std-Y	
time-GravityAcc-std-Z	

time-BodyAccJerk-mean-X	
time-BodyAccJerk-mean-Y	
time-BodyAccJerk-mean-Z	

time-BodyAccJerk-std-X	
time-BodyAccJerk-std-Y	
time-BodyAccJerk-std-Z	

time-BodyGyro-mean-X	
time-BodyGyro-mean-Y	
time-BodyGyro-mean-Z	

time-BodyGyro-std-X	
time-BodyGyro-std-Y	
time-BodyGyro-std-Z	

time-BodyGyroJerk-mean-X	
time-BodyGyroJerk-mean-Y	
time-BodyGyroJerk-mean-Z	

time-BodyGyroJerk-std-X	
time-BodyGyroJerk-std-Y	
time-BodyGyroJerk-std-Z	

time-BodyAccMag-mean	
time-BodyAccMag-std	

time-GravityAccMag-mean
time-GravityAccMag-std	

time-BodyAccJerkMag-mean	
time-BodyAccJerkMag-std	

time-BodyGyroMag-mean	
time-BodyGyroMag-std	

time-BodyGyroJerkMag-mean	
time-BodyGyroJerkMag-std	


freq-BodyAcc-mean-X	
freq-BodyAcc-mean-Y	
freq-BodyAcc-mean-Z	

freq-BodyAcc-std-X	
freq-BodyAcc-std-Y	
freq-BodyAcc-std-Z	

freq-BodyAcc-meanFreq-X	
freq-BodyAcc-meanFreq-Y	
freq-BodyAcc-meanFreq-Z	

freq-BodyAccJerk-mean-X	
freq-BodyAccJerk-mean-Y	
freq-BodyAccJerk-mean-Z	

freq-BodyAccJerk-std-X	
freq-BodyAccJerk-std-Y	
freq-BodyAccJerk-std-Z	

freq-BodyAccJerk-meanFreq-X	
freq-BodyAccJerk-meanFreq-Y	
freq-BodyAccJerk-meanFreq-Z	

freq-BodyGyro-mean-X	
freq-BodyGyro-mean-Y	
freq-BodyGyro-mean-Z	

freq-BodyGyro-std-X	
freq-BodyGyro-std-Y	
freq-BodyGyro-std-Z	

freq-BodyGyro-meanFreq-X	
freq-BodyGyro-meanFreq-Y	
freq-BodyGyro-meanFreq-Z	

freq-BodyAccMag-mean	
freq-BodyAccMag-std	
freq-BodyAccMag-meanFreq	

freq-BodyBodyAccJerkMag-mean	
freq-BodyBodyAccJerkMag-std	
freq-BodyBodyAccJerkMag-meanFreq	

freq-BodyBodyGyroMag-mean	
freq-BodyBodyGyroMag-std	
freq-BodyBodyGyroMag-meanFreq	

freq-BodyBodyGyroJerkMag-mean	
freq-BodyBodyGyroJerkMag-std	
freq-BodyBodyGyroJerkMag-meanFreq

In these values
time-: time domain variables
freq-: frequency domain variables 
-mean: mean value
-std: standard deviation
-XYZ: denote 3-axial signals in the X, Y and Z directions

The origin of data: raw data

The features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals ('t') were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. ('f' to indicate frequency domain signals). 
These signals were used to estimate variables of the feature vector. 


In tidy dataset all the values are means, aggregated over 30 subjects and 6 activities.



Work  performed to clean up the data

The script "run_analysis.R" does the following. 


(0) Preparing
Raw data are in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip :
download from here, unzip and put the unzipped folder "UCI HAR Dataset" in the working directory. 
The file "run_analysis.R" runs in the working directory: the script processes raw data and the output is the tidy data set "tds.txt".

The folder "UCI HAR Dataset" contains the files README.txt, features_info.txt, features.txt, activity_labels.txt and the folders train and test.
The folder "train" contains the files "subject_train.txt", "X_train.txt", "y_train.txt" and the folder "Inertial Signals"
The folder "test" contains the files "subject_test.txt", "X_test.txt", "y_test.txt" and the folder "Inertial Signals"

The script "run_analysis.R" uses the packages "data.table" and "reshape2"; the script installs them if they are not. 


(1) Merges the training and the test sets to create one data set:

reads raw data "X_train.txt" and "X_test.txt" and merges in X


(2) Extracts only the measurements on the mean and standard deviation for each measurement.

reads "features.txt" and extracts only features with "mean" or "sdt";
extract only measurements with that features, subsetting X, obtaining the dataframe df 


(3) Uses descriptive activity names to name the activities in the data set

reads "y_train.txt" and "y_test.txt" and merges in y (number activity ID)
reads "activity_labels.txt"  ("WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING")
and replace activity number with label


(4) Appropriately labels the data set with descriptive variable names. 
put as names of dataframe df the right features with "mean" or "sdt",
remove brackets, at the beginning replace "t" with "time" and "f" con "freq" (frequency) 


(5) From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.

reads "subject_train.txt" and "subject_test.txt" and merges in "subject" (ID person),

bind columns:  subject, activity, df in a dataset ds
melt ds in format long with variables "subject" and "activity"
and cast the values by the mean as aggregate function over 30 subjects and 6 activities.
So the resulting tidy dataset tds has 30*6=180 rows

Write tds in the text file "tds.txt", without the name of the rows.

