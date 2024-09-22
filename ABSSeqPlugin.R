library(ABSSeq)
#data(simuN5)
#write.csv(simuN5$counts, "counts.csv")
#write.csv(simuN5$groups, "groups.csv")

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")


input <- function(inputfile) {
        pfix <<- prefix()
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
}

run <- function() {}

output <- function(outputfile) {
counts <- read.csv(paste(pfix, parameters["counts", 2], sep="/"))
counts <- counts[,-1]
groups <- read.csv(paste(pfix, parameters["groups", 2], sep="/"))
groups <- groups[,-1]
obj <- ABSDataSet(counts=counts, groups=factor(groups))
#obj <- ABSDataSet(counts=simuN5$counts, groups=factor(simuN5$groups))
obj <- ABSSeq(obj)
res <- results(obj,c("Amean","Bmean","foldChange","pvalue","adj.pvalue"))
write.csv(res, outputfile)
}
