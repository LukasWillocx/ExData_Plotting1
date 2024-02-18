######downloading the dataset

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip','house_hold_powerconsumption')

###### unzipping the dataset and separating it by the ';' sign to achieve the 9 variable columns
hpcon_data<-read.csv(unzip('house_hold_powerconsumption'),sep=';')


#defining which timespan we want to assess

dates<-as.Date(c('1/2/2007','2/2/2007'),"%d/%m/%Y") #the dates of interest

#formatting the character dates to the date-class

hpcon_data$Date<-as.Date(hpcon_data$Date,"%d/%m/%Y")

#subsetting the data for February first and second of 2007
powerdata<-subset(hpcon_data,hpcon_data$Date %in% dates)

#combining the data and time variables into one 'time' variable 
powerdata$dt<-as.POSIXct(paste(powerdata$Date, powerdata$Time), format="%Y-%m-%d%H:%M:%S")


png('plot4.png',width=480,height=480)
#2x2 plotting grid
par(mfrow=c(2,2)) 

#plot 1
with(powerdata,plot(dt,as.numeric(Global_active_power),
                    type='l',
                    xlab=NA,
                    ylab='Global active power (kilowats)'))


#plot 2

with(powerdata,plot(dt,as.numeric(Voltage),
                    type='l',
                    xlab=NA,
                    ylab='voltage'))


#plot 3

with(powerdata, plot(Sub_metering_1~dt,type='l',
                     col='black',
                     xlab=NA,
                     ylab='Energy sub metering'))
with(powerdata, lines(Sub_metering_2~dt,col='red'))
with(powerdata, lines(Sub_metering_3~dt,col='blue'))
legend('topright',
       col=c('black','red','blue'),
       legend =c('sub metering 1',
                 'sub metering 2',
                 'sub metering 3'),
       lty=1)

#plot 4

with(powerdata,plot(dt,as.numeric(Global_reactive_power),
                    type='l',
                    xlab=NA,
                    ylab='Global reactive power (kilowatts)'))
dev.off()
