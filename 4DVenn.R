#!/usr/bin/RScript

# plots a 4D VENN from precomputed data
# usage: 4Dvenn.R -a .. to .. -u (see below)

# counts are expected in the order
# "0100","0010","0110",1100",
# "0011","1000","1110","0111",
# "0001","1111","1010","0101",
# "1001" 
# the order is arbitrary, from top to bottom and from left to right
# extra arguments: A-label B-label C-label D-label Title (opt)

# example command:
# 4DVenn.R -A 1 -B 2 -C 3 -D 4 -E 5 -F 6 -G 7 -H 8 -I 9 
#   -J 10 -K 11 -L 12 -M 13 -N 14 -O 15 
#   -P "grA" -Q "grB" -R "grC" -S "grD" -T "4way-Venn" -o "4way.png"
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
option_list <- list(
  make_option(c("-a", "--a.count"), type="integer", default=0,
              help="counts for A-only [default: %default]"),
  make_option(c("-b", "--b.count"), type="integer", default=0,
              help="counts for B-only [default: %default]"),
  make_option(c("-c", "--c.count"), type="integer", default=0, 
              help="counts for C-only [default: %default]"),
  make_option(c("-d", "--d.count"), type="integer", default=0, 
              help="counts for D-only [default: %default]"),  
  make_option(c("-e", "--ab.count"), type="integer", default=0,
              help="counts for AB-intersect [default: %default]"),  
  make_option(c("-f", "--ac.count"), type="integer", default=0,
              help="counts for ACB-intersect [default: %default]"),   
  make_option(c("-G", "--ad.count"), type="integer", default=0,
              help="counts for AD-intersect (! use G and not g, due to a bug in RScript) [default: %default]"), 
  make_option(c("-j", "--bc.count"), type="integer", default=0,
              help="counts for BC-intersect [default: %default]"), 
  make_option(c("-k", "--bd.count"), type="integer", default=0,
              help="counts for BD-intersect [default: %default]"), 
  make_option(c("-l", "--cd.count"), type="integer", default=0,
              help="counts for CD-intersect [default: %default]"),  
  make_option(c("-m", "--abc.count"), type="integer", default=0,
              help="counts for ABC-intersect [default: %default]"), 
  make_option(c("-n", "--abd.count"), type="integer", default=0,
              help="counts for ABD-intersect [default: %default]"),  
  make_option(c("-p", "--acd.count"), type="integer", default=0,
              help="counts for ACD-intersect [default: %default]"), 
  make_option(c("-q", "--bcd.count"), type="integer", default=0,
              help="counts for BCD-intersect [default: %default]"),  
  make_option(c("-i", "--abcd.count"), type="integer", default=0,
              help="counts for ABCD-intersect [default: %default]"), 
  make_option(c("-A", "--a.label"), type="character", default="A", 
              help="label for A [default: %default]"),
  make_option(c("-B", "--b.label"), type="character", default="B", 
              help="label for B [default: %default]"),
  make_option(c("-C", "--c.label"), type="character", default="C", 
              help="label for C [default: %default]"),
  make_option(c("-D", "--d.label"), type="character", default="D", 
              help="label for D [default: %default]"),
  make_option(c("-t", "--title"), type="character",
              help="Graph Title [default: null]"),
  make_option(c("-x", "--format"), type="integer", default=1,
              help="file format for output 1:PNG, 2:PDF [default: %default]"),
  make_option(c("-o", "--file"), type="character", default="4Dvenn",
              help="file name for output [default: %default]"),
  make_option(c("-u", "--fill"), type="character", default="3",
              help="fill with 1:colors, 2:greys or 3:white [default: %default]")          
)

# PARSE OPTIONS
opt <- parse_args(OptionParser(option_list=option_list))

# check if arguments provided
if (length(opt) > 1) {

# data
y=c(opt$b.count, opt$c.count,
    opt$bc.count,
    opt$ab.count, opt$cd.count,
    opt$a.count, opt$abc.count, opt$bcd.count, opt$d.count,
    opt$abcd.count,
    opt$ac.count, opt$bd.count,
    opt$acd.count, opt$abd.count,
    opt$ad.count)

names(y) <- c("0100","0010",
              "0110",
              "1100","0011",
              "1000","1110","0111","0001",
              "1111",
              "1010","0101",
              "1011","1101",
              "1001")

# labels
labels <- c(opt$a.label, opt$b.label, opt$c.label, opt$d.label)

# colors (15)
ncol <- 15
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
plotVenn4d(y, 
          labels,
          Colors = my.fill, 
          Title = my.title)
dev.off()
}
