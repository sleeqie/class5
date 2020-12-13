#HOW TO USE PIECHART
df <- data.frame(
  group = c("Male", "Female", "Child"),
  value = c(25, 25, 50)) #created data frame
head(df) 
#Use a barplot to visualize the data :
library(ggplot2)
# Barplot
bp<- ggplot(df, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity")
bp
#Create a pie chart :
pie <- bp + coord_polar("y", start=0)
pie
# Use custom color palettes
pie + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# use brewer color palettes
pie + scale_fill_brewer(palette="Dark2")

pie + scale_fill_brewer(palette="Blues")+
  theme_minimal()
# Use grey scale
pie + scale_fill_grey() + theme_minimal()
#Create a pie chart from a factor variable:
head(PlantGrowth)
ggplot(PlantGrowth, aes(x=factor(1), fill=group))+
  geom_bar(width = 1)+
  coord_polar("y")
#Customized pie charts
#Create a blank theme :
blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )
#Apply the blank theme. Remove axis tick mark labels. Add text annotations : The package scales is used to format the labels in percent




















#Example of thus learnt so far
data.frame(iris)
flower <- data.frame(iris)
flower
library(ggplot2)
ggplot(flower, aes(x=Sepal.Length, y=Sepal.Width))
ggplot(flower, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()+ geom_smooth()

#plain code
ggplot(flower, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  geom_smooth() +
  coord_cartesian() +
  scale_color_gradient() +
  theme_classic()

#filled the plain code up:
data.frame(diamonds)
Diamond50<-head(diamonds, 50)
Diamond50
D50<-ggplot(Diamond50, aes(x=carat, y=price)) +
  geom_point(aes(col=cut)) +
  geom_smooth(aes(col= "yellow"), method = "lm") +
  coord_cartesian() +
  theme_gray() + scale_color_brewer(palette ="Set1") + 
  labs(title = "Price vs carat", subtitle = "First 50 Dataset", caption = "CaratCut")
plot(D50)
D50 + scale_y_reverse()
ggsave("plot.png", width = 5, height = 5)

#Exploring various stuff
#a and b are graphical primitives
a <- ggplot(seals, aes(x = long, y = lat))
b <- ggplot(economics, aes(date, unemploy))
plot(a)
plot(b)
a + geom_blank() #to expand
a + geom_curve(aes(yend = lat + delta_lat, 
                   xend = long + delta_long)) #x, xend, y, yend, alpha, angle, color, curvature, linetype, size
b + geom_path(lineend="butt",
              linejoin="round", linemitre=1)#x, y, alpha, color, group, linetype, size
b + geom_polygon(aes(group = 2, col="yellow"))#x, y, alpha, color, fill, group, linetype, size 
a + geom_rect(aes(xmin = long, ymin = lat,
                  xmax= long + delta_long, ymax = lat + delta_lat))
a + geom_step()
#c is one varible; continous.
c<- ggplot(mpg, aes(hwy)) 
c
c+ geom_area(stat = "bin") 
c + geom_dotplot()
c + geom_histogram()
c + geom_freqpoly()
c + geom_density()
#d is one discrete variable
d <- ggplot(mpg, aes(fl))
d + geom_bar()
#two variables, both continous
e <- ggplot(mpg, aes(cty, hwy))
e + geom_label(aes(label = cty), nudge_x = 1,
                 nudge_y = 1, check_overlap = TRUE)
e + geom_jitter(height = 2, width = 2)
e + geom_point()
e + geom_quantile()
e + geom_text(aes(label = cty), nudge_x = 1,
               nudge_y = 1, check_overlap = TRUE)
e + geom_rug(sides = "bl")
#Discrete X, Continuous Y
f<- ggplot(mpg, aes(class, hwy))
f + geom_bar(stat= "identity")
f + geom_boxplot(aes(col= "red")) + labs(title = "hwy vs class") + theme_classic()
f + geom_dotplot(binaxis = "y", stackdir = "center")
f + geom_violin(aes(col= manufacturer),scale = "area")

# two variables, both discrete discrete X and Y
g <- ggplot(diamonds, aes(cut, color))
g + geom_count()

#Continous Bivariate distribution
h <- ggplot(diamonds, aes(carat, price))
h + geom_bin2d(aes(col=cut), binwidth = c(0.25, 500))
h + geom_density2d()
h+geom_hex()
#continous function
i <- ggplot(economics, aes(date, unemploy))
i + geom_area()
i + geom_line()
i + geom_step(direction = "hv")

#visualizing error
df <- data.frame(grp = c("A", "B"), fit = 4:5, se = 1:2)
j <- ggplot(df, aes(grp, fit, ymin = fit-se, ymax = fit+se))
j + geom_crossbar(fatten = 2)
j + geom_errorbar()
j + geom_linerange()
j + geom_pointrange()

#Maps
data <- data.frame(murder = USArrests$Murder, state = tolower(rownames(USArrests)))
map <- map_data("state")
k <- ggplot(data, aes(fill = murder))
k + geom_map(aes(map_id = state), map = map) +
  expand_limits(x = map$long, y = map$lat)

#Three variables
seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2))
l <- ggplot(seals, aes(long, lat))

l + geom_contour(aes(z = z))
l + geom_raster(aes(fill = z), hjust=0.5,
                vjust=0.5, interpolate=FALSE)
l + geom_tile(aes(fill = z))

#SCALES.
#To customize a discrete bar chart
d <- ggplot(mpg, aes(fl))
d
n <- d + geom_bar(aes(fill = fl))
n
n + scale_fill_manual(
  values = c("skyblue", "royalblue", "blue", "navy"), 
  limits = c("d", "e", "p", "r"), 
  breaks =c("d", "e", "p", "r"), 
  name = "fuel", labels = c("D", "E", "P", "R"))

#General Purpose scales
#Use with any aesthetic: alpha, color, fill, linetype, shape, size
scale_continuous() #- map cont’ values to visual values 
scale_discrete() #- map discrete values to visual values 
scale_identity() #- use data values as visual values 
scale_manual(values = c()) #- map discrete values to manually chosen visual values

#X and Y location scales
#Use with x or y aesthetics (x shown here)
scale_x_date(date_labels = "%m/%d") date_breaks = "2 weeks") #- treat x values as dates.
#See ?strptime for label formats. 
scale_x_datetime() #- treat x values as date times. Use same arguments as scale_x_date(). 
scale_x_log10() #- Plot x on log10 scale scale_x_reverse() - Reverse direction of x axis scale_x_sqrt() - Plot x on square root scale

#Color and fill scales

#Faceting
t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t
t + facet_grid(. ~ fl)











































