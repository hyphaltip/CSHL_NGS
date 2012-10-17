module load java
REF=genome/Saccharomyces_cerevisiae.fa
GATK=/opt/GATK/latest/GenomeAnalysisTK.jar 
INPUT=W303_SNPs.raw.vcf
FILTER=W303_SNPs.GATK.filter.vcf
SELECTED=W303_SNPs.GATK.selected.vcf
BASE=W303_SNPs
BAMFILE=W303_reads.bam

java -Djava.io.tmpdir=/dev/shm -Xmx256g -jar $GATK -T UnifiedGenotyper -R $REF \
 -o $INPUT \
 -glm SNP --read_filter BadCigar -nt 48 --metrics_file $INPUT.info

java -Djava.io.tmpdir=/dev/shm/ -Xmx8g -jar $GATK -R $REF -T VariantFiltration -o $FILTER \
--variant $INPUT \
--clusterWindowSize 10  -filter "QD<8.0" -filterName QualByDepth \
-filter "MQ>=30.0" -filterName MapQual \
-filter "HRun>=4" -filterName HomopolymerRun \
-filter "QUAL<100" -filterName QScore \
-filter "MQ0>=10 && ((MQ0 / (1.0 * DP)) > 0.1)" -filterName MapQualRatio \
-filter "FS>60.0" -filterName FisherStrandBias \
-filter "HaplotypeScore > 13.0" -filterName HaplotypeScore \
-filter "MQRankSum < -12.5" -filterName MQRankSum  \
-filter "ReadPosRankSum < -8.0" -filterName ReadPosRankSum  >& $BASE.filter.log
#-XL 4375432 \

java -Djava.io.tmpdir=/dev/shm/ -Xmx8g -jar $GATK -R $REF -T SelectVariants --variant $FILTER -o $SELECTED --excludeFiltered >& $BASE.select.log
