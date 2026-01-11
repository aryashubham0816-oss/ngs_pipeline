#!/bin/bash

# Paths
DATA=../data
REF=../reference/reference_genome.fa
RESULTS=../results

mkdir -p $RESULTS/fastqc $RESULTS/alignment

echo "Running FastQC..."
fastqc $DATA/fastq_file.fastq -o $RESULTS/fastqc

echo "Running BWA alignment..."
bwa mem $REF $DATA/fastq_file.fastq > $RESULTS/alignment/sample.sam

echo "Converting SAM to BAM..."
samtools view -Sb $RESULTS/alignment/sample.sam > $RESULTS/alignment/sample.bam

echo "Sorting BAM..."
samtools sort $RESULTS/alignment/sample.bam -o $RESULTS/alignment/sample.sorted.bam

echo "Pipeline completed successfully!"
