# read in data

data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

# convert date to proper format

data$Date <- as.Date(data$Date, "%d/%m/%Y")

# subset data to only look at 2007-02-01 and 2007-02-02

subsetdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02" )

# convert subsetted data to proper format

subsetdata$Global_active_power <- as.numeric(as.character(subsetdata$Global_active_power))
subsetdata$Sub_metering_1 <- as.numeric(as.character(subsetdata$Sub_metering_1))
subsetdata$Sub_metering_2 <- as.numeric(as.character(subsetdata$Sub_metering_2))
subsetdata$Sub_metering_3 <- as.numeric(as.character(subsetdata$Sub_metering_3))
subsetdata$Voltage <- as.numeric(as.character(subsetdata$Voltage))
subsetdata$Global_reactive_power <- as.numeric(as.character(subsetdata$Global_reactive_power))
subsetdata$Time <- as.character(subsetdata$Time)

# combine date and time into one element

subsetdata$datetime <- as.POSIXct(paste(subsetdata$Date,subsetdata$Time), format = "%Y-%m-%d %H:%M:%S")

# make plot and write to png file

png(file = "plot4.png")
par(ps=12, mfrow=c(2,2))

# plot 1

with(subsetdata,
     plot(datetime,Global_active_power, type="n", xlab=" ",
          ylab= "Global Active Power"))
lines(subsetdata$datetime,subsetdata$Global_active_power)

# plot 2

with(subsetdata,
     plot(datetime,Voltage, type="n", xlab=" ",
          ylab= "Voltage"))
lines(subsetdata$datetime,subsetdata$Voltage)

# plot 3

with(subsetdata,
     plot(datetime,Sub_metering_1, type="n", xlab=" ",
          ylab= "Energy sub metering"))
lines(subsetdata$datetime,subsetdata$Sub_metering_1)
lines(subsetdata$datetime,subsetdata$Sub_metering_2, col="red")
lines(subsetdata$datetime,subsetdata$Sub_metering_3, col="blue")
legend("topright", legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
       col=c("black","red","blue"),
       lwd=1)

# plot 4

with(subsetdata,
     plot(datetime,Global_reactive_power, type="n", xlab=" ",
          ylab= "Global Reactive Power"))
lines(subsetdata$datetime,subsetdata$Global_reactive_power)

dev.off()