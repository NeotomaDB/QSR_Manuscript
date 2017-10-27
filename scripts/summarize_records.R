library(ggplot2)
library(reshape2)
library(plyr)
library(dplyr)
library(tidyr)
library(randomcoloR)

# FIRST STEP: change working directory
setwd("/Users/jessicablois/Documents/GitHub/Neotoma/QSR_Manuscript") 

datOrig <- read.csv("data/neotoma_scrape_10-2017.csv", stringsAsFactors = F)
colnames(datOrig) <- c("DatasetID", "Levels", "Taxa", "Occurrences", "Upload", "Type")
  
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

datOrig$year <- substrRight(as.character(datOrig$Upload), 4)

# remove datasets without an upload year
dat <- filter(datOrig, year > 2000) 
dat$year <- as.factor(dat$year)
levels(dat$year) <- c("2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017")

#rename data types and convert to factor
dat$Type[which(dat$Type=="energy dispersive X-ray spectroscopy (EDS/EDX)")] <- "X-ray spectroscopy"
dat$Type[which(dat$Type=="X-ray diffraction (XRD)")] <- "X-ray diffraction"
dat$Type[which(dat$Type=="X-ray fluorescence (XRF)")] <- "X-ray fluorescence"
dat$Type[which(dat$Type=="specimen stable isotope")] <- "stable isotope"
dat$Type <- as.factor(dat$Type)

dat_split <- split(dat, dat$Type)

doProcess <- function(dt, datatype){
  summary <- ddply(dt, .(year), summarise, numRecords = sum(Occurrences), numDS = length(Occurrences))
  summary <- summary %>%
    complete(year, fill = list(numRecords = 0, numDS= 0))
  summary$numRecords <- cumsum(summary$numRecords)
  summary$numDS <- cumsum(summary$numDS)
  return(summary)
}

summaries <- list()

for (i in dat_split){
  datatype <- as.character(i$Type)[1]
  print(datatype)
  summary <- doProcess(i, datatype)
  summaries[[datatype]]<- summary
#  print(counter)
}

# Summarize occurrences

summaryMelt <- melt(summaries, id.vars=c('year'))

occMelt <- filter(summaryMelt, variable == 'numRecords')
occMelt$variable <- NULL
occMelt$variable <- occMelt$L1 #CHANGE COL NAME
occMelt$L1 <- NULL

dsMelt <- filter(summaryMelt, variable == 'numDS')
dsMelt$variable <- NULL
dsMelt$variable <- dsMelt$L1 #CHANGE COL NAME
dsMelt$L1 <- NULL

write.csv(occMelt, "data/occMelt.csv", row.names=F)
write.csv(dsMelt, "data/dsMelt.csv", row.names=F)

