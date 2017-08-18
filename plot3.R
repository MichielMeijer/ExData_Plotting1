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
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))

# Make plot in screen device
par(mfrow= c(1,1))
with(power, plot(DateTime, Sub_metering_1, type = "l", 
                ylab = "Energy sub metering"))
with(power, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(power, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), col = c("black", "red", "blue"), cex = 0.5)


## Copy my plot to a PNG file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off() # close the device

