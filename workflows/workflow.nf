include { fastqc_raw_reads }      from '../modules/fastqc_raw_reads'
include {  trim_fastq}      from '../modules/trim_fastq'
include { post_trim_qc }  from '../modules/post_trim_qc'
include { read_alignment }     from '../modules/read_alignment'
include { convert_sam_bam }      from '../modules/convert_sam_bam'
include { bam_sort_index }  from '../modules/bam_sort_index'
include { variant_analysis } from '../modules/variant_analysis'
include { multiqc_report }         from '../modules/multiqc_report'


workflow MY_PIPELINE_A {
    take:
        fastq_input
        ref_input

    main:
        raw_qc = fastqc_raw_reads(fastq_input)
        trimmed_fq = trim_fastq(fastq_input)
        trimmed_qc = post_trim_qc(trimmed_fq)
        aligned = read_alignment(trimmed_fq, ref_input)
        bam = convert_sam_bam(aligned)
        sorted_outputs = bam_sort_index(bam)
        variant_analysis(sorted_outputs.sorted_bam,sorted_outputs.bai, ref_input)

        all_qc_logs = raw_qc.mix(trimmed_qc).collect()
        multiqc_report(all_qc_logs)
}
