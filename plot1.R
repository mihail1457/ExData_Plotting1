library(tidyverse)
library(lubridate)

# Load Data, Download, Read

fileurl = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('./UCI Power Consumption.zip')){
  download.file(fileurl,'./UCI Power Consumption.zip', mode = 'wb')
  unzip("UCI Power Consumption.zip")
}

elecCon <- read.csv.sql("./household_power_consumption.txt", sep = ';',  sql="select * from file where Date=='2/2/2007' OR Date=='1/2/2007'", eol="\n")


# Figure 1 - Plot Histogram
hist(elecCon$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# Create the file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

rm(list=ls())