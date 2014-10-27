# Plot5

How emissions from motor vehicle sources changed from 1999-2008 in Baltimore City
```{r}
library(ggplot2)
library(plyr)
SCCPM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)
SCCPM25$SCC <- as.character(SCCPM25$SCC)
SCCPM25.motor <- SCCPM25[SCCPM25$SCC %in% SCC.identifiers, ]

SCCPM25.motor.24510 <- SCCPM25.motor[which(SCCPM25.motor$fips == "24510"), ]

aggregate.motor.24510 <- with(SCCPM25.motor.24510, aggregate(Emissions, by = list(year), 
    sum))

plot(aggregate.motor.24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions from Motor Vehicle Sources")

```