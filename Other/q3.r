# PLOT3

Sources have seen decreases in emissions from 1999-2008 for Baltimore City Which have seen increases in emissions from 1999-2000
```{r}
library(ggplot2)
library(plyr)
SCCPM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCPM25.24510 <- SCCPM25[which(SCCPM25$fips == "24510"), ]
aggregate.24510 <- with(SCCPM25.24510, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.24510) <- c("year", "Emissions")

SCCPM25.24510.type <- ddply(SCCPM25.24510, .(type, year), summarize, Emissions = sum(Emissions))
SCCPM25.24510.type$Pollutant_Type <- SCCPM25.24510.type$type

qplot(year, Emissions, data = SCCPM25.24510.type, group = Pollutant_Type, color = Pollutant_Type, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

```