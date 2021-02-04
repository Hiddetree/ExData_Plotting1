
setwd('C:/Users/Hidde/Documents/Coursera/Data Science Foundations using R Specialization/4_EDA/projects')
library('data.table')
library ('dplyr')

if (!file.exists('data')) {
      dir.create('data')
}

f<- file.path(getwd(), './data/household_power_consumption.txt')
powerDF <- fread(f, na.strings="?")

# Change date column into date type
# powerDF[, Date := lapply(.SD, as.Date, '%d/%m/%Y'), .SDcols = c('Date')]
powerDF$Date <- as.Date(powerDF$Date, format = '%d/%m/%Y')
# powerDF$Time <- strptime(powerDF$Time, format="%H:%M:%S")

# Filter dataset for '2007-02-01' & '2007-02-02'
powerSub <- powerDF[(Date == '2007-02-01') | (Date == '2007-02-02')]
# powerSub <- subset(powerDF,powerDF$Date=="2007-02-01" | powerDF$Date =="2007-02-02")

# Plot
png('plot1.png', width = 480, height = 480)
hist(powerSub$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.off()

