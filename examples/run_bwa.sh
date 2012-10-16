if [ ! -f ../data/genomes/Saccharomyces_cerevisiae.1.ebwt ];
then
 bwa index -p ../data/genomes/Saccharomyces_cerevisiae ../data/genomes/Saccharomyces_cerevisiae.fa 
fi

# fill in alignment details
