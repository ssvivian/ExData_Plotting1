library(sqldf)
library(dplyr)

#Read only the data from the dates 2007-02-01 and 2007-02-02 using the sqldf package
data <- read.csv.sql("household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")
closeAllConnections()

#Add a "DateTime" column pasting the "Date" and "Time" columns
#and convert it to POSIXlt
data <- mutate(data, DateTime=paste(Date, Time))
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

#Open png device
png("ExData_Plotting1/plot4.png")

#Build the 2x2 plot grid (column-wise)
par(mfcol = c(2,2))

#Plot 1: DateTime vs. Global_active_power
plot(data$DateTime, data$Global_active_power, ylab = "Global Active Power", xlab = "", type = "n")
lines(data$DateTime, data$Global_active_power)

#Plot 2: DateTime vs. Sub meterings 1, 2, and 3
plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", inset = 0.01, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, box.lty=0, cex = 0.9)

#Plot3: DateTime vs. Voltage
plot(data$DateTime, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(data$DateTime, data$Voltage)

#Plot 4: DateTime vs. Global_reactive_power
plot(data$DateTime, data$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "n")
lines(data$DateTime, data$Global_reactive_power)

#Close device
dev.off()
