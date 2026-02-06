process variant_analysis {
    tag "variant_calling"
    publishDir "${params.outdir}/variantcalling",mode:'symlink'

    input:
    path bam
    path bai
    path ref

    output:
    path "variant_analysis.vcf" , emit :vcf

    script:
    """

    ${params.bcftools} mpileup -f ${ref} ${bam} | bcftools call -mv -o variant_analysis.vcf
    """

}