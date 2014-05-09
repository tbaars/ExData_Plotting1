# read in data

data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

# convert date to proper format

data$Date <- as.Date(data$Date, "%d/%m/%Y")

# subset data to only look at 2007-02-01 and 2007-02-02

subsetdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02" )

# convert subsetted data to proper format

subsetdata$Global_active_power <- as.numeric(as.character(subsetdata$Global_active_power))

# make histogram of global_active_power and write to png file

par(ps=12)

png(file = "plot1.png")
hist(subsetdata$Global_active_power, 
     col="red", 
     breaks= 16, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     xlim = c(0,8),
     ylim = c(0,1200))

dev.off()
