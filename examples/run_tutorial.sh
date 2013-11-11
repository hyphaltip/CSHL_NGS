
	# checkout the project
	git clone git://github.com/hyphaltip/CSHL_NGS.git
	cd CSHL_NGS
	# uncompress the datafiles
	cd example
	bunzip2 *.bz2
	gunzip genome/*.gz
	# trim the data
	sickle pe -f W303_chrII_1.fastq -r W303_chrII_2.fastq \
	-o W303_chrII_1.trim.fastq -p W303_chrII_2.trim.fastq \
	-s W303_chrII_single.trim.fastq
	# run fastqc
	mkdir fastqc_output	
	fastqc -o fastqc_output *.fastq
	# copy to your public_html
	cp -r fastqc_output ~/public_html
	# index the genome for bwa
	bwa index genome/Saccharomyces.fa
	# run bwa
	bwa mem genome/Saccharomyces.fa W303_chrII_1.trim.fastq \
	W303_chrII_2.trim.fastq  > W303_chrII.sam
	# run picard to convert to bam and sort
	java -jar $PICARD/SortSam.jar I=W303_chrII.sam O=W303.sorted.bam CREATE_INDEX=true SO=coordinate
	# make index from picard
	java -jar $PICARD/CreateSequenceDictionary.jar \
	R=genome/Saccharomyces.fa OUTPUT=genome/Saccharomyces.dict
	# also make index from samtools
	samtools faidx genome/Saccharomyces.fa
	# run de-duplicate
	java -jar $PICARD/MarkDuplicates.jar INPUT=W303.sorted.bam  \
	OUTPUT=W303.dedup.bam METRICS_FILE=W303.dedup.metrics    \
	CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT
    	# add the readgroup
    	java -Xmx3g -jar $PICARD/AddOrReplaceReadGroups.jar INPUT=W303.dedup.bam \
      OUTPUT=W303.readgroup.bam SORT_ORDER=coordinate CREATE_INDEX=True \
      RGID=W303 RGLB=SRR527545 RGPL=Illumina RGPU=Genomic RGSM=W303 \
      VALIDATION_STRINGENCY=SILENT

    	# Identify where to run the realignment based on finding variant sites
	java -Xmx3g -jar $GATK/GenomeAnalysisTK.jar -T RealignerTargetCreator \
     	-R genome/Saccharomyces.fa \
     	-o W303.intervals -I W303.readgroup.bam
    	# run realignment
	java -Xmx3g -jar $GATK/GenomeAnalysisTK.jar -T IndelRealigner \
		-R genome/Saccharomyces.fa \
		-targetIntervals W303.intervals -I W303.readgroup.bam \
		-o W303.realign.bam
	# run the genotyper
	java -Xmx3g -jar $GATK/GenomeAnalysisTK.jar -T UnifiedGenotyper \
      	-glm SNP -I W303.realign.bam -R genome/Saccharomyces.fa \
      	-o W303.GATK.vcf -nt 4
	# filter the VCF
	java -Xmx3g -jar $GATK/GenomeAnalysisTK.jar \
    	-T VariantFiltration -o W303.filtered.vcf \
    	--variant W303.GATK.vcf \
    	--clusterWindowSize 10  -filter "QD<8.0" -filterName QualByDepth \
    	-filter "MQ<=30.0" -filterName MapQual \
    	-filter "QUAL<100" -filterName QScore \
    	-filter "MQ0>=10 && ((MQ0 / (1.0 * DP)) > 0.1)" -filterName MapQualRatio \
    	-filter "FS>60.0" -filterName FisherStrandBias \
    	-filter "HaplotypeScore > 13.0" -filterName HaplotypeScore >& output.filter.log 

