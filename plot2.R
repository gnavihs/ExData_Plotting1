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
plot(data$Date, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = "")

#Copy to plot2.png
dev.copy(png, file = "plot2.png")
dev.off()