process multiqc_report {
     tag "multiqc"
    publishDir "${params.outdir}/multiqc",mode:'symlink'

    input :
    path '*'

    output :
    path "multiqc_report.html"

    script:
    """

    ${params.multiqc} .
    """
}