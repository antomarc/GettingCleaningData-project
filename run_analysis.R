## GET_DATA assignment project 
## You should create one R script called run_analysis.R that does the following. 
## (1) Merges the training and the test sets to create one data set.
## (2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## (3) Uses descriptive activity names to name the activities in the data set
## (4) Appropriately labels the data set with descriptive variable names. 
## (5) From the data set in step 4, creates a second, independent tidy data set 
##     with the average of each variable for each activity and each subject.



# (0) Preparing  In working directory "run_analysis.R" and "UCI HAR Dataset" 
# getwd() 
# setwd("GettingCleaningData-project") 
# dir()  # "run_analysis.R" "UCI HAR Dataset"
# dir("./UCI HAR Dataset") # unzipped folder: "activity_labels.txt" "features.txt" ... "test" "train"


if (!require("data.table")){install.packages("data.table")}
if (!require("reshape2")){install.packages("reshape2")}
require("data.table")
require("reshape2")



## (1) Merges the training and the test sets to create one data set.

X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")  #7352 obs. of  561 variables
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")  #2947 obs. of 561 var.
X<-rbind(X_train,X_test)  #10299 obs. of 561 var.



## (2) Extracts only the measurements on the mean and standard deviation for each measurement.

features<-read.table("./UCI HAR Dataset/features.txt")[,2] 
#561 elements: tBodyAcc-mean()-X  tBodyAcc-mean()-Y ...
# remove brackets:
features<-gsub("[()]","",features)

extract <- grepl("mean|std", features) #561 TRUE FALSE ...
mean_std <- grep("mean|std", features) #79 indexes
df<-X[,mean_std] #10299 obs. of 79 var.



## (3) Uses descriptive activity names to name the activities in the data set

y_train<-read.table("./UCI HAR Dataset/train/y_train.txt") #7352 obs. of  1 var. (int 1:6)
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")  #2947 obs. of 1 var. (int 1:6)
y<-rbind(y_train,y_test) #10299 obs. of 1 var. (int 1:6)

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")[,2]  
#6 elements: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING

# replace activity number with label:
y[,1]<-activity_labels[y[,1]]  #10299 obs. of 1 var. ("LAYING", "SITTING", ...)
names(y)<-"activity"



## (4) Appropriately labels the data set with descriptive variable names. 

names(df)<-features[mean_std]
# remove brackets:
names(df)<-gsub("[()]","",names(df))
# "tBodyAcc-mean-X" "tBodyAcc-mean-Y" "tBodyAcc-mean-Z" "tBodyAcc-std-X"  "tBodyAcc-std-Y" ...
names(df)<-gsub("^t","time-",names(df))
names(df)<-gsub("^f","freq-",names(df))



## (5) From the data set in step 4, creates a second, independent tidy data set 
##     with the average of each variable for each activity and each subject.

subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")  #7352 obs. of 1 var. (int 1:30), 21 distinct values 
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")  #2947 obs. of 1 var. (int 1:30), 9 distinct values
subject<-rbind(subject_train,subject_test) #10299 obs. of 1 var. (int 1:30)
names(subject)<-"subject"

# bind columns:  subject activity df
ds<-cbind(as.data.frame(subject),y,df)  #10299 obs. of  81 var.

dsl <- melt(ds,id.vars=c("subject","activity")) #format long  813621 obs. of 4 var.
tds <- dcast(dsl,subject+activity~variable,fun.aggregate=mean)  #format wide 180 obs. of 81 var.
#tds is the tidy data set  (180 = 30 subjects * 6 activities)

write.table(tds, file = "./tds.txt",row.names=FALSE)

