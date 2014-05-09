# read in data

data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

# convert date to proper format

data$Date <- as.Date(data$Date, "%d/%m/%Y")

# subset data to only look at 2007-02-01 and 2007-02-02

subsetdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02" )

# convert subsetted data to proper format

subsetdata$Sub_metering_1 <- as.numeric(as.character(subsetdata$Sub_metering_1))
subsetdata$Sub_metering_2 <- as.numeric(as.character(subsetdata$Sub_metering_2))
subsetdata$Sub_metering_3 <- as.numeric(as.character(subsetdata$Sub_metering_3))
subsetdata$Time <- as.character(subsetdata$Time)

# combine date and time into one element

subsetdata$datetime <- as.POSIXct(paste(subsetdata$Date,subsetdata$Time), format = "%Y-%m-%d %H:%M:%S")

# make plot and write to png file

par(ps=12)

png(file = "plot3.png")
with(subsetdata,
     plot(datetime,Sub_metering_1, type="n", xlab=" ",
          ylab= "Energy sub metering"))
lines(subsetdata$datetime,subsetdata$Sub_metering_1)
lines(subsetdata$datetime,subsetdata$Sub_metering_2, col="red")
lines(subsetdata$datetime,subsetdata$Sub_metering_3, col="blue")
legend("topright", legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
       col=c("black","red","blue"),
       lwd=1)
dev.off()
