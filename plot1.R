# Clean up
rm(list = ls())

# Data is downloaded into C:\Users\MichielM\rcoursera\04_EDA\Week 1\
# which will be the working directory
setwd("C:/Users/MichielM/rcoursera/04_EDA/Week 1")

# load data
power<- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# check out data
dim(power)
str(power)

# set DateTime format in new column
power$DateTime <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

# set date format in Date
power$Date <- as.Date(power$Date, format = "%d/%m/%Y") 

# Filter
# nothing from 2007-02-03 or after
power <- power[power$Date < as.Date("2007-02-03"),]
# nothing up to 2007-02-01
power <- power[power$Date >= as.Date("2007-02-01"),]

# set formats for numeric etc.
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))

# Make plot in screen device
par(mfrow= c(1,1))
hist(power$Global_active_power, col = "red", main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)")

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off() # close the device

