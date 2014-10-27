# Plot6

motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California have decreased.The city which has seen greater changes over time in motor vehicle emissions is los angeles county
```{r}
library(plyr)
library(ggplot2)

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

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

SCCPM25$SCC <- as.character(SCCPM25$SCC)
SCCPM25.motor <- SCCPM25[SCCPM25$SCC %in% SCC.identifiers, ]

SCCPM25.motor.24510 <- SCCPM25.motor[which(SCCPM25.motor$fips == "24510"), ]
SCCPM25.motor.06037 <- SCCPM25.motor[which(SCCPM25.motor$fips == "06037"), ]
aggregate.motor.24510 <- with(SCCPM25.motor.24510, aggregate(Emissions, by = list(year), 
    sum))
aggregate.motor.24510$group <- rep("Baltimore County", length(aggregate.motor.24510[, 
    1]))

aggregate.motor.06037 <- with(SCCPM25.motor.06037, aggregate(Emissions, by = list(year), 
    sum))
aggregate.motor.06037$group <- rep("Los Angeles County", length(aggregate.motor.06037[, 
    1]))
aggregated.motor.zips <- rbind(aggregate.motor.06037, aggregate.motor.24510)
aggregated.motor.zips$group <- as.factor(aggregated.motor.zips$group)

colnames(aggregated.motor.zips) <- c("Year", "Emissions", "Group")

qplot(Year, Emissions, data = aggregated.motor.zips, group = Group, color = Group, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Comparison of Total Emissions by County")

```