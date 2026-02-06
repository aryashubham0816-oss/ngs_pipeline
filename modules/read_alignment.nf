process read_alignment {
    tag "alignment"
    publishDir "${params.outdir}/alignment",mode:'symlink'

    input: 
    path trimmed
    path ref

    output:
    path "read_alignment.sam"

    script:
    """

    ${params.bwa} index ${ref}
    ${params.bwa} mem ${ref} ${trimmed} > read_alignment.sam
    """
}