#Read data of required dates only
data <- read.csv.sql("../household_power_consumption.txt",
                     sql = "select * from file where Date ='1/2/2007' or Date ='2/2/2007' ",   
                     header = TRUE,
                     sep=";")

#removing NA entries
bad <- is.na(data$Global_active_power)
data <- data[!bad, ]

#Coverting Date column to POSIXlt
data$Date <- paste(data$Date, data$Time)
data$Date <- strptime(data$Date, "%e/%m/%Y %H:%M:%S")

par(mfrow =c(1,1), mar=c(6,6,2,2))
#Plot
plot(data$Date, data$Sub_metering_1, type="l", xlab ="", ylab="Energy sub metering")
lines(data$Date, data$Sub_metering_2, type="l", col ="red")
lines(data$Date, data$Sub_metering_3, type="l", col = "blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Copy to plot3.png
dev.copy(png, file = "plot3.png")
dev.off()