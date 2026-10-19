# DESeq2 in R
library(DESeq2)

## Input count table
counttable = read.csv("counts.tsv", header = TRUE, row.names = 1, sep = "\t")

# Filter rows either the control triplicate or treatment triplicate different than 0
counttable = counttable[apply(counttable, 1, function(row) (all(row[1:3] != 0) | all(row[4:6] != 0))), ]

## colData creation
condition = c("control","control","control","treatment","treatment","treatment")
colData = data.frame(row.names=colnames(counttable), treatment=factor(condition, levels=c("control","treatment")))

## Differential expression analysis
dataset <- DESeqDataSetFromMatrix(countData = round(counttable), colData = colData, design = ~treatment)
dds = DESeq(dataset)
result = results(dds)
write.table(result, file="deseq.tsv", sep = "\t")
