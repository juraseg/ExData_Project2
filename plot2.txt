# assuming data is in working directory
NEI <- readRDS("summarySCC_PM25.rds")

# filter to include only Baltimore data
baltimore <- NEI[NEI$fips == '24510',]

# aggregate data
baltimore_total <- aggregate(baltimore$Emissions, list(Year = baltimore$year), sum)

# generate colors for plot
pal <- colorRamp(c('yellow', 'red'))
cols <- rgb(pal((baltimore_total$x - min(baltimore_total$x)) / (max(baltimore_total$x) - min(baltimore_total$x))), max=255)

png(filename = "plot2.png")
barplot(baltimore_total$x / 1000, 
        names.arg=baltimore_total$Year, 
        xlab='Year', 
        ylab='Total pollution (thousands of tons)', 
        main=expression('Total emissions from PM'[2.5]*' in Baltimore'), 
        col=cols)
dev.off()