# set your working directory, the file "household_power_consumption.txt" should be there
# read a required part of the data (this method doesn't include columns' names)
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),sep=(";"))
# read the top of the data and extract columns' names
top <- read.table("household_power_consumption.txt",header=TRUE,nrow=1,sep=";")
colnames(data) <- names(top)
# exclude missing values
data2 <- na.omit(data)
# open the file and put the graph into it
png(file="plot1.png", width = 480, height = 480)
hist((data2$Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)",xlim=c(0, 6),ylim=c(0,1200))
# close the graphics device
dev.off()
# before running the file check that all your current graphics devices are not active -  dev.cur()