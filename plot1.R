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
mydata$Date <- strptime(mydata$Date, "%d/%m/%Y") # Format columnn to date
mydata$Global_active_power <- as.character(mydata$Global_active_power) # Format column to character
mydata$Global_active_power <- as.numeric(mydata$Global_active_power) # Format column to numeric


##-----------------------------------------------------------------------------------
## Inspect dataset
dim(mydata)
names(mydata)
head(mydata)
mydata$Date <- strptime(mydata$Date, "%d/%m/%Y")


##-----------------------------------------------------------------------------------
## Create histogram
par(mar=c(4,4,3,2))
hist(mydata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power", ylim=c(0,1200))


##-----------------------------------------------------------------------------------
## Save to PNG file
png(filename = "plot1.png", width = 480, height = 480)
par(mar=c(4,4,3,2))
hist(mydata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power", ylim=c(0,1200))
dev.off()
