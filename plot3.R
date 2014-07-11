

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

plot3 <- function(hhpc) {
	png("plot3.png")
	with(hhpc, {
		plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", main="")
		points(Timestamp, Sub_metering_2, type="l", col="red")
		points(Timestamp, Sub_metering_3, type="l", col="blue")
		legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1 )
	})
	dev.off()
}

plot3(get.cp1.data())
