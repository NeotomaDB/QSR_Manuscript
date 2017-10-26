library(ggplot2)
library(reshape2)
library(plyr)
library(dplyr)
library(tidyr)
library(randomcoloR)

setwd("/Users/mastodon/Documents/GitHub/Neotoma/QSR_Manuscript")

dat <- read.csv("data/neotoma_scrape_10-2017.csv")
colnames(dat) <- c("DatasetID", "Levels", "Taxa", "Occurrences", "Upload", "Type")
  
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}


dat$Type <- as.factor(dat$Type)
dat$year <- substrRight(as.character(dat$Upload), 4)
dat$year <- as.factor(dat$year)

dat_split <- split(dat, dat$Type)

doProcess <- function(dt, datatype){
  summary <- ddply(dt, .(year), summarise, numRecords = sum(Occurrences), numDS = length(Occurrences))
  summary$cumsum <- cumsum(summary$numRecords)
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
summaryMelt$DatasetType <- summaryMelt$L1 #CHANGE COL NAME
# dsMelt$DatasetType <- dsMelt$L1 #CHANGE COL NAMES
summaryMelt$cumsum <- summaryMelt$value
summaryMelt <- summaryMelt[summaryMelt$variable == 'cumsum', ]
summaryMelt$year = as.numeric(as.character(summaryMelt$year))
summaryMelt <- summaryMelt[summaryMelt$year > 2000,]
summaryMelt$year = as.factor(summaryMelt$year)
summaryMelt <- na.omit(summaryMelt)

summaryMelt$L1 <- NULL
summaryMelt$value <- NULL
summaryMelt$variable <- NULL

occurrences_summary <- summaryMelt[order(summaryMelt$year, summaryMelt$DatasetType),]

write.csv(occurrences_summary, "data/occurrences_summary_raw.csv")




dsMelt <- melt(summaries, id.vars=c('year'))
dsMelt$DatasetType <- dsMelt$L1 #CHANGE COL NAMES
dsMelt$cumsum <- dsMelt$value
dsMelt <- dsMelt[dsMelt$variable == 'numDS', ]
dsMelt$year = as.numeric(as.character(dsMelt$year))
dsMelt <- dsMelt[dsMelt$year > 2000,]
dsMelt$L1 <- NULL
dsMelt$value <- NULL
dsMelt$variable <- NULL

ds_summary <- dsMelt[order(dsMelt$year, dsMelt$DatasetType),]

write.csv(ds_summary, "data/datasets_summary_raw.csv")



