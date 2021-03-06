install.packages("lubridate") ## install lubridate
library(lubridate) ## load lubridate package

## transform raw data for analysis
rawdata <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, na.strings = "N/A", header = TRUE) ## reads raw data
rawdatasubset <- subset(rawdata, Date == "1/2/2007" | Date == "2/2/2007") ## subset 1/2/2007 & 2/2/2007 data
rawdatasubset$DateTime  <- paste (rawdatasubset$Date, rawdatasubset$Time, sep = " ", collapse = NULL) ## create DateTime column
rawdatasubset$DateTime <- parse_date_time(rawdatasubset$DateTime, order = "%d/%m/%y %H:%M:%S") ## parse DateTime characters to POSIXct
rawdatasubset$Global_active_power <- as.numeric(rawdatasubset$Global_active_power) ## convert to numeric
rawdatasubset$Global_reactive_power <- as.numeric(rawdatasubset$Global_reactive_power) ## convert to numeric
rawdatasubset$Voltage <- as.numeric(rawdatasubset$Voltage) ## convert to numeric
rawdatasubset$Sub_metering_1 <- as.numeric(rawdatasubset$Sub_metering_1) ## convert to numeric
rawdatasubset$Sub_metering_2 <- as.numeric(rawdatasubset$Sub_metering_2) ## convert to numeric

png(file = "plot4.png", width = 480, height = 480) ## write to .png
##plot4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(rawdatasubset, {
  plot(rawdatasubset$DateTime, rawdatasubset$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
  plot(rawdatasubset$DateTime, rawdatasubset$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  with(rawdatasubset, {
    plot(rawdatasubset$DateTime, rawdatasubset$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
    lines(rawdatasubset$DateTime, rawdatasubset$Sub_metering_2, xlab = "", ylab = "Energy sub metering", type = "l", col = "red")
    lines(rawdatasubset$DateTime, rawdatasubset$Sub_metering_3, xlab = "", ylab = "Energy sub metering", type = "l", col = "blue")
    legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = "_", bty = "n")
  })
  plot(rawdatasubset$DateTime, rawdatasubset$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "h")
})
dev.off() ## turn of graphics device