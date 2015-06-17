library(XML)
theurl <- "http://en.wikipedia.org/wiki/List_of_Belgian_beer"
tables <- readHTMLTable(theurl)
tblcount <- length(tables)

n_rows <- unlist(lapply(tables, function(t) dim(t)[1]))

col_names <- colnames(tables[[2]])
col_names[3] <- "ABV"

i <- 2
beerdf <- read.table(text = "", col.names = col_names)

for (i in 2:tblcount)
  {
    if (colnames(tables[[i]][1]) == "Brand") {
      beerdf <- rbind(beerdf, tables[[i]])
    }
    i <- i + 1
  }

colnames(beerdf) <- col_names

beerdf$ABV2 <- as.numeric(as.numeric(gsub("%", "", beerdf$ABV)))

# Finding the NA values 
nobeer <- beerdf[!complete.cases(beerdf),]
newbeer <- na.omit(beerdf)

head(newbeer[order(newbeer$ABV2),], 20)
head(newbeer[order(-newbeer$ABV2),], 20)


hist(newbeer$ABV2)

library(ggplot2)
qplot(ABV2, data=beerdf, geom="histogram")

qplot(beerdf$ABV2,
      geom="histogram",
      binwidth = 0.5,  
      main = "Histogram for Belgian Beers' Alcohol Percentage Value", 
      xlab = "Alcohol by Volume",  
      fill=I("orange"), 
      col=I("red"), 
      #alpha=I(.2),
      xlim=c(0,15))


m <- ggplot(beerdf, aes(x=ABV2))
m + geom_histogram(binwidth = 0.5, aes(fill = ..count..)) + 
  scale_fill_gradient("Count", low = "orange", high = "orange") + 
  xlim(c(0,15))