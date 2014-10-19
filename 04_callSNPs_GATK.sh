QUERY_BAM=W303.realign.bam

# run the genotyper
java -Xmx3g -jar $GATK/GenomeAnalysisTK.jar -T UnifiedGenotyper \
    -glm SNP -I $QUERY_BAM -R genome/Saccharomyces.fa \
    -o W303.GATK_raw.vcf -nt 4

# filter the VCF
java -Xmx3g -jar $GATK/GenomeAnalysisTK.jar \
    -T VariantFiltration -o W303.GATK_filtered.vcf \
    --variant W303.GATK_raw.vcf \
    --clusterWindowSize 10  -filter "QD<8.0" -filterName QualByDepth \
    -filter "MQ<=30.0" -filterName MapQual \
    -filter "QUAL<100" -filterName QScore \
    -filter "MQ0>=10 && ((MQ0 / (1.0 * DP)) > 0.1)" -filterName MapQualRatio \
    -filter "FS>60.0" -filterName FisherStrandBias \
    -filter "HaplotypeScore > 13.0" -filterName HaplotypeScore >& output.filter.log 
