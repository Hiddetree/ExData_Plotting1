
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
png('plot3.png', width = 480, height = 480)
plot(x = powerSub[, dateTime], y = powerSub[, Sub_metering_1], type="l", xlab="", ylab="Global Active Power")
lines(x = powerSub[, dateTime], y = powerSub[, Sub_metering_2], col = 'red')
lines(x = powerSub[, dateTime], y = powerSub[, Sub_metering_3], col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), c('sub_metering_1', 'sub_metering_2','sub_metering_3'),
       lty = c(1,1), lwd = c(1,1))
dev.off()
