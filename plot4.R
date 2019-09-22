##-----------------------------------------------------------------------------------
## Download zip datasets
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "ElectricPowerConsumptionData.zip"
download.file(fileURL, destfile = fileName)
downloadDate <- date()
unzip(zipfile = "ElectricPowerConsumptionData.zip")


##-----------------------------------------------------------------------------------
## Load activity labels and feature information
mydata <- read.csv(file = "./household_power_consumption.txt", 
                   header = TRUE, 
                   sep=";")
mydata <- subset(mydata, Date=="1/2/2007" | Date=="2/2/2007") # Subset dataset
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")
mydata$dateTime <- paste(mydata$Date, mydata$Time) # Combine date and time columns
mydata$dateTime <- as.POSIXct(mydata$dateTime, "%d/%m/%Y %H:%M:%s") # Format as POSIXct
mydata$Global_active_power <- as.numeric(as.character(mydata$Global_active_power)) # Format column to numeric
mydata$Sub_metering_1 <- as.numeric(as.character(mydata$Sub_metering_1)) # Format column to numeric
mydata$Sub_metering_2 <- as.numeric(as.character(mydata$Sub_metering_2)) # Format column to numeric
mydata$Sub_metering_3 <- as.numeric(as.character(mydata$Sub_metering_3)) # Format column to numeric
mydata$Voltage <- as.numeric(as.character(mydata$Voltage)) # Format column to numeric
mydata$Global_reactive_power <- as.numeric(as.character(mydata$Global_reactive_power)) # Format column to numeric


##-----------------------------------------------------------------------------------
## Inspect dataset
dim(mydata)
names(mydata)
head(mydata)
class(mydata$Sub_metering_1)
range(mydata$Sub_metering_1)

##-----------------------------------------------------------------------------------
## Create graph
# Set settings
par(mfrow=c(2,2), mar=c(4,4,2,1))

#topleft
plot(mydata$Global_active_power~mydata$dateTime, type="l", ylab = "Global Active Power", xlab="")

#topright
plot(mydata$Voltage~mydata$dateTime, type="l", ylab = "Voltage", xlab="datetime")

#bottom left
plot(mydata$Sub_metering_1~mydata$dateTime, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(mydata$Sub_metering_2~mydata$dateTime, type="l", col="red")
lines(mydata$Sub_metering_3~mydata$dateTime, type="l", col="blue")
legend("topright", pch="-", lwd=2, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       box.col="white", inset = .02)

#bottom right
plot(mydata$Global_reactive_power~mydata$dateTime, type="l", ylab = "Global Reactive Power", xlab="datetime")


##-----------------------------------------------------------------------------------
## Save to PNG file
png(filename = "plot4.png", width = 480, height = 480)
# Set settings
par(mfrow=c(2,2), mar=c(4,4,2,1))

#topleft
plot(mydata$Global_active_power~mydata$dateTime, type="l", ylab = "Global Active Power", xlab="")

#topright
plot(mydata$Voltage~mydata$dateTime, type="l", ylab = "Voltage", xlab="datetime")

#bottom left
plot(mydata$Sub_metering_1~mydata$dateTime, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(mydata$Sub_metering_2~mydata$dateTime, type="l", col="red")
lines(mydata$Sub_metering_3~mydata$dateTime, type="l", col="blue")
legend("topright", pch="-", lwd=2, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       box.col="white", inset = .02)

#bottom right
plot(mydata$Global_reactive_power~mydata$dateTime, type="l", ylab = "Global Reactive Power", xlab="datetime")
dev.off()
