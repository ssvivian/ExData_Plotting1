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
png("ExData_Plotting1/plot3.png")

#Plot DateTime vs. Sub meterings 1, 2, and 3
plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

#Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

#Close device
dev.off()