Peer Assessment 2: Exploratory Data Analysis

- Introduction
 Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (SCCPM25). You can read more information about the SCCPM25 at the EPA National Emissions Inventory web site.
 For each year and for each type of PM source, the SCCPM25 records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that will be use for this assignment are for 1999, 2002, 2005, and 2008.

```{r}
library(plyr)
library(ggplot2)
```
```{r}
SCCPM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```
The goal

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.
```{r}
set.seed(12345)
SCCPM25.reduced <- SCCPM25[sample(nrow(SCCPM25), 500), ]
```
As a summary,all the data for plots below is also represented in single plot.r for the six plots separately
# Plot 1.
```{r}
library(plyr)
library(ggplot2)

SCCPM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

aggregate.data <- with(SCCPM25, aggregate(Emissions, by = list(year), sum))


plot(aggregate.data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in the United States")
polygon(aggregate.data, col = "green", border = "blue")
```
![Plot1](/graphs/plot_1.png)

plot of chunk unnamed-chunk-3

It is clear that total emissions from PM2.5 have decreased in the United States from 1999 to 2008
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
[https://github.com/alokd3/project23/blob/master/graphs/plot_2.png]
![Plot2](/graphs/plot_2.png)
Total emissions from PM2.5 have decreased in the Baltimore City, Maryland from 1999 to 2008 however there was an increase of PM2.5 between the year 2002 and 2006.
# Plot3

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
![Plot3](/graphs/plot_3.png)

# plot4

How emissions from coal combustion-related sources changed from 1999-2008
```{r}
library(lattice)
library(plyr)
SCCPM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

SCCPM25$SCC <- as.character(SCCPM25$SCC)
SCCPM25.coal <- SCCPM25[SCCPM25$SCC %in% SCC.identifiers, ]

aggregate.coal <- with(SCCPM25.coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.coal) <- c("year", "Emissions")

plot(aggregate.coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
    xlim = c(1999, 2008))
polygon(aggregate.coal, col = "red", border = "red")
```
![Plot4](/graphs/plot_4.png)

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
![Plot5](/graphs/plot_5.png)

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
![Plot5](/graphs/plot_5.png)