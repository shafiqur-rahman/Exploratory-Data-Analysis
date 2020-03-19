library(data.table)
library(dplyr)

# Getting the data from the URL
temp <- tempfile()
var_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(var_url, temp)
#data <- read.table(unz(temp, "household_power_consumption.txt"))
data <- fread(unzip(temp, files = "household_power_consumption.txt"))
rm(temp)

#Preparing Data for plotting
p3_data <- data %>% filter(between(as.Date(Date, "%d/%m/%Y"), as.Date("2007-02-01"), as.Date("2007-02-02"))) %>% select(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)
p3_data$Date_Time <- strptime(paste(p3_data$Date, " ", p3_data$Time), "%d/%m/%Y %H:%M:%S")
p3_data$Sub_metering_1 <- as.numeric(p3_data$Sub_metering_1)
p3_data$Sub_metering_2 <- as.numeric(p3_data$Sub_metering_2)
p3_data$Sub_metering_3 <- as.numeric(p3_data$Sub_metering_3)

# Drawing plot in PNG
png(filename = "plot3.png", width = 480, height = 480)

plot(p3_data$Date_Time, p3_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(p3_data$Date_Time, p3_data$Sub_metering_2,type = "l", col="red")
points(p3_data$Date_Time, p3_data$Sub_metering_3,type = "l", col="blue")
legend("topright", col= c("black", "blue","red"), pch = "________", legend= c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.off()