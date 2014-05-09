# read in data

data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

# convert date to proper format

data$Date <- as.Date(data$Date, "%d/%m/%Y")

# subset data to only look at 2007-02-01 and 2007-02-02

subsetdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02" )

# convert subsetted data to proper format

subsetdata$Global_active_power <- as.numeric(as.character(subsetdata$Global_active_power))
subsetdata$Time <- as.character(subsetdata$Time)

# combine date and time into one element

subsetdata$datetime <- as.POSIXct(paste(subsetdata$Date,subsetdata$Time), format = "%Y-%m-%d %H:%M:%S")

# make plot and write to png file

par(ps=12)

png(file = "plot2.png")
with(subsetdata,
     plot(datetime,Global_active_power, type="n", xlab=" ",
          ylab= "Global Active Power (kilowatts)"))
        lines(subsetdata$datetime,subsetdata$Global_active_power)

dev.off()

