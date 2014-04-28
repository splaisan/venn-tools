#!/usr/bin/RScript

# Plots a 2D VENN from precomputed data
# usage: 2Dvenn.R -a A-cnt -b B-cnt -i AB-cnt -A A-label -B B-label -t "My Title" -o myVenn.png -U 2

# counts are epected in the order
# "10","11","01"
# extra arguments: A-label B-label Title (opt)
#
# Stephane Plaisance VIB-BITS April-11-2014 v1.0


# required R-packages
# once only install.packages("grid")
# once only install.packages("optparse")
# once only install.packages("colorfulVennPlot")
suppressPackageStartupMessages(library("optparse"))
suppressPackageStartupMessages(library("grid"))
suppressPackageStartupMessages(library("colorfulVennPlot"))

#####################################
### Handle COMMAND LINE arguments ###
#####################################

# parameters
#  make_option(c("-h", "--help"), action="store_true", default=FALSE,
#              help="plots a 2D VENN from precomputed data")

option_list <- list(
  make_option(c("-a", "--a.count"), type="integer", default=0,
              help="counts for A-only"),
  make_option(c("-b", "--b.count"), type="integer", default=0, 
              help="counts for B-only"),
  make_option(c("-i", "--ab.count"), type="integer", default=0, 
              help="counts for AB-intersect"),
  make_option(c("-A", "--a.label"), type="character", default="A",
              help="label for A"),  
  make_option(c("-B", "--b.label"), type="character",, default="B", 
              help="label for B"), 
  make_option(c("-t", "--title"), type="character",
              help="Graph Title"),
  make_option(c("-o", "--file"), type="character", default="2Dvenn.png",
              help="file name for output [default: %default]"),
  make_option(c("-u", "--fill"), type="character", default="3",
              help="fill with 1:colors, 2:greys or 3:white [default: %default]")    )

# PARSE OPTIONS
opt <- parse_args(OptionParser(option_list=option_list))

# check if arguments provided
if (length(opt) > 1) {
# do some operations based on user input

# colors (3)
ncol <- 3
my.colors <- rainbow(ncol)
my.greys <- rev(gray(0:32 / 32))[1:ncol]
my.whites <- rep("#FFFFFF", ncol)
my.fill <- ifelse( rep(opt$fill=="1", ncol), 
				my.colors, 
				(ifelse(rep(opt$fill=="2",ncol), my.greys, my.whites))
				)
				
# title
my.title <- ifelse(!is.null(opt$title), opt$title, "") 

# format
if (opt$format==1){
# png
filename <- paste(opt$file, ".png", sep="")
png(file = filename, bg = "transparent")

} else {
# pdf
filename <- paste(opt$file, ".pdf", sep="")
pdf(file = filename, 
	bg = "white")
}

# plot
plot.new()
plotVenn2d(c(opt$a.count, opt$b.count, opt$ab.count), 
           labels = c(opt$a.label, opt$b.label),
           Colors = my.fill,
           Title = my.title, 
           shrink = 1, rot=180, radius= c(1,1), resizePlot = 1, 
           reverseLabelOrdering=TRUE)
dev.off()
}
