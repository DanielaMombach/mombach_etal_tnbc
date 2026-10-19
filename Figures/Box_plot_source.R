library(ggplot2)

# Read the input file
data <- read.table("gene_tpm_table.tsv", header = TRUE, sep = "\t")

# Define cell lines
cell_lines <- c("mdamb468", "bt549", "sum1315", "mdamb436")

# Loop over each gene
for (i in 1:nrow(data)) {
  gene_row  <- data[i, ]
  gene_name <- gene_row$index
  
  # Build long-format data frame for plotting
  df <- data.frame(value = numeric(), condition = character(), cell_line = character())
  for (cl in cell_lines) {
    controls   <- as.numeric(gene_row[, control_cols[[cl]]])
    treatments <- as.numeric(gene_row[, treatment_cols[[cl]]])
    df_cl <- data.frame(
      value     = c(controls, treatments),
      condition = rep(c("Control", "Treatment"), c(length(controls), length(treatments))),
      cell_line = cl
    )
    df <- rbind(df, df_cl)
  }
  
  df$cell_line <- factor(df$cell_line, levels = cell_lines)
  
  # Boxplot
  p <- ggplot(df, aes(x = cell_line, y = value, fill = condition)) +
    geom_boxplot(position = position_dodge(0.75)) +
    scale_fill_manual(values = c("Control" = "#8fc4afff", "Treatment" = "#c8ae3dff")) +
    labs(title = gene_name, x = "Cell Line", y = "TPM") +
    theme_minimal() +
    theme(
      panel.background = element_rect(fill = "white", colour = "white"),
      plot.background  = element_rect(fill = "white", colour = "white")
    )
  
  print(p)
  
  ggsave(filename = paste0(gene_name, ".png"), plot = p,
         width = 7, height = 5, dpi = 300)
}

