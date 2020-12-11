#Understanding the Ggplot Syntax
#A step by step process of building up a ggplot
# Setup
options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
data("midwest", package = "ggplot2")  # load the data
# midwest <- read.csv("http://goo.gl/G1K41K") # alt source 
# Init Ggplot
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'

#How to Make a Simple Scatterplot
#Let’s make a scatterplot on top of the blank ggplot by adding points using a geom layer called geom_point.
library(ggplot2)
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point()

#For now, let’s just add a smoothing layer using geom_smooth(method='lm'). Since the method is set as lm (short for linear model), it draws the line of best fit.
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
plot(g)

#Adjusting the X and Y axis limits
#Method 1: By deleting the points outside the range
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
# Delete the points outside the limits
g + xlim(c(0, 0.1)) + ylim(c(0, 1000000))   # deletes points
# g + xlim(0, 0.1) + ylim(0, 1000000)   # deletes points
#Method 2: Zooming In
#The other method is to change the X and Y axis limits by zooming in to the region of interest without deleting the points. This is done using coord_cartesian().
#Let’s store this plot as g1.
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
# Zoom in without deleting the points outside the limits. 
# As a result, the line of best fit is the same as the original plot.
g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in
plot(g1)
#How to Change the Title and Axis Labels
library(ggplot2)
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in
# Add Title and Labels
g1 + labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
# or
g1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + xlab("Area") + ylab("Population")

#FULL CALL PLOT SO FAR
# Full Plot call
library(ggplot2)
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method="lm") + 
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

#How to change the colour and size of point and line
library(ggplot2)
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(col="pink", size=0.5) +   # Set static color and size for points
  geom_smooth(method="lm", col="yellow") +  # change the color of line
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

library(ggplot2)
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=1) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=1) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
plot(gg)

#Now each point is colored based on the state it belongs because of aes(col=state). Not just color, but size, shape, stroke (thickness of boundary) and fill (fill color) can be used to discriminate groupings.
#As an added benefit, the legend is added automatically. If needed, it can be removed by setting the legend.position to None from within a theme() functio

gg + theme(legend.position="None")  # remove legend
#Also, You can change the color palette entirely.
gg + scale_colour_brewer(palette = "Set3")  # change color palette
#More of such palettes can be found in the RColorBrewer package
library(RColorBrewer)
head(brewer.pal.info, 10)  # show 10 palettes

#How to Change the X Axis Texts and Location
#Step 1: Set the breaks
#The breaks should be of the same scale as the X axis variable. Note that I am using scale_x_continuous because, the X axis variable is a continuous variable. Had it been a date variable, scale_x_date could be used. Like scale_x_continuous() an equivalent scale_y_continuous() is available for Y axis.
# Change breaks
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))
#change label
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = letters[1:11])

# Reverse X Axis Scale
gg + scale_x_reverse()

#How to Write Customized Texts for Axis Labels, by Formatting the Original Values?
#Let’s set the breaks for Y axis text as well and format the X and Y axis labels. 
#I have used 2 methods for formatting labels: 
#* Method 1: Using sprintf(). (Have formatted it as % in below example) 
#* Method 2: Using a custom user defined function. (Formatted 1000’s to 1K scale)
# Change Axis Texts
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = sprintf("%1.2f%%", seq(0, 0.1, 0.01))) + 
  scale_y_continuous(breaks=seq(0, 1000000, 200000), labels = function(x){paste0(x/1000, 'K')})

#How to select themes
theme_gray()
theme_bw()
theme_linedraw()
theme_light()
theme_minimal()
theme_classic()
theme_void()
# method 1: Using theme_set()
theme_set(theme_classic())  # not run
gg
# method 2: Adding theme Layer itself.
gg + theme_bw() + labs(subtitle="BW Theme")
gg + theme_classic() + labs(subtitle="Classic Theme")
gg + theme_void()
gg + theme_minimal()


































