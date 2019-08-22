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
png("ExData_Plotting1/plot2.png")

#Plot DateTime vs. Global_active_power
plot(data$DateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n")
lines(data$DateTime, data$Global_active_power)

#Close device
dev.off()