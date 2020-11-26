#To read data from folder in csv format
flowers <- read.csv("Iris.csv")
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



