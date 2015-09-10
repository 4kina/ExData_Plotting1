# set your working directory, the file "household_power_consumption.txt" should be there
# read a required part of the data (this method doesn't include columns' names)
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),sep=(";"))
# read the top of the data and extract columns' names
top <- read.table("household_power_consumption.txt",header=TRUE,nrow=1,sep=";")
colnames(data) <- names(top)
# exclude missing values
data2 <- na.omit(data)
#subset needed columns
# change class of data2$Date to "POSIXlt" and make a required format
data2$Date <- strptime(as.character(data2$Date), "%d/%m/%Y")
data2$Date <- format(data2$Date, "%Y-%m-%d")
# combine two columns 
data2<-within(data2, NewDate <- paste(Date, Time, sep=' '))
data2$NewDate <- strptime(data2$NewDate,"%Y-%m-%d %H:%M:%S")
# open the file and put the graph into it
png(file="plot4.png", width = 480, height = 480)
# organize position of pictures
par(mfrow=c(2,2))
# 1st picture
with(data2,plot(NewDate,Global_active_power,type='l',ylab="Global Active Power",xlab=""))
# 2-d picture
with(data2,plot(NewDate,Voltage,type='l',ylab="Voltage",xlab="datetime"))
#3-d picture
with(data2,plot(NewDate,Sub_metering_1,type='l',ylab="Energy sub metering",xlab="", ylim=c(0,38)))
par(new=TRUE)
with(data2,plot(NewDate,Sub_metering_2,type='l',ylab="Energy sub metering",xlab="",col="red", ylim=c(0,38)))
par(new=TRUE)
with(data2,plot(NewDate,Sub_metering_3,type='l',ylab="Energy sub metering",xlab="",col="blue", ylim=c(0,38)))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       text.col=c("black","black","black"),lty=c(1,1,1), lwd=c(2,2,2),col=c("black","red","blue"))
# 4-th picture
with(data2,plot(NewDate,Global_reactive_power,type='l',ylab="Global_reactive_power",xlab="datetime"))
# close the graphics device
dev.off()
# before running the file check that all your current graphics devices are not active -  dev.cur()