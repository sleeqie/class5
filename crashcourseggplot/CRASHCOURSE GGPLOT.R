#SECTION 1
#TO INSTALL A PACKAGE
install.packages("car")  # install car package 
library(car)  # initialize the pkg 'car'
require(car)  # another way to initialize
library()  # see list of all installed packages
library(help=car)  # see info about 'car' pkg

#TO IMPORT AND EXPORT DATA
myData <- read.csv("c:/myInputData.csv", header=FALSE)  # import csv file
write.csv(rDataFrame, "c:/output.csv")  # export 

#REMOVE AND DELETE
a <- 10
b <- 20
ls()  # list objects in global env
rm(a)  # delete the object 'a'
rm(list = ls())  # caution: delete all objects in .GlobalEnv
gc()  # free system memory

#SECTION 2
#VECTORS
vec1 <- c(10, 20, 15, 40)  # numeric vector
vec2 <- c("a", "b", "c", NA)  # character vector
vec3 <- c(TRUE, FALSE, TRUE, TRUE)  # logical vector
vec4 <- gl(4, 1, 4, label = c("l1", "l2", "l3", "l4"))  # factor with 4 levels

#indexing vectors
length(vec1)  # 4
print(vec1[1])  # 10
print(vec1[1:3])  # 10, 20, 15

#Here is how to initialize a numeric vector:
numericVector <- numeric(100) # length 100 elements

#Manipulate vectors
#Subsetting
logic1 <- vec1 < 15  # create a logical vector, TRUE if value < 15
vec1[logic1]  # elements in TRUE positions will be included in subset
vec1[1:2]  # returns elements in 1 & 2 positions.
vec1[c(1,3)]  # returns elements in 1 & 3 positions
vec1[-1]  # returns all elements except in position 1.
#sorting 
sort(vec1)  # ascending sort
sort(vec1, decreasing = TRUE)  # Descending sort 
#Sorting can also be achieved using the order() function which returns the indices of elements in ascending order.
vec1[order(vec1)]  # ascending sort
vec1[rev(order(vec1))]  # descending sort
#Creating vector sequences and repetitions
#The seq() and rep() functions are used to create custom vector sequences. The rep() function can be used to repeat alphabets also.
seq(1, 10, by = 2)  # diff between adj elements is 2
seq(1, 10, length=25)  # length of the vector is 25
rep(1, 5)  # repeat 1, five times.
rep(1:3, 5)  # repeat 1:3, 5 times
rep(1:3, each=5)  # repeat 1 to 3, each 5 times.
#Remove missing values
#Missing values can be handles using the is.na() function which returns a logical vector with TRUE in positions where there is a missing value(NA)
vec2 <- c("a", "b", "c", NA)  # character vector
is.na(vec2)  # missing TRUE
!is.na(vec2)  # missing FALSE
vec2[!is.na(vec2)]  # return non missing values from vec2
#Sampling
set.seed(100)  # optional. set it to get same random samples.
sample(vec1)  # sample all elements randomly
sample(vec1, 3)  # sample 3 elem without replacement
sample(vec1, 10, replace=T)  # sample with replacement

#SECTION 3
#Dataframes
#Creating Data frame and accessing rows and columns
myDf1 <- data.frame(vec1, vec2)  # make data frame with 2 columns
myDf2 <- data.frame(vec1, vec3, vec4)
myDf3 <- data.frame(vec1, vec2, vec3)
myDf1
myDf2
myDf3
#Built-in Datasets and Basic Operations
library(datasets) # initialize
library(help=datasets) # display the datasets

#Using the airquality dataframe to show all the above discussed
class(airquality)  # get class
sapply(airquality, class)  # get class of all columns
str(airquality)  # structure
summary(airquality)  # summary of airquality
head(airquality)  # view the first 6 obs
fix(airquality)  # view spreadsheet like grid
rownames(airquality)  # row names
colnames(airquality)  # columns names
nrow(airquality)  # number of rows
ncol(airquality)  # number of columns
#Append data frames with cbind and rbind
#Lets append dataframes column wise cbind and row wise rbind.
cbind (myDf1, myDf2)  # columns append DFs with same no. rows
rbind(myDf1, myDf1)  # row append DFs with same no. columns

#Subset Data frame with number indices, subset() and which() methods
myDf1$vec1  # vec1 column
myDf1[, 1]  # df[row.num, col.num]
myDf1[, c(1,2)]  # columns 1 and 3
myDf1[c(1:5), c(2)]  # first 5 rows in column 2
#OR
#Subsetting rows and columns can also be done using subset() and with which() functions. 
subset(airquality, Day == 1, select = -Temp)  # select Day=1 and exclude 'Temp'
airquality[which(airquality$Day==1), -c(4)]  # same as above

print(airquality)
airquality[1,] #first columm of air quality
airquality[1]#first row of air quality
airquality[,1]

print(myDf1)
myDf1[1,] #first olumn of mydf1
myDf1[1] #first row of mydf1
myDf1[,1] #

