# assuming data is in working directory
NEI <- readRDS("summarySCC_PM25.rds")

NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

# filter motor vehicles only sources
onroad_nei <- NEI[NEI$type == 'ON-ROAD', ]

# filter Baltimore data
baltimore_onroad_nei <- onroad_nei[onroad_nei$fips == '24510',]

# aggregate
baltimore_onroad_total <- aggregate(Emissions ~ year, data=baltimore_onroad_nei, FUN=sum)

# generate colors for plot
pal <- colorRamp(c('yellow', 'red'))
cols <- rgb(pal((baltimore_onroad_total$Emissions - min(baltimore_onroad_total$Emissions)) / (max(baltimore_onroad_total$Emissions) - min(baltimore_onroad_total$Emissions))), max=255)

library(ggplot2)
g <- ggplot(baltimore_onroad_total, aes(year, Emissions, fill=as.character(1:4))) +
  geom_bar(stat='identity') +
  theme(legend.position="none") + 
  scale_fill_hue(h=c(50, 120)) +
  labs(x="Year", y="Total emmissions (tons)", title="Emissions from PM'[2.5]*' from motor vehicles in Baltimore")
png(filename = "plot5.png")
g
dev.off()