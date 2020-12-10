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
autoplot(airmiles) + labs(title="Airmiles")  # where AirPassengers is a 'ts' object

#Plot multiple timeseries on same ggplot
#Plotting multiple timeseries requires that you have your data in dataframe format, in which one of the columns is the dates that will be used for X-axis.
#Approach 1: After converting, you just need to keep adding multiple layers of time series one on top of the other.
#Approach 2: Melt the dataframe using reshape2::melt by setting the id to the date field. Then just add one geom_line and set the color aesthetic to variable (which was created during the melt).
# Approach 1:
data("economics", package="ggplot2")  # init data
economics <- data.frame(economics)  # convert to dataframe
ggplot(economics) + geom_line(aes(x=date, y=pce, color="pcs")) + geom_line(aes(x=date, y=unemploy, col="unemploy")) + scale_color_discrete(name="Legend") + labs(title="Economics") # plot multiple time series using 'geom_line's
# Approach 2:
library(reshape)
df <- melt(economics[, c("date", "pce", "unemploy")], id="date")
ggplot(df) + geom_line(aes(x=date, y=value, color=variable)) + labs(title="Economics")# plot multiple time series by melting
#The disadvantage with ggplot2 is that it is not possible to get multiple Y-axis on the same plot. 
#To plot multiple time series on the same scale can make few of the series appear small. 
#An alternative would be to facet_wrap it and set the scales='free'.
df <- melt(economics[, c("date", "pce", "unemploy", "psavert")], id="date")
ggplot(df) + geom_line(aes(x=date, y=value, color=variable))  + facet_wrap( ~ variable, scales="free")

#Bar charts
plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar() + labs(title="Frequency bar chart")  
# Y axis derived from counts of X item
print(plot1)
#However, if you would like the make a bar chart of the absolute number
#given by Y aesthetic, you need to set stat="identity" inside the geom_bar.
df <- data.frame(var=c("a", "b", "c"), nums=c(1:3))
plot2 <- ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity")  # Y axis is explicit. 'stat=identity'
print(plot2)

# Custom layout
#The gridExtra package provides the facility to arrage multiple ggplots in a single grid.
library(gridExtra)
grid.arrange(plot1, plot2, ncol=2)

#Flipping coordinates #thsi flips the bar chart
df <- data.frame(var=c("a", "b", "c"), nums=c(1:3))
ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity") + coord_flip() + labs(title="Coordinates are flipped")

#Adjust X and Y axis limits
#There are 3 ways to change the X and Y axis limits.
#Using coord_cartesian(xlim=c(x1,x2))
#Using xlim(c(x1,x2))
#Using scale_x_continuous(limits=c(x1,x2))
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + coord_cartesian(ylim=c(0, 10000)) + labs(title="Coord_cartesian zoomed in!")
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + ylim(c(0, 10000)) + labs(title="Datapoints deleted: Note the change in smoothing lines!")

#Equal coordinate
ggplot(diamonds, aes(x=price, y=price+runif(nrow(diamonds), 100, 10000), color=cut)) + geom_point() + geom_smooth() + coord_equal()

#Change themes
#Apart from the basic ggplot2 theme, you can change the look and feel of your plots using one of these builtin themes.
theme_gray()
theme_bw()
theme_linedraw()
theme_light()
theme_minimal()
theme_classic()
theme_void()
#The ggthemes package provides additional ggplot themes that imitates famous magazines and softwares. Here is an example of how to change the theme.
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() +theme_bw() + labs(title="bw Theme")

#Legend - Deleting and Changing Position
#By setting theme(legend.position="none"), you can remove the legend. By setting it to ‘top’, i.e. theme(legend.position="top"), you can move the legend around the plot. By setting legend.postion to a co-ordinate inside the plot you can place the legend inside the plot itself. The legend.justification denotes the anchor point of the legend, i.e. the point that will be placed on the co-ordinates given by legend.position.

p1 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + theme(legend.position="none") + labs(title="legend.position='none'")  # remove legend
p2 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + theme(legend.position="top") + labs(title="legend.position='top'")  # legend at top
p3 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + labs(title="legend.position='coords inside plot'") + theme(legend.justification=c(1,0), legend.position=c(1,0))  # legend inside the plot.
grid.arrange(p1, p2, p3, ncol=3)  # arrange

#Grid lines
ggplot(mtcars, aes(x=cyl)) + geom_bar(fill='darkgoldenrod2') +
  theme(panel.background = element_rect(fill = 'steelblue'),
        panel.grid.major = element_line(colour = "firebrick", size=3),
        panel.grid.minor = element_line(colour = "blue", size=1))


#Plot margin and background
ggplot(mtcars, aes(x=cyl)) + geom_bar(fill="firebrick") + theme(plot.background=element_rect(fill="steelblue"), plot.margin = unit(c(2, 4, 1, 3), "cm")) # top, right, bottom, left

#Annotation
library(grid)
my_grob = grobTree(textGrob("This text is at x=0.1 and y=0.9, relative!\n Anchor point is at 0,0", x=0.1,  y=0.9, hjust=0,
                            gp=gpar(col="firebrick", fontsize=25, fontface="bold")))
ggplot(mtcars, aes(x=cyl)) + geom_bar() + annotation_custom(my_grob) + labs(title="Annotation Example")

#Saving ggplot
plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar()
ggsave("myggplot.png")  # saves the last plot.
ggsave("myggplot.png", plot=plot1)  # save a stored ggplot































































