plot4 <- function() {
      
      # Load packages
      library(data.table)
      library(lubridate)
      library(grDevices)
      
      # Check to see if the file exists. If false, download and unzip the file
      if (!file.exists("household_power_consumption.txt")) {
            FileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
            download.file(FileURL, destfile = "HouseholdPowerConsumption.zip")
            unzip("HouseholdPowerConsumption.zip")
      }
      
      # Load the data
      PowerData <- fread(input = "household_power_consumption.txt", sep = ";", header = TRUE, 
                         na.strings = "?", showProgress = FALSE)
      PowerData$Date <- dmy(PowerData$Date)
      
      # Subset the data for the relevant date range
      PowerData <- subset(PowerData, Date > "2007-01-31" & Date <= "2007-02-02")
      
      # Format the data
      DateTime <- ymd_hms(paste(PowerData$Date, PowerData$Time, " "))
      
      # Create Plot 4 in PNG format
      png(filename = "plot4.png", width = 480, height = 480, units = "px")
      par(mfrow = c(2,2))
      plot(x = DateTime, y = PowerData$Global_active_power, type = "l", 
           ylab = "Global Active Power", xlab = "")
      plot(x = DateTime, y = PowerData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
      plot(x = DateTime, y = PowerData$Sub_metering_1, type = "n",
           xlab = "", ylab = "Energy sub metering")
            points(DateTime, PowerData$Sub_metering_1, col = "black", type = "l")
            points(DateTime, PowerData$Sub_metering_2, col = "red", type = "l")
            points(DateTime, PowerData$Sub_metering_3, col = "blue", type = "l")
            legend("topright", lty = 1, bty = "n",col = c("black", "red", "blue"),
                  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(x = DateTime, y = PowerData$Global_reactive_power, type = "l", 
           ylab = "Global_reactive_power", xlab = "datetime")
      dev.off()
      
}