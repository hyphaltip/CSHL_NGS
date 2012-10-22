Data and scripts for this Tutorial and Lectures are available at [https://github.com/hyphaltip/CSHL_2012_NGS](https://github.com/hyphaltip/CSHL_2012_NGS).



Preparation Steps
=================

1. Download Broad IGV viewer at
[http://www.broadinstitute.org/igv/](http://www.broadinstitute.org/igv/)

2. Download the Saccharomyces genome from [SGD
site](http://downloads.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz)

3. Downlod the read data from SRA and convert it -- This step already
done for you, folder is on server or you can run the download script
when you get home (rerequires [curl](http://curl.haxx.se/), [sra
toolkit](http://ftp-private.ncbi.nlm.nih.gov/sra/sdk/), and for
download speedup [Aspera
client](http://downloads.asperasoft.com/download_connect/)

    * For Asperga, get the web client and find the ascp binary and
      install in your path. For example on OSX it installs in
      "/Applications/Aspera\ Connect.app/Contents/Resources/ascp".

    * Download script to obtain all the data is here
      [https://github.com/hyphaltip/CSHL_2012_NGS/blob/master/data/download.sh](https://github.com/hyphaltip/CSHL_2012_NGS/blob/master/data/download.sh)

Tutorial
========

1. Trim FASTQ data for quality using sickle - run 'sickle pe' to see how to run PE options
2. Compare the FASTQC quality report for one of the files (_1 or _2) files both before and after trimming. Set this up in the background so you can run it and do other things in the meantime.
    * Run fastqc -h to get help
3. Align reads to the genome using BWA. This requires you to 

