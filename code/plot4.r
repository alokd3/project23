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