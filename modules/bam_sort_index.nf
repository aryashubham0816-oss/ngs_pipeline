process bam_sort_index {
    tag "sort_index"
    publishDir "${params.outdir}/bam", mode: 'symlink'

    input:
    path bam

    output:
    path "bam_sort_index.bam", emit: sorted_bam
    path "bam_sort_index.bam.bai", emit: bai

    script:
    """
    ${params.samtools} sort $bam -o bam_sort_index.bam
    ${params.samtools} index bam_sort_index.bam
    """
}