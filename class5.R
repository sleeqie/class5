#To read data from folder in csv format
flowers <- read.csv("plot.csv")
flowers
head(flowers)
summary(flowers)

#Installing package
library('ggplot2')
#Scattered Plots
library('readr')

ggplot(data=flowers,aes(x=SepalWidthCm, y=SepalLengthCm)) + geom_point() + theme_minimal()
ggplot(data=flowers,aes(x=SepalWidthCm, y=SepalLengthCm,color=Species)) + geom_point() + theme_minimal()


#Creating histograms
hist(flowers$SepalWidthCm, freq=NULL, density=NULL, breaks=12, xlab="Sepal Width", ylab="Frequency", main="Histogram of Sepal Width")

#Adding ggplot2 aesthetics into an histogram
histogram_gg_flowers <- ggplot(data=flowers, aes(x=SepalWidthCm))
histogram_gg_flowers + geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) + xlab("Sepal Width") + ylab("Frequency") + ggtitle("Histogram of Sepal Width")

library(ggplot2)
#Density Plots
ggplot(iris) +
  geom_density(aes(x = Petal.Width, fill = Species), alpha=0.25)

#assignment usage and everything on ggplots and use it to demonstrate the data.

library(ggplot2)
#Density Plots
ggplot(flowers) +
  geom_density(aes(x = Petal.Width, fill = Species), alpha=0.25)


#ASSIGNMENT
#Overview
#ggplot2 is a system for declaratively creating graphics, based on The Grammar of Graphics. You provide the data, tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.
# The easiest way to get ggplot2 is to install the whole tidyverse:
#install.packages("tidyverse")

# Alternatively, install just ggplot2:
#install.packages("ggplot2")

# Or the development version from GitHub:
# install.packages("devtools")
#devtools::install_github("tidyverse/ggplot2")


#It’s hard to succinctly describe how ggplot2 works because it embodies a deep philosophy of visualisation. 
#However, in most cases you start with ggplot(), supply a dataset and aesthetic mapping (with aes()). 
#You then add on layers (like geom_point() or geom_histogram()), scales (like scale_colour_brewer()), 
#faceting specifications (like facet_wrap()) and coordinate systems (like coord_flip()).

#SOURCE ONLINE
#http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html



