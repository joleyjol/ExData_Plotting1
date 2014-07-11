

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

plot2 <- function(hhpc) {
	with(hhpc, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power", main=""))
}

plot3 <- function(hhpc) {
	with(hhpc, {
		plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", main="")
		points(Timestamp, Sub_metering_2, type="l", col="red")
		points(Timestamp, Sub_metering_3, type="l", col="blue")
		# legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n", cex=.95 )
		legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")
	})
}

plotV <- function(hhpc) {
	with(hhpc,{
		plot(Timestamp, Voltage, type="l", xlab="datetime", lwd=1)
	})
}

plotR <- function(hhpc) {
	with(hhpc,{
		plot(Timestamp, Global_reactive_power, type="l", xlab="datetime", lty=1)
	})
}

plot4 <- function(hhpc) {
	png("plot4.png")
	par(mfrow=c(2,2))

	plot2(hhpc)
	plotV(hhpc)
	plot3(hhpc)
	plotR(hhpc)

	dev.off()
}

plot4(get.cp1.data())

