NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##readData
library(dplyr)
library(ggplot2)

motorSCC<-SCC[grepl("Vehicle",SCC$SCC.Level.Two),]
motor_scc <- unique(motorSCC$SCC)
motor_emi <- NEI[(NEI$SCC %in% motor_scc), ]
motor_year <- motor_emi %>% filter(fips == "24510") %>% group_by(year) %>% 
  summarise(total = sum(Emissions))
## pretty much the same as previous plot, but on ly for one city, so just filter it 
png("plot5.png",width=480,height=480,units="px",bg="transparent")


ggp <- ggplot(motor_year, aes(factor(year), total, label = round(total))) + 
  geom_bar(stat = "identity", fill = "red") + 
  ggtitle("Total Motor Vehicle Emissions in Baltimore City") + 
  xlab("Year") + ylab("PM2.5 Emissions in Tons") +
  ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

print(ggp)

dev.off()
