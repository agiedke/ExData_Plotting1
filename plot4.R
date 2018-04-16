# Removing all ud objects
rm(list=ls())

# Libraries
library(sqldf)
library(chron)
library(car)

# Paths
main_path <- "C:/Users/arne/DS_Programming_Courses/Coursera/ExploratoryDataAnalysis/week1/exercise1"
inpath <- paste(main_path, "input", sep ="/")
outpath <- paste(main_path)

# Read input
df <- read.csv.sql(paste(inpath, "household_power_consumption.txt", sep ="/"), 
                      sep=";", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", 
                      header = TRUE, 
                   stringsAsFactors = F)

# Observing data
str(df)
summary(as.factor(df$Date))

# Converting and cleaning data
# creating datetime variable
df$DateTime <- strptime(paste(df$Date, df$Time, sep =" "), format = "%d/%m/%Y %H:%M:%S")
# converting date variable
df$Date <- as.Date(df$Date, format = "%d/%m/%Y") 
# converting time variable
df$Time <- times(format(as.POSIXct(df$Time, tz = "", format = "%H:%M:%S", usetz = FALSE), 
                        "%H:%M:%S")) 
# # recoding NAs
# df <- as.data.frame(apply(df, 2, function(x) {x[x == "?"] <- NA; x}), stringsAsFactors = F)


# Exercises
# Plot 4
png(filename = paste(outpath, "/plot4.png", sep =""),
    width = 480, height = 480)
# setting up graphics window
par(mfcol=c(2,2))
par("oma"=c(0,0,2,0))
# 1st plot
with(df, plot(DateTime, Global_active_power, type="n", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(df, lines(DateTime, Global_active_power))
# 2nd plot
with(df, plot(DateTime, Sub_metering_1, type="n", ylab = "Energy sub metering", xlab = ""))
with(df, lines(DateTime, Sub_metering_1, col = "black"))
with(df, lines(DateTime, Sub_metering_2, col = "red"))
with(df, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"), bty="n")
# 3rd plot
with(df, plot(DateTime, Voltage, type="n", ylab = "Voltage", xlab = "datetime"))
with(df, lines(DateTime, Voltage))
# 4th plot
with(df, plot(DateTime, Global_reactive_power, type="n", xlab = "datetime"))
with(df, lines(DateTime, Global_reactive_power))
# Title for 4 plots
mtext("Energy Consumption Thursday-Saturday", outer = TRUE)
dev.off()



