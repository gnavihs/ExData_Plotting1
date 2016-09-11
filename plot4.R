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

par(mfcol = c(2,2))
#Plot
with(data, {
  plot(Date, Global_active_power, type="l", ylab="Global Active Power", xlab = "")
  plot(Date, Sub_metering_1, type="l", xlab ="", ylab="Energy sub metering")
  lines(Date, Sub_metering_2, type="l", col ="red")
  lines(Date, Sub_metering_3, type="l", col = "blue")
  plot(Date, Voltage, type="l", ylab="Voltage", xlab = "datetime")
  plot(Date, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab = "datetime")
})
#Copy to plot4.png
dev.copy(png, file = "plot4.png")
dev.off()