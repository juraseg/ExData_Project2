# assuming data is in working directory
NEI <- readRDS("summarySCC_PM25.rds")

NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

# filter motor vehicles only sources
onroad_nei <- NEI[NEI$type == 'ON-ROAD', ]

# filter Baltimore data
baltimore_onroad_nei <- onroad_nei[onroad_nei$fips == '24510',]

# filter Los-Angeles data
la_onroad_nei <- onroad_nei[onroad_nei$fips == '06037',]

# aggregate
baltimore_onroad_total <- aggregate(Emissions ~ year, data=baltimore_onroad_nei, FUN=sum)
la_onroad_total <- aggregate(Emissions ~ year, data=la_onroad_nei, FUN=sum)

baltimore_onroad_total$name = "Baltimore"
la_onroad_total$name = "Los-Angeles"

data = rbind(baltimore_onroad_total, la_onroad_total)

library(ggplot2)

g <- ggplot(data, aes(year, Emissions, group=name)) +
  geom_line(aes(col=name), size=1.5) +
  labs(x="Year", y="Total emmissions (tons)", 
       title="Comparison of emissions from motor vehicles in Baltimore and LA",
       col="County")
png(filename = "plot6.png")
g
dev.off()
