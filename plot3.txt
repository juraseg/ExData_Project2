# assuming data is in working directory
NEI <- readRDS("summarySCC_PM25.rds")

NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

# filter Baltimore data
baltimore <- NEI[NEI$fips == '24510',]

# aggregate
baltimore_total <- aggregate(Emissions ~ year + type, data=baltimore, FUN=sum)

library(ggplot2)
g <- ggplot(baltimore_total, aes(year, Emissions)) +
  geom_bar(stat='identity', aes(fill=type)) + 
  facet_wrap(~ type, nrow=2) + 
  theme(legend.position="none") +
  scale_fill_hue(l=45) + 
  labs(x="Year", y="Total emmissions (tons)", title="Total emissions from PM'[2.5]*' in Baltimore")
png(filename = "plot3.png")
g
dev.off()