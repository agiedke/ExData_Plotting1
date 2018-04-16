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
# Plot 3
png(filename = paste(outpath, "/plot2.png", sep =""),
    width = 480, height = 480)
with(df, plot(DateTime, Global_active_power, type="n", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(df, lines(DateTime, Global_active_power))
dev.off()



