##To Read and Get the Data
tbl <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Formatting date to Type 'Date'
tbl$Date <- as.Date(tbl$Date, "%d/%m/%Y")

## Subsetting data  from Original data for Feb. 1, 2007 to Feb. 2, 2007
tbl <- subset(tbl,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Removing incomplete observations
tbl <- tbl[complete.cases(tbl),]

## Combining Date and Time columnn
dtTime <- paste(tbl$Date, tbl$Time)

## Creation of Vectors
dtTime <- setNames(dtTime, "DateTime")


tbl <- tbl[ ,!(names(tbl) %in% c("Date","Time"))]

## Add DateTime column
tbl <- cbind(dtTime, tbl)

## Formating dateTime Column
tbl$dtTime <- as.POSIXct(dtTime)
## Create Plot 3
with(tbl, {
  plot(Sub_metering_1~dtTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dtTime,col='Red')
  lines(Sub_metering_3~dtTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Copying to PNG File
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
