#/bin/bash

cd data

# uncompress the datafiles
bunzip2 -k seq/*.bz2
gunzip -k genome/*.fa.gz

# trim the data
sickle pe -f seq/W303_chrII_1.fastq -r seq/W303_chrII_2.fastq \
-o W303_chrII_1.trim.fastq -p W303_chrII_2.trim.fastq \
-s W303_chrII_single.trim.fastq -t sanger

# run fastqc
mkdir fastqc_output	
fastqc -o fastqc_output *.fastq
# copy to your public_html
cp -r fastqc_output ~/sites/W303_fastqc_report

# index the genome for bwa
bwa index genome/Saccharomyces.fa
	
# run bwa
bwa mem genome/Saccharomyces.fa W303_chrII_1.trim.fastq \
W303_chrII_2.trim.fastq  > W303_chrII.sam

# this creates the aligned SAM file
# run picard to convert to bam and sort
java -jar $PICARD/SortSam.jar I=W303_chrII.sam O=W303.sorted.bam CREATE_INDEX=true SO=coordinate
cd ..
