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


##-----------------------------------------------------------------------------------
## Inspect dataset
dim(mydata)
names(mydata)
head(mydata)


##-----------------------------------------------------------------------------------
## Create graph
plot(mydata$Global_active_power~mydata$dateTime, type="l", ylab = "Global Active Power (kilowatts)", xlab="")


##-----------------------------------------------------------------------------------
## Save to PNG file
png(filename = "plot2.png", width = 480, height = 480)
par(mar=c(4,4,3,2))
plot(mydata$Global_active_power~mydata$dateTime, type="l", ylab = "Global Active Power (kilowatts)", xlab="")
dev.off()
