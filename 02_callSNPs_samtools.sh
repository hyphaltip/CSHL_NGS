QUERY_BAM=W303.bam
# HERE WE AER USING SAMTOOLS 1.1
SAMTOOLS=/usr/local/samtools-1.1/samtools
BCFTOOLS=/usr/local/bcftools-1.1/bcftools

# IF YOU WANT TO RUN WITH SAMTOOLS 0.1.19 (older version)
#SAMTOOLS=/usr/local/bin/samtools
#BCFTOOLS=/usr/local/bin/bcftools
]
# IF YOU RUN THE REALIGNER (step 03) change this to the following
# QUERY_BAM=W303.realign.bam

GENOME=data/genome/Saccharomyces.fa
# also make index from samtools
$SAMTOOLS faidx $GENOME

#BEGIN SAMTOOLS 1.1
$SAMTOOLS mpileup -ugf $GENOME $QUERY_BAM | $BCFTOOLS call -vmO z -o W303.samtools_raw.vcf.gz

tabix -p vcf W303.samtools_raw.vcf.gz

$BCFTOOLS stats -F $GENOME -s - W303.samtools_raw.vcf.gz > W303.samtools_raw.vcf.stats

$BCFTOOLS filter -O z -o W303.samtools_filtered.vcf.gz -s LOWQUAL -i'%QUAL>10' W303.samtools_raw.vcf.gz
#END SAMTOOLS 1.1

#IF YOU AER USING SAMTOOLS 0.1.19
#BEGIN SAMTOOLS 0.1.19
#ACC=W303
#$SAMTOOLS mpileup -D -S -gu -f $GENOME $QUERY_BAM | $BCFTOOLS view -bvcg - > $ACC.samtools_raw.bcf
#$BCFTOOLS view $ACC.samtools_raw.bcf | vcfutils.pl varFilter -D100 > $ACC.samtools_filter.vcf
#END SAMTOOLS 0.1.19
