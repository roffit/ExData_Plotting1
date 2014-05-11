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


png('plot4.png')
par(mfcol = c(2,2))

plot(df[,3],df[,4],type='l', xlab= NA, ylab='Global Active Power')

with(df,plot(datetime, Sub_metering_1,type='n', xlab = NA,
             ylab = 'Energy sub metering'))
lines(df[,3], df[,8], col = 'black')
lines(df[,3], df[,9], col = 'red')
lines(df[,3], df[,10], col = 'blue')
legend('topright', pch = '-', col= c('black', 'red', 'blue'),
       legend = names(df)[8:10], bty = 'n', cex = 1.1, pt.cex = 2)

plot(df[,3],df[, 6],type='l', ylab= names(df)[6], xlab = names(df)[3])

plot(df[,3],df[, 5],type='l', ylab = names(df)[5], xlab = names(df)[3])
dev.off()