library(tidyverse)
library(lubridate)

# Load Data, Download, Read

fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('./UCI Power Consumption.zip')){
  download.file(fileurl,'./UCI Power Consumption.zip', mode = 'wb')
  unzip("UCI Power Consumption.zip")
}

elecCon <- read.csv.sql("./household_power_consumption.txt", sep = ';',  sql="select * from file where Date=='2/2/2007' OR Date=='1/2/2007'", eol="\n")
gsub('?', NA, elecCon)

#Create a DateTime field
elecCon$Date <- mdy(elecCon$Date)
DateTime <- paste(elecCon$Date, elecCon$Time)
elecCon$DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")
elecCon$DateTime <- as.POSIXct(elecCon$DateTime)


# Figure 4 - Plot multiple figures
par(mfrow=c(2, 2), mar=c(4, 4, 1, 1))
with(elecCon, {
  plot(Global_active_power~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1 ~ DateTime, elecCon, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ DateTime, elecCon, col="red")
  lines(Sub_metering_3 ~ DateTime, elecCon, col="blue")
  legend("topright", lty=1, lwd=3, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})



# Save the plot
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

rm(list=ls())
