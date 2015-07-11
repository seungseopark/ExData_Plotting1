## plot1.R
##
## Constructs 'Global Active Power (kilowatts)' histogram plot and saves it to
## a PNG file with a width of 480 pixels and a height of 480 pixels

## Read in the data set from just the dates of 2007-02-01 and 2007-02-02 using
## fread() of data.table package with a shell command, grep, preprocessed input.
## Assumed data file in working directory : "household_power_comsumption.txt"
require("data.table")
dataSet <- fread("grep ^[12]/2/2007 household_power_consumption.txt",
                 data.table = FALSE)  # Read to a data frame not a data table

## Converts Date and Time string columns to a Date/Time column and bind it to
## the data set
dateTime <- strptime(paste(dataSet$V1, dataSet$V2),
                     format = "%d/%m/%Y %H:%M:%S", tz = "CET")  # tz: EDF/France
dataSet <- dataSet[, -(1:2)]  # Remove Date and Time string columns
dataSet <- cbind(dateTime, dataSet)

## Names columns
colNames <- c("Date_time", "Global_active_power", "Global_reactive_power",
              "Voltage", "Global_intensity", "Sub_metering_1",
              "Sub_metering_2", "Sub_metering_3")
colnames(dataSet) <- colNames

## Plots histogram of 'Global Active Power (kilowatts)' to a PNG file
png(file = "plot1.png", width = 480, height = 480, bg = "transparent")
hist(dataSet$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()