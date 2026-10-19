library(ggplot2)
library(ggrepel)
library(tidyverse)
library(ggpubr)

mytheme <- theme(plot.background = element_rect(fill = "white", color = "white"),
                 text = element_text(family = "ArialMT", face = "plain", size = rel(1), colour = "black"),
                 axis.title = element_text(family = "ArialMT", size = rel(4),
                                           vjust = 1, hjust = .5, face = "bold", colour = "black"),
                 axis.text = element_text(family = "ArialMT", size = rel(3),
                                          face = "bold", hjust = 0.5, vjust = .5, colour = "black"),
                 plot.title = element_text(family = "ArialMT", size = rel(4),
                                           vjust = 2, hjust = 0.5, face = "bold", lineheight = 1, colour = "black"),
                 plot.subtitle = element_text(family = "ArialMT", size = rel(3.5),
                                              vjust = 2, hjust = 0.5, face = "italic", lineheight = 1, colour = "black"),
                 legend.text = element_text(family = "ArialMT",
                                            colour = "black", size = rel(10), face = "plain"),
                 legend.title = element_text(family = "ArialMT",
                                             colour = "black", size = rel(12), face = "bold"),
                 axis.ticks = element_line(size = .5, colour = "black"),
                 axis.line = element_line(size = .5, colour = "black"))


# MA Plot ARGs
fdr <- .05
l2fc <- 4  # 2 | 4 (L2FC = 1 | 2)

# Tabe ARGs
ext <- ".tsv"
sep <- "\t"

data <- as.data.frame(read.delim(file = paste(wd, "/deseq", ext, sep = ""),
                                 header = T, sep = sep, check.names = F, dec = ".", na.strings = nas))

## Specifies if the genes are expressed (1) or not (0)
data[["detection_call"]] <- 1
plot_table <- data

MA_plot <- ggmaplot(plot_table, fdr = fdr, fc = l2fc, size = 3, alpha = .3,
                    palette = c("#1465AC", "#B31B21", "darkgray"), top = 0,
                    legend = c(.9, .2),
                    genenames = as.vector(plot_table[["gene.symbol"]]), label.select = topALL,
                    font.label = c("plain", 10), label.rectangle = T, font.legend = c(10, "plain", "black"),
                    font.main = c(12, "bold", "black"),
                    font.x = c(14, "bold", "black"), font.y = c(14, "bold", "black"),
                    font.tickslab = c(12, "plain", "black"), legend.title = "DEG Status",
                    ggtheme = ggplot2::theme_minimal()) +
  theme(plot.title = element_text(vjust = 2, hjust = 0.5)) + mytheme +
  scale_y_continuous(name = "Log 2-Fold Change",
                     limits = c((ceiling(x = abs(min(plot_table[["log2FoldChange"]])))*(-1)),
                                ceiling(x = max(plot_table[["log2FoldChange"]]))),
                     breaks = seq((ceiling(x = abs(min(plot_table[["log2FoldChange"]])))*(-1)),
                                  ceiling(x = max(plot_table[["log2FoldChange"]])),
                                  by = ceiling(x = ((max(plot_table[["log2FoldChange"]]) -
                                                       min(plot_table[["log2FoldChange"]])) / 5))),
                     expand = c(.1,.1)) +
  scale_x_continuous(name = "Log2 of Average Expression (TPM)",
                     limits = c(ceiling(x = abs(min(log2(x = plot_table[["baseMean"]])))), 
                                ceiling(x = max(log2(x = plot_table[["baseMean"]])))),
                     breaks = seq(0, ceiling(x = max(log2(x = plot_table[["baseMean"]]))),
                                  by = ceiling(x = (ceiling(x = max(log2(x = plot_table[["baseMean"]]))) / 5))),
                     expand = c(.1,.1)) +
  scale_color_manual(name = "DEG Status",
                     labels = c(paste("UP: ", nrow(sort_table[sort_table[["log2FoldChange"]] > 0,]), sep = ""),
                                paste("DOWN: ", nrow(sort_table[sort_table[["log2FoldChange"]] < 0,]), sep = ""),
                                paste("NS: ", (nrow(plot_table) - nrow(sort_table)), sep = "")),
                     breaks = c(paste("Up: ", nrow(sort_table[sort_table[["log2FoldChange"]] > 0,]), sep = ""),
                                paste("Down: ", nrow(sort_table[sort_table[["log2FoldChange"]] < 0,]), sep = ""),
                                "NS"),
                     values = c("#1465AC", "#B31B21", "darkgray"))

MA_plot$layers[[3]]$aes_params$colour <- c("black", "black", "black")

for (format in formats)
{
  ggsave(filename = paste("MAPlot_mb.", toupper(format), sep = ""),
         plot = MA_plot, device = format, path = paste(wd, "/figures", sep = ""),
         scale = 1, units = "in", limitsize = T, dpi = dpi, width = 10, height = 7)
}
