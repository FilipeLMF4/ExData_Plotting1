##Create plot 3 from EDA Assignment (Week 1)

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

png(filename='plot3.png',width=480,height=480)

plot(sub_data$Date,sub_data$Sub_metering_1,
     type='l',
     xlab='',
     ylab = 'Energy sub metering'
)

lines(sub_data$Date,sub_data$Sub_metering_2,
      type='l',
      col='red'
)

lines(sub_data$Date,sub_data$Sub_metering_3,
      type='l',
      col='blue'
)

legend('topright',
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),
       lty=1
)

dev.off()