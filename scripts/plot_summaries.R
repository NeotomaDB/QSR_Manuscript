library(ggplot2)
library(reshape2)
library(randomcoloR)

setwd("/Users/mastodon/Documents/GitHub/Neotoma/QSR_Manuscript")

nds <- read.csv("data/neotoma_datasets_by_type.csv")
ndsMelt <- melt(nds, id.vars=c("X"))

#make the plot
ggplot(ndsMelt, aes(x=as.factor(X), y=value,group=variable,fill=variable)) + 
  scale_x_discrete() +
  geom_area(alpha = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_manual(values=randomColor(length(unique(ndsMelt$variable)))) +
  ggtitle("Neotoma Datasets") +
  ylab("Cumulative Number of Datasets") +
  xlab("Year")


nocc <- read.csv("data/neotoma_occurrences_by_type.csv")
noMelt <- melt(nocc, id.vars=c("X"))
#make the plot
ggplot(noMelt, aes(x=as.factor(X), y=value,group=variable,fill=variable)) + 
  scale_x_discrete() +
  geom_area(alpha = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_fill_manual(values=randomColor(length(unique(ndsMelt$variable)))) +
  ggtitle("Neotoma Occurrences") +
  ylab("Cumulative Number of Records") +
  xlab("Year")
