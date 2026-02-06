process post_trim_qc {
    tag "trimmed_qc"
    publishDir "${params.outdir}/fatsqc/trimmed",mode : 'symlink'

    input : 
    path trimmed 

    output:
    path "*_fastqc.{html,zip}"

    script:
    """

    ${params.fastqc} ${trimmed}
    """ 
}