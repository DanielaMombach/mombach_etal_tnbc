# TXimport
dir <- "./reads"

samples <- read.table(file.path(dir, "samples.txt"), header = TRUE)

# create tx2gene
tx2gene <- read.csv("../tx2gene.tsv", sep="\t")
tx2gene

# for kallisto
library(tximport)
files <- file.path(dir, samples$run, "quant.tsv")
files
names(files) <- paste0("sample", 1:6)
files
txi.kallisto <- tximport(files, type = "kallisto", tx2gene = tx2gene)
head(txi.kallisto$counts)
write.table(txi.kallisto, file="txi.tsv", sep = "\t")
