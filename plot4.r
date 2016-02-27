####Load necessary library
library(data.table)
####Make sure to have the household_power_consumption.txt file in your working directory

###Load and Transform data
powerdata <- fread("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")
powerdata$Date2 <- as.Date(powerdata$Date, "%d/%m/%Y")
twodays <- powerdata[Date2 >= "2007-02-01" & Date2 <= "2007-02-02",]
###combine date and time
twodays$fulltime <- as.POSIXct(paste(twodays$Date2, twodays$Time), format="%Y-%m-%d %H:%M:%S")



##Plot 4

##call multiple plots
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))  
with(twodays, {

##1

plot(twodays$fulltime, twodays$Global_active_power, type="o",  col="black", 
ylab = "Global Active Power", xlab = "", lty = "solid", pch = '.')

##2
plot(twodays$fulltime, twodays$Voltage, type="o",  col="black", 
ylab = "Voltage", xlab = "datetime", lty = "solid", pch = '.')

##3
plot(twodays$fulltime, twodays$Sub_metering_1, type="n",  
ylab = "Energy Sub Metering", xlab = "")
points(twodays$fulltime, twodays$Sub_metering_1, col = "black", pch = '.', type="o")
points(twodays$fulltime, twodays$Sub_metering_2, col = "red", pch = '.', type="o")
points(twodays$fulltime, twodays$Sub_metering_3, col = "blue", pch = '.', type="o")
legend("topright", lty = "solid", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

##4
plot(twodays$fulltime, twodays$Global_reactive_power, type="o",  col="black", 
ylab = "Global_reactive_power", xlab = "datetime", lty = "solid", pch = '.')
dev.off()
})