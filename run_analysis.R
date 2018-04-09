
## Getting And Cleaning Data Course Project. 



## the libraries that will be used in this project

library(dplyr)
library(tidyr)
library(plyr)
library(reshape2)


## read all data from text files that are already downloaded and 
## unzipped and availble in the refrenced directroy below


testfolder <- "./Project1/UCI_HAR_Dataset/test/"

DFtest <-  read.table(paste(testfolder, "X_test.txt", sep=''))
activ_test <-  read.table(paste(testfolder, "y_test.txt", sep=''))
subject_test <-  read.table(paste(testfolder, "subject_test.txt", sep=''))

trainfolder <- "./Project1/UCI_HAR_Dataset/train/"

DFtrain <-  read.table(paste(trainfolder, "X_train.txt", sep=''))
activ_train <-  read.table(paste(trainfolder, "y_train.txt", sep=''))
subject_train <-  read.table(paste(trainfolder, "subject_train.txt", sep=''))

## read feauters list and activity list

mainfolder <- "./Project1/UCI_HAR_Dataset/"

feauters <-  read.table(paste(mainfolder, "features.txt", sep=''))
activ_names <-  read.table(paste(mainfolder, "activity_labels.txt", sep=''))
## add column names to the train and test dataframes

colnames(DFtest) <- feauters$V2

colnames(DFtrain) <- feauters$V2






## bind columns of the different text files into one Data Frame for Train and Test datasets. 
testDF <- cbind (subject_test, activ_test, DFtest)
trainDF <- cbind (subject_train, activ_train, DFtrain)
## change activity numbers into a more descreptive labels

## need to change the default column values created while reading the text file

## make the column names unique in case there are duplicates (i.e. two columns are named  V1)
names(testDF) <- make.unique(names(testDF))
## rename the activity name
testDF<- dplyr::rename(testDF, subjects = V1, activity= V1.1)
names(trainDF) <- make.unique(names(trainDF))
trainDF <- dplyr::rename(trainDF, subjects = V1, activity= V1.1)
## Subset the Data Frame to include the mean and STD variables only, by using regular expressions
## and a subset function or by indexing [ ] 
testcol<- grep("-mean|-std", names(testDF), value = TRUE)
testDF<- testDF[,c("subjects", "activity", testcol)]

traincol<- grep("-mean|-std", names(testDF), value = TRUE)
trainDF<- trainDF[,c("subjects", "activity", traincol)]

## Using factor function, the labels will be factors that represent the activity number


testDF$activity <- factor(testDF$activity, labels = as.character(activ_names$V2))

trainDF$activity <- factor(trainDF$activity, labels = as.character(activ_names$V2))


## merge the two Data Frames by merging the subjects columns from both DFs

mergedDF <- tbl_df(join(testDF, trainDF, by=  "subjects", type= "full"))

## melt data to make the wide mergedDF into a narrow one

moltenDF <- tbl_df(melt(mergedDF, id = c("subjects", "activity"),  measure.vars = names(mergedDF)[3:81]))

## the separate function is used to separate the column variable into its constituents, This enables
## more control over the dataframe
moltenDF <- separate(moltenDF, col = "variable", into = c("feature", "signal", "angle"), sep = "-") 

## after separating the variable column, The meanFreq() signal can be filtered out

moltenDF <- tbl_df(filter(moltenDF, signal != "meanFreq()"))


## to make the final Data Frame, using the summarise_all function and group_by to find the mean for each subject for each activity
## this will create a narrow DF which is Tidy 


castDF <- tbl_df(dcast(moltenDF,  subjects + activity ~ feature + signal+ angle, mean))


##  a melt function would create a  narrow table

castDF <- melt(castDF, id = c("subjects", "activity"),  measure.vars = names(castDF)[3:81])


castDF <- dplyr::rename(castDF, mean = value)

write.table(castDF, "/Project1", row.name=FALSE)
############################### Alternative Solution   ###################################
## an alternative way to summarise the DataFrame is the use of summarise_all function, This will create a narrow dataFrame
finalDF<- moltenDF %>% group_by(subjects, activity, feature ,signal,angle) %>% summarise_all(mean)
finalDF <- dplyr::rename(finalDF, mean = value)







