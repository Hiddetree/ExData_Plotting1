
setwd('C:/Users/Hidde/Documents/Coursera/Data Science Foundations using R Specialization/4_EDA/projects')
library('data.table')
library ('dplyr')

if (!file.exists('data')) {
      dir.create('data')
}

f<- file.path(getwd(), './data/household_power_consumption.txt')
powerDF <- fread(f, na.strings="?")

# Change date column into date type
powerDF[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter dataset for '2007-02-01' & '2007-02-02'
powerSub <- powerDF[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Plot
png('plot4.png', width = 480, height = 480)
par(mfrow = c(2, 2))

# Plot 1
plot(x = powerSub[, dateTime], y = powerSub[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(x = powerSub[, dateTime], y = powerSub[, Voltage]
     , type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(x = powerSub[, dateTime], y = powerSub[, Sub_metering_1], type="l", xlab="", ylab='Global Active Power')
lines(x = powerSub[, dateTime], y = powerSub[, Sub_metering_2], col = 'red')
lines(x = powerSub[, dateTime], y = powerSub[, Sub_metering_3], col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), c('sub_metering_1', 'sub_metering_2','sub_metering_3'),
       lty = c(1,1), lwd = c(1,1))

# Plot 3
plot(x = powerSub[, dateTime], y = powerSub[, Global_reactive_power]
     , type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()


