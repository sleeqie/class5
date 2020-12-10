#How to make any plot in ggplot2?
#ggplot2 is the most elegant and aesthetically pleasing graphics framework available in R. 
#It has a nicely planned structure to it. This tutorial focusses on exposing this underlying structure you can use to make any ggplot. 
#But, the way you make plots in ggplot2 is very different from base graphics making the learning curve steep. 
#So leave what you know about base graphics behind and follow along. 

#The Setup
#First, you need to tell ggplot what dataset to use. This is done using the ggplot(df) function, where df is a dataframe that contains all features needed to make the plot.
library(ggplot2)
ggplot(diamonds) # if only the dataset is known.
ggplot(diamonds, aes(x=carat))  # if only X-axis is known. The Y-axis can be specified in respective geoms.
ggplot(diamonds, aes(x=carat, y=price))  # if both X and Y axes are fixed for all layers.
ggplot(diamonds, aes(x=carat, color=cut))  # Each category of the 'cut' variable will now have a distinct  color, once a geom is added.
ggplot(diamonds, aes(x=carat, y=price), color="steelblue")

#The layers
#The layers in ggplot2 are also called ‘geoms’. Once the base setup is done, you can append the geoms one on top of the other. 
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() # Adding scatterplot geom (layer1) and smoothing geom (layer2).
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + geom_smooth(aes(x=carat, y=price, color=cut)) # Same as above but specifying the aesthetics inside the geoms.
#To make it simpler
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + geom_smooth(aes(x=carat, y=price)) # Remove color from geom_smooth
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth()  # same but simpler
#make the shape of the points vary with color feature?
ggplot(diamonds, aes(x=carat, y=price, color=cut, shape=color)) + geom_point()

#The labels
#You might want to add the plot’s main title and perhaps change the X and Y axis titles. This can be accomplished using the labs layer, meant for specifying the labels. However, manipulating the size, color of the labels is the job of the ‘Theme’.
gg <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + labs(title="Scatterplot", x="Carat", y="Price")  # add axis lables and plot title.
print(gg)
#Note: If you are showing a ggplot inside a function, you need to explicitly save it and then print using the print(gg), like we just did above.

#The Theme
#Adjusting the size of labels can be done using the theme() function by setting the plot.title, axis.text.x and axis.text.y. They need to be specified inside the element_text(). If you want to remove any of them, set it to element_blank() and it will vanish entirely.
#Adjusting the legend title is a bit tricky. If your legend is that of a color attribute and it varies based in a factor, you need to set the name using scale_color_discrete(), where the color part belongs to the color attribute and the discrete because the legend is based on a factor variable.
gg1 <- gg + theme(plot.title=element_text(size=15, face="bold"), 
                  axis.text.x=element_text(size=5), 
                  axis.text.y=element_text(size=5),
                  axis.title.x=element_text(size=10),
                  axis.title.y=element_text(size=10)) + 
  scale_color_discrete(name="Cut of diamonds")  # add title and axis text, change legend title.
print(gg1)  # print the plot
#f the legend shows a shape attribute based on a factor variable, 
#you need to change it using scale_shape_discrete(name="legend title"). 
#Had it been a continuous variable, use scale_shape_continuous(name="legend title") instead.
# based on a fill attribute on a continuous variable? The answer is scale_fill_continuous(name="legend title").

#The Facets
#In the previous chart, you had the scatterplot for all different values of cut plotted in the same chart. What if you want one chart for one cut?
gg1 + facet_wrap( ~ cut, ncol=2)  # columns defined by 'cut'
#facet_wrap(formula) takes in a formula as the argument. The item on the RHS corresponds to the column. The item on the LHS defines the rows.
gg1 + facet_wrap(color ~ cut)  # row: color, column: cut
#In facet_wrap, the scales of the X and Y axis are fixed to accomodate all points by default. This would make comparison of attributes meaningful because they would be in the same scale. However, it is possible to make the scales roam free making the charts look more evenly distributed by setting the argument scales=free.
gg1 + facet_wrap(color ~ cut, scales="free")  # row: color, column: cut
#facet_grid
gg1 + facet_grid(color ~ cut)   # In a grid

#Commonly used features
#The ggfortify package makes it very easy to plot time series directly from a time series object, without having to convert it to a dataframe.
install.packages("ggfortify")
library(ggfortify)
autoplot(AirPassengers) + labs(title="AirPassengers")  # where AirPassengers is a 'ts' object





















