## plot3.R
##
## Constructs Date/Time vs 'Energy sub metering' with legend plot and saves it
## to a PNG file with a width of 480 pixels and a height of 480 pixels

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

## Plots Date/Time vs 'Energy sub metering' X-Y plot with legend to a PNG file
Sys.setlocale("LC_ALL", 'en_US.UTF-8')  # Set locales to make the same plot
png(file = "plot3.png", width = 480, height = 480, bg = "transparent")
plot(dataSet$Date_time, dataSet$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(dataSet$Date_time, dataSet$Sub_metering_1, col = "black")
lines(dataSet$Date_time, dataSet$Sub_metering_2, col = "red")
lines(dataSet$Date_time, dataSet$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = "solid",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()