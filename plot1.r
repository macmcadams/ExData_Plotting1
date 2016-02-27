####Load necessary library
library(data.table)
####Make sure to have the household_power_consumption.txt file in your working directory

###Load and Transform data
powerdata <- fread("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")
powerdata$Date2 <- as.Date(powerdata$Date, "%d/%m/%Y")
twodays <- powerdata[Date2 >= "2007-02-01" & Date2 <= "2007-02-02",]
###combine date and time
twodays$fulltime <- as.POSIXct(paste(twodays$Date2, twodays$Time), format="%Y-%m-%d %H:%M:%S")



##Plot 1
par(mfrow = c(1,1)) 
png("plot1.png", width=480, height=480, res = 100)
hist(twodays$Global_active_power, col = "red", main = "Global Active Power", 
xlab = "Global Active Power (kilowatts)", ylab = "Frequency", ylim = c(0,1200))
dev.off()