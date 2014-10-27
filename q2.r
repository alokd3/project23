# Plot 2
```{r}
library(plyr)
library(ggplot2)

SCCPM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCPM25.24510 <- SCCPM25[which(SCCPM25$fips == "24510"), ]
aggregate.24510 <- with(SCCPM25.24510, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.24510) <- c("year", "Emissions")


plot(aggregate.24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions for Baltimore County", xlim = c(1999, 
        2008))
```