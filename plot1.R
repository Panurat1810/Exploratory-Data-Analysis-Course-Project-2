NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##readData

SubNEI<-aggregate(Emissions~year,NEI,sum)
##subset only year and emission and sum emissions of the same year together

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot((SubNEI$Emissions)/10^6,names.arg = SubNEI$year,
        xlab="year",ylab="emissions(10^6 tons)",main="Total Emissions of PM 2.5 ")
##PLOT

dev.off()