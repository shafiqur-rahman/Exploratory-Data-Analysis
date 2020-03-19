library(data.table)
library(dplyr)

# Getting the data from the URL
temp <- tempfile()
var_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(var_url, temp)
#data <- read.table(unz(temp, "household_power_consumption.txt"))
data <- fread(unzip(temp, files = "household_power_consumption.txt"))
rm(temp)

#Subsetting only February 1 and 2 of 2007 data
p2_data <- subset(data, between(as.Date(Date, "%d/%m/%Y"), as.Date("2007-02-01"), as.Date("2007-02-02")))

# Drawing line plot in PNG
png(filename = "plot2.png", width = 480, height = 480)

plot(strptime(paste(p2_data$Date, " ", p2_data$Time), "%d/%m/%Y %H:%M:%S"), as.numeric(p2_data$Global_active_power), xlab = "", ylab = "Global Active Power (Kilowatt)", type = "l")

dev.off()
