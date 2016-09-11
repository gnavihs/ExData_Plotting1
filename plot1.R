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
#Plot the histogram
hist(data$Global_active_power, col ="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")

#Copy to plot1.png
dev.copy(png, file = "plot1.png")
dev.off()