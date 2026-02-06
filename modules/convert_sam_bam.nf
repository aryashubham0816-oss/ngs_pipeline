process convert_sam_bam {
    tag "sam_to_bam"
    publishDir "${params.outdir}/bam", mode: 'symlink'

    input:
    path sam

    output:
    path "convert_sam_bam.bam"

    script:
    """
    ${params.samtools} view -Sb ${sam} > convert_sam_bam.bam
    """
}