
	git clone git://github.com/hyphaltip/CSHL_NGS.git
	cd CSHL_NGS
	cd example
	bunzip2 *.bz2
	gunzip genome/*.gz
	sickle pe -f W303_chrII_1.fastq -r W303_chrII_2.fastq \
	-o W303_chrII_1.trim.fastq -p W303_chrII_2.trim.fastq \
	-s W303_chrII_single.trim.fastq
	$ 
