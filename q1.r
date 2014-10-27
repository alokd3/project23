
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
polygon(aggregate.data, col = "red", border = "blue")
```