#Sampling
#Sampling your data into training(data on which models are built) and test(known data on which models are tested) is a common activity.
set.seed(100)
trainIndex <- sample(c(1:nrow(airquality)), size=nrow(airquality)*0.7, replace=F)  # get test sample indices
airquality[trainIndex, ]  # training data
airquality[-trainIndex, ]  # test data

#merging dataframes
merge(myDf1, myDf2, by="vec1")  # merge by 'vec1'
merge(myDf1, myDf2)  # merge by 'vec1'
set.seed(100)
df1 = data.frame(StudentId = c(1:10), Subject = sample(c("Math", "Science", "Arts"), 10, replace=T))
df2 = data.frame(StudentNum = c(2, 4, 6, 12), Sport = sample(c("Football", "Tennis", "Chess"), 4, replace=T))
df1
df2
myd
#SECTION 4
#Paste function
paste("a", "b")  # "a b"
paste0("a", "b")  # concatenate without space, "ab"
paste("a", "b", sep="")  # same as paste0
paste(c(1:4), c(5:8), sep="")  # "15" "26" "37" "48"
paste(c(1:4), c(5:8), sep="", collapse="")  # "15263748"
paste0(c("var"), c(1:5))  # "var1" "var2" "var3" "var4" "var5"
paste0(c("var", "pred"), c(1:3))  # "var1" "pred2" "var3"
paste0(c("var", "pred"), rep(1:3, each=2))  # "var1" "pred1" "var2" "pred2" "var3" "pred3"

#Dealing with dates
dateString <- "15/06/2014"
myDate <- as.Date(dateString, format="%d/%m/%Y")
class(myDate)  # "Date"

#view contents
attributes(dateString)  # best
unclass(dateString)  # works!
names(dateString)  # doesn't work on a  object
unlist(dateString)  # works!
object.size(myDate)  

#contingency table
#Contingency tables gets you a count summary of a vector or 2 dimensional data. Let see how to get the count table for a vector.
table(df1)
table(airquality$Month[c(1:60)], airquality$Temp[c(1:60)]) # first 60/code>
table(df1[1,])
table(df1$StudentId)

#lists
myList <- list(vec1, vec2, vec3, vec4)
myList
#lists can have different levels within
myList[3] # level 1
myList[[3]]  # level 2: access the vec3 directly
myList[[3]][3]  # 3rd elem of vec3
lapply(myList, length)  # length of each element as a list
#Unlisting
unlist()  # flattens out into a one-level list.
unlist(myList)  # flattens out

#The apply family
#apply(): Apply FUN through a data frame or matrix by rows or columns.
myData <- matrix(seq(1,16), 4, 4)  # make a matrix
myData
apply(myData, 1, FUN=min) # apply 'min' by rows
#=> [1] 1 2 3 4

apply(myData, 2, FUN=min)  # apply 'min' by columns
#=> [1] 4 8 12 16

apply (data.frame(1:5), 1, FUN=function(x) {x^2})  # square of 1,2,3,4,5
      #=> [1] 1 4 9 16 25

#lapply(): Apply FUN to each element in a list(or) to columns of a data frame and return the result as a list
lapply(myData, class)  # return classes of each column in 'mydata' in a list

#sapply(): Apply FUN to each element of a list(or) to columns of a data frame and return the result as a vector.
sapply(myData, class)

#vapply(): Similar to sapply() but faster. You need to supply an additional FUN.VALUE argument that is a sample value of the returned output. A sample value could be character(0) for a string, numeric(0) or 0L for a number, logical(0) for a boolean.. and so on.
x <- list(a = 1, b = 1:3, c = 10:100)  # make a list
x
vapply(x, FUN = length, FUN.VALUE = 2L)  # FUN.VALUE defines a sample format of output

#Error Handling
options(show.error.messages = F)
1 <- 1
options(show.error.messages = T)
1 <- 1
#To handle the error
for(i in c(1:10)) {
  1 <- 1 # trigger the error
}
print(i) # i equals 1. Never ran through full loop

#Without the error handling feature, the loop is broken as soon as an error is encountered and the rest of the iterations are abruptly stopped. However, there are scenarios where you will want the loop to continue even if an error is encountered. This can be easily done by passing the error-prone function into a try() function. In this case, the loop continues to iterate even after it encounters an error.
for(i in c(1:10)) {
  triedOut <- try(1 <- 1) # try an error prone statement.
}
print(i) # i equals 10. Runs through full loop
#to check if an error occurred
class(triedOut) # "try-error

try(p<- 2)
triedin<-try(p<- 2)
class(triedin)

#Error handling with tryCatch()
tryCatch({1 <- 1; print("Lets create an error")}, # First block
         error=function(err){print(err); print("Error Line")},  # Second Block(optional)
         finally = {print("finally print this")})# Third Block(optional)
#=> [1] "Lets create an error"
#=> <simpleError in 1 <- 1: invalid(do_set) left-hand side to assignment>
#=> [1] "Error Line"
#=> [1] "finally print this"










