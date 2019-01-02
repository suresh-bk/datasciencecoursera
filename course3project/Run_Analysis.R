<<<<<<< HEAD
Run_Analysis <- function(){
	# Assuming the data has been downloaded and extracted, this file
	# will read the data, merge it, extract only relevant subsets, label it
	# and finally provide a tidy-data set to run further analysis on.

	###########################################################################
	#                      Load training data                                 #
	###########################################################################

	training_readings = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) 		# load the training recordings
	training_activity = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)			# load training activity ids
	training_subject = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)	# load training subjects

	training_set <- cbind(training_activity, training_subject, training_readings)	# combine the data
	
	###########################################################################
	#                      Load testing data                                  #
	###########################################################################

	testing_readings = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)		# load the test recordings
	testing_activity = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)		# load the test activity ids
	testing_subject = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)	# loadd the test subjects
	
	testing_set <- cbind(testing_activity, testing_subject, testing_readings)	# combine the data

	###########################################################################
	#                      Merge the 2 data sets                              #
	###########################################################################
	alldata = rbind(training_set, testing_set)

	
	###########################################################################
	#                      Load feature labels and tidy it                    #
	###########################################################################
	features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
	features[,2] = gsub('-mean', 'mean', features[,2])
	features[,2] = gsub('-std', 'stddev', features[,2])
	features[,2] = gsub('[-()]', '', features[,2])
	features[,2] = gsub(',','',features[,2])
	features[,2] = tolower(features[,2])

	###########################################################################
	#                      set the column names from features                 #
	###########################################################################
	col_names <- c("activity", "subject", features[,2])
	colnames(alldata) <- col_names
	
	##############################################################################################
	# Extracts only the measurements on the mean and standard deviation for each measurement.    #
	##############################################################################################
	cols_required <- grep(".*mean.*|.*stddev.*", colnames(alldata))
	cols_required <- c(1,2,cols_required)
	alldata <- alldata[,cols_required]
	
	###########################################################################
	#     Load activity labels and replace activity ids with activity names   #
	###########################################################################
	activitylabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
	
	# compare the values of all data activity column with first column of activity labels and replace all data activity
	# with activity label second column which has the activity labels
	alldata$activity <- activitylabels$V2[match(alldata$activity, activitylabels$V1)]
	
	
	###########################################################################
	#                   Make activity and subject as factors                  #
	###########################################################################
	alldata$activity <- as.factor(alldata$activity)
	alldata$subject <- as.factor(alldata$subject)

	alldata_global <- alldata
	alldata_datatable <- as.data.table(alldata)
	
	#########################################################################################################################
	#                   Compute the mean of all columns except activity and subject grouped by activity and subject         #
	#########################################################################################################################
	tidy_data <- aggregate(alldata[,3:ncol(alldata)], by=list(activity = alldata$activity, subject=alldata$subject), mean)
	
	#########################################################################################################################
	#         Gather all the readings as variables and its mean using the gather function reduce the number of rows         #
	#########################################################################################################################
	
	tidy_data_gather <- gather(tidy_data, key="variables",value="mean", -(activity:subject))
	

	# Write tidy_data
	write.table(tidy_data_gather, "tidy_data.txt", sep="\t", row.names=FALSE)
	
}	
=======
Run_Analysis <- function(){
	# Assuming the data has been downloaded and extracted, this file
	# will read the data, merge it, extract only relevant subsets, label it
	# and finally provide a tidy-data set to run further analysis on.

	###########################################################################
	#                      Load training data                                 #
	###########################################################################

	training_readings = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) 		# load the training recordings
	training_activity = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)			# load training activity ids
	training_subject = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)	# load training subjects

	training_set <- cbind(training_activity, training_subject, training_readings)	# combine the data
	
	###########################################################################
	#                      Load testing data                                  #
	###########################################################################

	testing_readings = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)		# load the test recordings
	testing_activity = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)		# load the test activity ids
	testing_subject = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)	# loadd the test subjects
	
	testing_set <- cbind(testing_activity, testing_subject, testing_readings)	# combine the data

	###########################################################################
	#                      Merge the 2 data sets                              #
	###########################################################################
	alldata = rbind(training_set, testing_set)

	
	###########################################################################
	#                      Load feature labels and tidy it                    #
	###########################################################################
	features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
	features[,2] = gsub('-mean', 'mean', features[,2])
	features[,2] = gsub('-std', 'stddev', features[,2])
	features[,2] = gsub('[-()]', '', features[,2])
	features[,2] = gsub(',','',features[,2])
	features[,2] = tolower(features[,2])

	###########################################################################
	#                      set the column names from features                 #
	###########################################################################
	col_names <- c("activity", "subject", features[,2])
	colnames(alldata) <- col_names
	
	##############################################################################################
	# Extracts only the measurements on the mean and standard deviation for each measurement.    #
	##############################################################################################
	cols_required <- grep(".*mean.*|.*stddev.*", colnames(alldata))
	cols_required <- c(1,2,cols_required)
	alldata <- alldata[,cols_required]
	
	###########################################################################
	#     Load activity labels and replace activity ids with activity names   #
	###########################################################################
	activitylabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
	
	# compare the values of all data activity column with first column of activity labels and replace all data activity
	# with activity label second column which has the activity labels
	alldata$activity <- activitylabels$V2[match(alldata$activity, activitylabels$V1)]
	
	
	###########################################################################
	#                   Make activity and subject as factors                  #
	###########################################################################
	alldata$activity <- as.factor(alldata$activity)
	alldata$subject <- as.factor(alldata$subject)

	alldata_global <- alldata
	alldata_datatable <- as.data.table(alldata)
	
	#########################################################################################################################
	#                   Compute the mean of all columns except activity and subject grouped by activity and subject         #
	#########################################################################################################################
	tidy_data <- aggregate(alldata[,3:ncol(alldata)], by=list(activity = alldata$activity, subject=alldata$subject), mean)
	
	#########################################################################################################################
	#         Gather all the readings as variables and its mean using the gather function reduce the number of rows         #
	#########################################################################################################################
	
	tidy_data_gather <- gather(tidy_data, key="variables",value="mean", -(activity:subject))
	

	# Write tidy_data
	write.table(tidy_data_gather, "tidy_data.txt", sep="\t", row.names=FALSE)
	
}	
>>>>>>> 1fa166884e3362864a89be953883ed931b70ac21
