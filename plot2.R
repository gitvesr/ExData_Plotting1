library("data.table")



#Reads in data from file  
powerdata <- data.table::fread(input = "c:/household_power_consumption.txt"
                               , na.strings="?"
)

# Convert data to Numeric
powerdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")] 

# Change Date Column to Date Type POSIXct
powerdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerdata <- powerdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("c:/plot2.png", width=480, height=480)

## Plot 2 - Create DateTime vs Global Active Power
plot(x = powerdata[, dateTime]
     , y = powerdata[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
