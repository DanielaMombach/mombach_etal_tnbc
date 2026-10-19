library("pheatmap")

test = read.csv('table.tsv', sep="\t", row.names = "index")

# Apply log2 transformation
test_log2 <- log2(test + 1)

# Annotations for columns from file
annotation_col = read.csv("anot_heatmap.txt", sep="\t", row.names = 'names')

# Colors
my_palette <- colorRampPalette(c("#c8ae3dff", "#f7f7f7", "#8fc4afff"))(100)

# Draw heatmap without saving via filename
pheatmap(test_log2,
         scale = "row", 
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         show_colnames = FALSE,
         show_rownames = TRUE,
         cutree_cols = 5,
         cutree_rows = 3,
         treeheight_col = 20,
         treeheight_row = 20,
         angle_col = "45",
         annotation_col = annotation_col, 
         annotation_legend = TRUE,
         color = my_palette,
         border_color = "black",
         fontsize_row = 10)
