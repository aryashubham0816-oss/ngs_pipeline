process trim_fastq{
    tag "trimming"
    publishDir "${params.outdir}/trimmed",mode: 'symlink'

    input:
    path fastq

    output:
    path "trim_fastq.fastq"

    script:
    """
    ${params.cutadapt} -a ${params.adapter} -o trim_fastq.fastq $fastq
    """

}