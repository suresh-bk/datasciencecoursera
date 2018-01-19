plot3 <- function(){
	############# Load the required libraries #############
	
	require(data.table, quietly=TRUE)
	require(dplyr, quietly=TRUE)
	require(stringr, quietly=TRUE)
	require(lubridate, quietly=TRUE)

	fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	zipfile <- "./course4week1/data.zip" ######### for downloading the file as data.zip to the folder course4week1 under the working directory #####
	filedir <- "./course4week1"
	unzip_path <- "./course4week1/data"  ########## path for storing the unzipped files ##############
	if (!file.exists(filedir)){
		dir.create(filedir)
	}
	download.file(fileurl,file.path(zipfile))
	unzip(zipfile,exdir=unzip_path) ########### exdir is the extract directory ###############
	filename <- file.path(unzip_path,"household_power_consumption.txt")
	
	#########################################################################################################################
	# Step 1. Read the file using fread (faster than read.table) setting the col classes as below                           #
	#			First 2 columns as character and the remaining 7 as numeric                                                 #
	# Step 2. subet using the dplyr filter function to select only data for 1st and 2nd Feb 2007                            #
	# Step 3. Add a new column to concatenate Date and Time and storing it as timestamp using lubridate's dmy_hms function  #
	#########################################################################################################################
	
	dataset <- fread(input=filename,sep=";",header=TRUE,na.strings="?",colClasses = c(rep("character",2),rep("numeric",7)))
	dataset <- filter(dataset,Date=="1/2/2007" | Date=="2/2/2007")
	dataset <- dataset %>% mutate(datentime=dmy_hms(paste(dataset$Date,dataset$Time)))
	pngfilename <- file.path(unzip_path,"plot3.png")
	png(pngfilename,width = 480, height = 480, units = "px")
	with(dataset,plot(datentime, Sub_metering_1,type="l",ylab="Energy sub metering"))
	with(dataset,lines(datentime, Sub_metering_2,type="l",col="red"))
	with(dataset,lines(datentime, Sub_metering_3,type="l",col="blue"))
	legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
	dev.off()

}
