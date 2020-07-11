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

## Setting ground and Creating Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(tbl, {
  plot(Global_active_power~dtTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dtTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dtTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dtTime,col='Red')
  lines(Sub_metering_3~dtTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dtTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
#Copy Plots to PNG File  
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
