# assuming data is in working directory
NEI <- readRDS("summarySCC_PM25.rds")

# aggregate data
us_total <- aggregate(NEI$Emissions, list(Year = NEI$year), sum)

# generate colors for plot
pal <- colorRamp(c('green', 'brown'))
cols <- rgb(pal((us_total$x - min(us_total$x)) / (max(us_total$x) - min(us_total$x))), max=255)

png(filename = "plot1.png")
barplot(us_total$x / 1000000, 
        names.arg=us_total$Year, 
        xlab='Year', 
        ylab='Total pollution (millions of tons)', 
        main=expression('Total emissions from PM'[2.5]*' in US'), 
        col=cols)
dev.off()