## Variant Calling Pipeline using Nextflow

This repository hosts a modular single-end variant calling pipeline built with Nextflow (DSL2). It processes raw sequencing reads to detect SNPs and small INDELs through read alignment and variant calling, with each analysis step implemented as an independent, reusable module.

---

## Quick Start

```bash
# Clone the repository
git clone <repository_url>
cd <repository_name>

# Create the Conda environment for pipeline tools
conda env create -f environment.yml

# Activate the Conda environment that runs Nextflow
conda activate bnf

# Run the pipeline
nextflow run main.nf

Resume a previous run:

```bash

nextflow run main.nf -resume
```

---


#Pipeline Overview
The pipeline performs the following major steps:

1.Quality control of raw reads
2.Adapter trimming
3.Quality control of trimmed reads
4.Read alignment to a reference genome
5.SAM to BAM conversion
6.BAM sorting and indexing
7.Variant calling
8.Aggregation of QC reports using MultiQC

---

##Repository Structure

```
NEXT_FLOW_PIPELINE/
├── data/
│   └── Sample1.fastq
├── modules/
│   ├── fastqc_raw_reads.nf
│   ├── trim_fastq.nf
│   ├── post_trim_qc.nf
│   ├── read_alignment.nf
│   ├── convert_sam_bam.nf
│   ├── bam_sort_index.nf
│   ├── variant_analysis.nf
│   └── multiqc_report.nf
├── reference/
│   └── chr22.fa
├── results/
│   ├── alignment/
│   ├── bam/
│   ├── fastqc/
│   ├── multiqc/
│   ├── trimmed/
│   └── variantcalling/
├── workflows/
│   └── workflow.nf
├── main.nf
├── nextflow.config
├── environment.yml
├── work/
├── .gitignore
├── .nextflow.log
└── README.md


## Input Files
**Sequencing Data**

Single-end FASTQ file

```
data/Sample1.fastq
```

##Reference Genome

**FASTA format reference genome**

```
reference/chr22.fa
```

---

##Tools and Software Used
* **Nextflow (DSL2) – Workflow orchestration**
* **FastQC – Quality control of sequencing reads**
* **Cutadapt – Adapter trimming**
* **BWA – Read alignment**
* **SAMtools – Alignment processing**
* **BCFtools – Variant calling**
* **MultiQC – Aggregation of QC reports**

All tools are installed reproducibly using Conda via environment.yml.
Nextflow automatically manages tool execution for each process.

---
### Environment Setup

###Prerequisites

*Conda / Miniconda
*Nextflow
*Git

---

### Create the Conda Environment
conda env create -f environment.yml
```

This creates the Conda environment:

bnf

###Activate the Environment

bash 
conda activate bnf

###Verify Installation

bash
nextflow -version

### Pipeline Steps (Detailed)
### 1. Raw Read Quality Control

Tool: FastQC

Module: fastqc_raw_reads.nf

Description: Performs quality assessment of raw FASTQ reads

Output:

FastQC HTML report

FastQC ZIP file

### 2. Adapter Trimming

Tool: Cutadapt

Module: trim_fastq.nf

Description: Removes adapter sequences from raw reads

Output:

Trimmed FASTQ file

### 3. Post-Trimming Quality Control

Tool: FastQC

Module: post_trim_qc.nf

Description: Evaluates read quality after trimming

Output:

FastQC reports for trimmed reads

### 4. Read Alignment

Tool: BWA-MEM

Module: read_alignment.nf

Description: Aligns trimmed reads to the reference genome

Output:

SAM alignment file

### 5. SAM to BAM Conversion

Tool: SAMtools

Module: convert_sam_bam.nf

Description: Converts SAM files to BAM format

Output:

BAM file

### 6. BAM Sorting and Indexing

Tool: SAMtools

Module: bam_sort_index.nf

Description: Sorts BAM files and generates index files

Output:

Sorted BAM file

BAM index file (.bai)

### 7. Variant Calling

Tool: BCFtools

Module: variant_analysis.nf

Description: Identifies SNPs and small INDELs

Output:

Variant Call Format file (.vcf)

### 8. MultiQC Report

Tool: MultiQC

Module: multiqc_report.nf

Description: Aggregates all QC outputs into a single report

Output:

multiqc_report.html

### Output Files

## All outputs are written to the results/ directory:

*FastQC reports (raw and trimmed reads)
*Trimmed FASTQ file
*SAM alignment file
*Sorted and indexed BAM files
*Variant call file (.vcf)
*MultiQC summary report

---

### Configuration
Key Parameters Defined in main.nf :

```nextflow
params.fastq   = "data/exom.fastq"
params.ref     = "reference/reference.fa"
params.outdir  = "results"
params.adapter = "AGATCGGAAGAGC"
```

### Resource Settings in nextflow.config :

CPUs: 2
Memory: 2 GB
Error strategy: retry
Max retries: 3

### How to Run the Pipeline
nextflow run main.nf

**Resume Execution**
nextflow run main.nf -resume

### Version Control and GitHub Usage

### Tracked by Git

* .nf pipeline scripts
* nextflow.config
* environment.yml
* README.md

### Files excluded from Git
## Ignored via .gitignore

* work/
* .nextflow/
* results/
* Log files

---

## Push the Pipeline to GitHub
git init
git add .
git commit -m "Add modular Nextflow variant calling pipeline"
git branch -M main
git remote add origin <repository_url>
git push -u origin main

## Notes

* Intermediate files are stored in work/
* Output files are excluded from version control
* Conda environments are not committed
* Pipeline currently supports single-end sequencing data