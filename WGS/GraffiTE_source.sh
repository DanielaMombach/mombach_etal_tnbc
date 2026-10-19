# Run GraffiTE
nextflow run https://github.com/cgroza/GraffiTE \
   --tsd_win 10 \
   --cores 20 \
   --mammal \
   --longreads longreads.csv \
   --TE_library graffite.fasta \
   --reference hg38.25chr.fa \
   --graph_method graphaligner \
   --reads longreads.csv
