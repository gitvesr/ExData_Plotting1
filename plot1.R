library("data.table")



#Reads in data from file  
powerdata <- data.table::fread(input = "c:/household_power_consumption.txt"
                               , na.strings="?"
)

# Convert data to Numeric
powerdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
powerdata[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Subset Dates for 2007-02-01 and 2007-02-02
powerdata <- powerdata[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("c:/plot1.png", width=480, height=480)

## Plot1 - Histogram of Global Active Power to Frquency
hist(powerdata[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()