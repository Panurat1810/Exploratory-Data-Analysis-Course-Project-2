NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##readData
library(dplyr)
library(ggplot2)

coalSCC<-SCC[grepl("Comb.*Coal",SCC$EI.Sector),]
coal_scc <- unique(coalSCC$SCC)
coal_emi <- NEI[(NEI$SCC %in% coal_scc), ]
coal_year <- coal_emi %>% group_by(year) %>% summarise(total = sum(Emissions))
## in nutshell, 1.find a Combustion and coal related, store that subset 2.keep just a unique entry for searching in NEI
## 3.use that entry to search data in NEI 4. do the the part that every prior plot need, group by year and sum up emission.

png("plot4.png",width=480,height=480,units="px",bg="transparent")


ggp <- ggplot(coal_year, aes(factor(year), total/1000, label = round(total/1000))) + 
  geom_bar(stat = "identity", fill = "red") + 
  ggtitle("Total coal combustion related PM2.5 Emissions") + 
  xlab("Year") + ylab("PM2.5 Emissions in Kilotons") +
  ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

print(ggp)

dev.off()
