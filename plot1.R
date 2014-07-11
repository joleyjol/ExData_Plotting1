

add.timestamp <- function(hhpc) {
	hhpc$DoW <- factor(strftime(strptime(hhpc$Date, "%d/%m/%Y"), "%a"))
	hhpc$Timestamp <- strptime(paste(hhpc$Date, hhpc$Time), "%d/%m/%Y %H:%M:%S")
	hhpc
}

get.cp1.data <- function() {
	first100 <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=T, nrows=100)
	classes <- sapply(first100, class)
	hhpc <- add.timestamp(subset(read.table("household_power_consumption.txt", sep=";", na.strings="?", header=T), Date == "1/2/2007" | Date == "2/2/2007"))
}

plot1 <- function(hhpc) {
	png("plot1.png")
	with(hhpc, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
	dev.off()
}

plot1(get.cp1.data())
