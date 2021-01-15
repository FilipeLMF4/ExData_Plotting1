##Create plot 1 from EDA Assignment (Week 1)

##Set directory and download data
if(!file.exists("./Assignment")) {dir.create("./Assignment")}
setwd("./Assignment")


fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if(!file.exists("household_power_consumption.txt")) {
    download.file(fileURL,'data.zip')
    unzip('data.zip')
}

##Reading, subsetting and tidying up data
data <- read.table('household_power_consumption.txt',
                   header=TRUE,
                   sep = ";",
                   na.strings='?')

data$Date <- strptime(data$Date,format = '%d/%m/%Y')
sub_data <- subset(data, Date >= '2007-02-01' & Date <= '2007-02-02')
sub_data$Date <- as.POSIXlt(paste(sub_data$Date, sub_data$Time))
sub_data <- subset(sub_data, select=-Time)

rm(data) ##remove complete data set (not needed in memory anymore)

##Set graphic device, create plot and save

png(filename='plot1.png',width=480,height=480)
hist(sub_data$Global_active_power,
        col='red',
        xlab = 'Global Active Power (kilowatts)',
        main='Global Active Power')

dev.off()