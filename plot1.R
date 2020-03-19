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
p1_data <- subset(data, between(as.Date(Date, "%d/%m/%Y"), as.Date("2007-02-01"), as.Date("2007-02-02")))

# Drawing histogram in PNG 
global_active_power <- as.numeric(p1_data$Global_active_power)

png(filename = "plot1.png", width = 480, height = 480)

hist(global_active_power, xlab = "Global Active Power (Kilowatts)", col = "red", main = "Global Active Power")

dev.off()
