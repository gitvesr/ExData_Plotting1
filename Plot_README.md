
# Exploratory-Data-Analysis-Week-1-Project
*Instructions

*This assignment uses data from the UC Irvine Machine Learning Repository, a popular *repository for machine learning datasets. In particular, we will be using the "Individual *household electric power consumption Data Set" which I have made available on the course web *site:
  
*Dataset: Electric power consumption
*Description: Measurements of electric power consumption in one household with a one-minute *sampling rate over a period of almost 4 years. Different electrical quantities and some sub-*metering values are available.
*The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
  
*  Date: Date in format dd/mm/yyyy
*Time: time in format hh:mm:ss
*Global_active_power: household global minute-averaged active power (in kilowatt)
*Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
*Voltage: minute-averaged voltage (in volt)
*Global_intensity: household global minute-averaged current intensity (in ampere)
*ub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
*Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
*Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.



#Plot1.R
Reads in data from file  
--
powerdata <- data.table::fread(input = "c:/household_power_consumption.txt"
                             , na.strings="?"
                             )

Convert data to Numeric
--
powerdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

Change Date Column to Date Type
--
powerdata[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

Subset Dates for 2007-02-01 and 2007-02-02
--
powerdata <- powerdata[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

Open Device
--
png("c:/plot1.png", width=480, height=480)


Plot1 - Histogram of Global Active Power to Frquency
--
hist(powerdata[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()


#--------

#Plot2.R


#Read File as above 

#Change Date Column to Date Type POSIXct

--
powerdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


#Filter Dates for 2007-02-01 and 2007-02-02
--
powerdata <- powerdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

Create Plot2 file
--
png("c:/plot2.png", width=480, height=480)

Plot 2 - Create DateTime vs Global Active Power
--
plot(x = powerdata[, dateTime]      , y = powerdata[, Global_active_power]      , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

#----

#Plot3.R

Reads in data from file as above

powerdata <- data.table::fread(input = "c:/household_power_consumption.txt"
                             , na.strings="?"
)

# Convert data to Numeric
powerdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date  to apply filter
powerdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerdata <- powerdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("c:/plot3.png", width=480, height=480)

# Plot 3
plot(powerdata[, dateTime], powerdata[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerdata[, dateTime], powerdata[, Sub_metering_2],col="red")
lines(powerdata[, dateTime], powerdata[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()



#--------
#Plot4.R



#Reads in data from file as in Plot1.R and convert to date format


Filter Dates for 2007-02-01 and 2007-02-02
--
powerdata <- powerdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("c:/plot4.png", width=480, height=480)

Plot all the 4 data
--
par(mfrow=c(2,2))

Plot 1
--
plot(powerdata[, dateTime], powerdata[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

Plot 2
--
plot(powerdata[, dateTime],powerdata[, Voltage], type="l", xlab="datetime", ylab="Voltage")

Plot 3
--
plot(powerdata[, dateTime], powerdata[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerdata[, dateTime], powerdata[, Sub_metering_2], col="red")
lines(powerdata[, dateTime], powerdata[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

Plot 4
--
plot(powerdata[, dateTime], powerdata[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()



