#!/usr/bin/env bash
echo "Enter the path containing the reads for analysis:"
read reads
echo "Enter the path for the database:"
read database
echo "Enter the path for the results of the pipeline:"
read output_loc

nextflow run Pipeline-16S -profile docker --reads "{$reads}/*_{1,2}.fastq.gz" --referenceAln "{$database}/silva.seed_v138_1.align" --referenceTax "{$database}/silva.seed_v138_1.tax" --outdir "{$output_loc}" --cpus 6
