######downloading the dataset

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip','house_hold_powerconsumption')

###### unzipping the dataset and separating it by the ';' sign to achieve the 9 variable columns
hpcon_data<-read.csv(unzip('house_hold_powerconsumption'),sep=';')


dates<-as.Date(c('1/2/2007','2/2/2007'),"%d/%m/%Y")
hpcon_data$Date<-as.Date(hpcon_data$Date,"%d/%m/%Y")

powerdata<-subset(hpcon_data,hpcon_data$Date%in%dates)

png('plot1.png',width=480,height=480)

hist(as.numeric(powerdata$Global_active_power),
     col='red',
     xlab='Global Active Power (killowatts)',
     main='Global Active Power')

dev.off()
