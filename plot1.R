library(sqldf)

#Read only the data from the dates 2007-02-01 and 2007-02-02 using the sqldf package
data <- read.csv.sql("household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")
closeAllConnections()

#Open png device
png("ExData_Plotting1/plot1.png")

#Build histogram on "Global_active_power" column
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

#Close device
dev.off()