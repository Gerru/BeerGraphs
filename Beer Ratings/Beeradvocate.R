library(XML)
theurl <- "http://www.beeradvocate.com/lists/top/"
tables <- readHTMLTable(theurl)
tblcount <- length(tables)

n_rows <- unlist(lapply(tables, function(t) dim(t)[1]))



http://www.beeradvocate.com/lists/top/