library(ggplot2)
library(dplyr)
library(gapminder)

# Load data
data <- read.table('bubble_plot.tsv', header = TRUE, sep='\t') 

# Define custom color palette
my_palette <- colorRampPalette(c("#c8ae3dff", "#f7f7f7", "#8fc4afff"))(100)

# Create bubble plot with custom palette
plot <- data %>%
  ggplot(aes(x = genes, y = pathway, size = enrichment, color = FDR)) +
  geom_point(alpha = 0.5) +
  scale_size(range = c(.1, 24), name = "Enrichment") +
  scale_color_gradientn(colors = my_palette, name = "FDR") + 
  scale_x_continuous(breaks = seq(min(data$genes), max(data$genes), by = 2)) +
  theme_light()

# Save as PNG
ggsave("figures/bubble_plot.png", plot, width = 6, height = 6)
