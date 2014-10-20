# find SNPs in genes
cd data
bedtools intersect -a W303.GATK_filtered.vcf.gz -b genome/saccharomyces_cerevisiae_R64-1-1_20110208.gff > W303.GATK.IN_GENES.vcf

bedtools intersect -a W303.samtools_filtered.vcf.gz -b genome/saccharomyces_cerevisiae_R64-1-1_20110208.gff > W303.samtools.IN_GENES.vcf

bedtools intersect -a W303.samtools_filtered.vcf.gz -b  W303.GATK_filtered.vcf.gz > W303.samtools_GATK.overlap.vcf

bedtools intersect -v -a W303.samtools_filtered.vcf.gz -b  W303.GATK_filtered.vcf.gz > W303.samtools_GATK.missing.vcf

bedtools intersect -v -b W303.samtools_filtered.vcf.gz -a  W303.GATK_filtered.vcf.gz > W303.GATK_samtools.missing.vcf

