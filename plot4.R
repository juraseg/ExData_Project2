# assuming data is in working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find SCC of coal combustion related sources
coal_comb_scc <- SCC[grepl(".*comb.*coal", SCC$EI.Sector, ignore.case = T), ]

# filter data
us_data <- NEI[NEI$SCC %in% coal_comb_scc$SCC,]

# aggregate data
us_total <- aggregate(us_data$Emissions, list(Year = us_data$year), sum)

png(filename = "plot4.png")
barplot(us_total$x / 1000000, 
        names.arg=us_total$Year, 
        xlab='Year', 
        ylab='Total pollution (millions of tons)', 
        main=expression('Emissions from PM'[2.5]*' from coal combustion related sources in US'), 
        col=cols)
dev.off()