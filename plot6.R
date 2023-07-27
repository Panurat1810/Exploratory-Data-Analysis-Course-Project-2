NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##readData
library(dplyr)
library(ggplot2)

motorSCC<-SCC[grepl("Vehicle",SCC$SCC.Level.Two),]

motor_scc <- unique(motorSCC$SCC)
motor_emi <- NEI[(NEI$SCC %in% motor_scc), ]
balti_la_year <- motor_emi %>% filter(fips == "24510" | fips == "06037") %>% 
  group_by(fips, year) %>% summarise(total = sum(Emissions))

balti_la_year <- mutate(balti_la_year, 
                        Unit = ifelse(fips == "24510", "Baltimore City", 
                               ifelse(fips == "06037", "Los Angeles County")))
##now it more complicated, but just a bit, we just have filter for both Baltimore and LA, then mutate its fips to city name

png("plot6.png",width=480,height=480,units="px",bg="transparent")

ggp=ggplot(balti_la_year, aes(factor(year), total, 
                          fill = Unit, label = round(total))) + 
  geom_bar(stat = "identity") + facet_grid(. ~ Unit) + 
  ggtitle("Total Motor Vehicle Emissions") +
  xlab("Year") + ylab("Pm2.5 Emissions in Tons") +
  theme(plot.title = element_text(hjust = 0.5)) + ylim(c(0, 8000)) +
  theme_classic() + geom_text(size = 4, vjust = -1)

print(ggp)

dev.off()
