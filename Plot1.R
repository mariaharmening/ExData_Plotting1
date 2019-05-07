#read the data into table and set the NA char and the column classes
tData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Format date
tData$Date <- as.Date(tData$Date, "%d/%m/%Y")

#Grab data for Feb 1, 2007 to Feb 2, 2007
tData <- subset(tData, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Remove incomplete data
tData <- tData[complete.cases(tData),]

#Combine Date and Time columns
dateTime <- paste(tData$Date, tData$Time)

#set column name
dateTime <- setNames(dateTime, "DateTime")

#Remove Date and Time columns
tData <- tData[ ,!(names(tData) %in% c("Date","Time"))]

#Add new DateTime column
tData <- cbind(dateTime, tData)

#Format dateTime Column
tData$dateTime <- as.POSIXct(dateTime)

#create plot 1 histogram
hist(tData$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
#save to png and close
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()