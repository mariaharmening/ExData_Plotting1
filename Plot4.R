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

#create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(tData, 
     {
       plot(Global_active_power~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
       plot(Voltage~dateTime, type="l", ylab="Voltage (volt)", xlab="")
       plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
       lines(Sub_metering_2~dateTime,col='Red')
       lines(Sub_metering_3~dateTime,col='Blue')
       legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
              legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
       plot(Global_reactive_power~dateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
     })

#save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()