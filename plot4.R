library(data.table)
library(dplyr)

# Getting the data from the URL
temp <- tempfile()
var_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(var_url, temp)
#data <- read.table(unz(temp, "household_power_consumption.txt"))
data <- fread(unzip(temp, files = "household_power_consumption.txt"))
rm(temp)

# Data Preparation
p_data <- data %>% filter(between(as.Date(Date, "%d/%m/%Y"), as.Date("2007-02-01"), as.Date("2007-02-02")))
p_data$Date_Time <- strptime(paste(p_data$Date, " ", p_data$Time), "%d/%m/%Y %H:%M:%S")
p_data$Global_active_power <- as.numeric(p_data$Global_active_power)
p_data$Global_reactive_power <- as.numeric(p_data$Global_reactive_power)
p_data$Voltage <- as.numeric(p_data$Voltage)
p_data$Sub_metering_1 <- as.numeric(p_data$Sub_metering_1)
p_data$Sub_metering_2 <- as.numeric(p_data$Sub_metering_2)
p_data$Sub_metering_3 <- as.numeric(p_data$Sub_metering_3)


p1_data <- p_data %>% select(Date_Time, Global_active_power)
p2_data <- p_data %>% select(Date_Time, Voltage)
p3_data <- p_data %>% select(Date_Time,Sub_metering_1, Sub_metering_2, Sub_metering_3)
p4_data <- p_data %>% select(Date_Time, Global_reactive_power)


# Open PNG Device
png(filename = "plot4.png", width = 480, height = 480)

# Preparing the Canvas

par(mfrow = c(2,2))

# Drawing Plot 1 for Global Active Power
plot(p1_data$Date_Time, p1_data$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")

# Drawing Plot 2 for Voltage
plot(p2_data$Date_Time, p2_data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

# Drawing Plot 3 for Energy Sub Metering
plot(p3_data$Date_Time, p3_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(p3_data$Date_Time, p3_data$Sub_metering_2,type = "l", col="red")
points(p3_data$Date_Time, p3_data$Sub_metering_3,type = "l", col="blue")
legend("topright", col= c("black", "blue","red"), pch = "________", legend= c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

# Drawing Plot 4 for Global Reactive Power
plot(p4_data$Date_Time, p4_data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()