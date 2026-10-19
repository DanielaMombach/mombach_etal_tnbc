#!/bin/bash

# Set base directories
INPUT_DIR="alignment"
L1EM_DIR="L1EM"
GENOME="hg38.fa"
OUTPUT_BASE="results"


for bam_file in "$INPUT_DIR"/*.sorted.bam; do
    filename=$(basename "$bam_file" .sorted.bam)
    SAMPLE_DIR="$OUTPUT_BASE/$filename"
    mkdir -p "$SAMPLE_DIR"
    
    # Change to sample directory and run the script
    cd "$SAMPLE_DIR"
    bash -e "$L1EM_DIR/run_L1EM.sh" "$bam_file" "$L1EM_DIR" "$GENOME"
    
    cd -
done
