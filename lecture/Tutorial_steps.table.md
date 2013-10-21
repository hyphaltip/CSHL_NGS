
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
	bwa mem 
