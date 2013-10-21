
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
	java -jar $PICARD/SortSam.jar I=W303.sam O=W303.sorted.bam CREATE_INDEX=true SO=coordinate
	# run de-duplicate
	java -jar $PICARD/MarkDuplicates.jar INPUT=W303.sorted.bam  \
	OUTPUT=W303.dedup.bam METRICS_FILE=W303.dedup.metrics    \
	CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT

