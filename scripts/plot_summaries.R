library(ggplot2)
library(reshape2)
library(randomcoloR)

# FIRST STEP: change working directory
setwd("/Users/jessicablois/Documents/GitHub/Neotoma/QSR_Manuscript") 

dsMelt <- read.csv("data/dsMelt.csv", stringsAsFactors = F)
dsMelt$variable <- as.factor(dsMelt$variable)
# set the ordering for the levesl of variable
levels(dsMelt$variable) <-  
  c("X-ray spectroscopy",
  "X-ray fluorescence",
  "X-ray diffraction",
  "phytolith",
  "paleomagnetic",
  "modern biochemistry",
  "geochemistry",
  "stable isotope",
  "organic carbon",
  "water chemistry",
  "vertebrate fauna",
  "testate amoebae",
  "pollen surface sample",
  "pollen",
  "plant macrofossil",
  "ostracode surface sample", 
  "ostracode",
  "macroinvertebrate", 
  "loss-on-ignition",
  "insect modern", 
  "insect",
  "geochronologic",
  "diatom surface sample",
  "diatom",
  "chironomid",
  "charcoal")                


#make the plot
ggplot(dsMelt, aes(x=as.factor(year), y=value,group=variable,fill=variable)) + 
  scale_x_discrete() +
  geom_area(alpha = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  #scale_fill_manual(values=randomColor(length(unique(ndsMelt$variable)))) +
  theme(legend.text=element_text(size=6)) +
  ggtitle("Neotoma Datasets") +
  ylab("Cumulative Number of Datasets") +
  xlab("Year")

occMelt <- read.csv("data/occMelt.csv", stringsAsFactors = F)
occMelt$variable <- as.factor(occMelt$variable)
# re order the levels 
levels(occMelt$variable) <-  
  c("X-ray spectroscopy",
    "X-ray fluorescence",
    "X-ray diffraction",
    "water chemistry",
    "vertebrate fauna",
    "testate amoebae",
    "pollen surface sample",
    "pollen",
    "plant macrofossil",
    "ostracode surface sample", 
    "ostracode",
    "phytolith",
    "paleomagnetic",
    "modern biochemistry", ###
    "geochemistry",
    "stable isotope",
    "organic carbon",
    "macroinvertebrate", 
    "loss-on-ignition",
    "insect modern", 
    "insect",
    "geochronologic",
    "diatom surface sample",
    "diatom",
    "chironomid",
    "charcoal")                


#make the plot
ggplot(occMelt, aes(x=as.factor(year), y=value,group=variable,fill=variable)) + 
  scale_x_discrete() +
  geom_area(alpha = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  #scale_fill_manual(values=randomColor(length(unique(occMelt$variable)))) +
  ggtitle("Neotoma Occurrences") +
  ylab("Cumulative Number of Occurrences") +
  xlab("Year")
