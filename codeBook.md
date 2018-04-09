
## The Project ##

Clean Data and make it tidy

## The Expermint Background ##

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain


For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## The Raw Data ## 
The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'subject_train.txt':  subjects number.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'subject_test.txt':  subjects number

## Data Processing ## 
The dataframe was created by joining the different text files
The Training/ Test set was joined with the Training/ Test labels and subjects numbers, then column names were added by using the feature file. 

The labels were factorized to make it more descriptive. 
it includes: 
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

and the are the levels of the factor column for the activities. 
The dataset was then indexed to only include the mean() and std() labels
Then the data was narrowed down by tidyr and the mean for each subject and each activity was added by the use of two different methods, summarize_all and dcast, creating the same output. 

The output dataset included in castDF1.txt is 

a tibble with 180x81 
the variables are 
subjects 
activity     
`tBodyAcc-mean()-… 
`tBodyAcc-mean()-… 
`tBodyAcc-mean()-… 
`tBodyAcc-std()… 
`tBodyAcc-std()… 
`tBodyAcc-std()..........

castDF.txt contains the narrow dataframe, which is a tibble of size:  813,621 x 4
with the variables: 
 subjects (int) : the number of subjects who participated in the expermint. 
 activity (factor):  the activity that was recorded using the sensors
 variable(fct): the different labels for different features, including only the mean() and std() features and signals.
 mean(dbl): the mean value.



