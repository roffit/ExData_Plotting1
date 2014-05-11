datas <- read.table('./household_power_consumption.txt',sep = ';', dec =',',
                    header = TRUE)

datetime <- paste(datas[,'Date'],datas[,'Time'])
datetime <- strptime(datetime, format = '%d/%m/%Y %H:%M:%S')

datas <- cbind(datas, datetime)

day1 <- as.POSIXlt('2007-02-01')
day2 <- as.POSIXlt('2007-02-03')

datas <- datas[datas$datetime >= day1 & datas$datetime < day2,]
datas[,3:9] <- sapply(datas[,c(3,4,5,6,7,8,9)],as.character)

df <- cbind(datas[,c(1,2,10)], sapply(datas[,c(3,4,5,6,7,8,9)], as.numeric))

png('plot2.png')
plot(df[,3],df[,4],type='l', xlab= NA, ylab='Global Active Power (kilowatts)')
dev.off()