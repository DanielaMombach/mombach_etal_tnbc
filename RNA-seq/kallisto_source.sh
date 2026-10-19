# kallisto quant

# For paired-end
kallisto quant -i TEscape_Gencove_v36.idx -o reads/CTL -t 8 reads/CTL_R1.fastq reads/CTL_R2.fastq 2> reads/log.txt;

# For single-end 
kallisto quant -i TEscape_Gencove_v36.idx -o reads/CTL --single -l 75 -s 0.00000001 -t 8 reads/CTL.fastq 2> reads/log.txt;
