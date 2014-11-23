testdir   directory of test folder

traindir  directory of train folder

namedir   directory of main data folder

features.list   data table of features.txt

variables       names out of column of features.list

features.names  names of variables extended with 'activity' and 'subject'

activity.labels activity labels data.frame

x_test        data table of X_test.txt

y_test        data table of y_test.txt

subject_test  data table of subject_test.text

test          column bind of x_test & y_test & subject_test

x_train  data table of X_train.txt
y_train  data table of y_train.txt
subject_train data table of subject_train.text
train column bind of x_train & y_train & subject_train

data rbind of train & test


all.mean.std boolean vector of columns to extract

data.extract extracted data set

data.merged merged data for descriptive labels

result the final result
