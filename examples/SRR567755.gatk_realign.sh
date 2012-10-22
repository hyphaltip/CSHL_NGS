#PBS -N SRR567755.realn -l nodes=1:ppn=4,walltime=99:99:99,mem=8gb -q js -j oe
hostname
module load stajichlab
module load java
cd /bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/
if [ ! -f SRR567755.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /usr/local/java/common/lib/picard-tools/AddOrReplaceReadGroups.jar INPUT=SRR567755.W303.sam OUTPUT=SRR567755.W303.bam RGID=SRR567755 RGLB=SRR567755 RGPL=illumina RGPU=Genomic RGSM=SRR567755 RGCN=Cornell SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT MAX_RECORDS_IN_RAM=1000000
fi
if [ ! -f SRR567755.sort_ordered.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /usr/local/java/common/lib/picard-tools/ReorderSam.jar INPUT=SRR567755.W303.bam OUTPUT=SRR567755.sort_ordered.W303.bam REFERENCE=/bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/genome/Saccharomyces_cerevisiae.fa MAX_RECORDS_IN_RAM=1000000 CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT;
fi
if [ ! -f SRR567755.dedup.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /usr/local/java/common/lib/picard-tools/MarkDuplicates.jar INPUT=SRR567755.sort_ordered.W303.bam OUTPUT=SRR567755.dedup.W303.bam METRICS_FILE=SRR567755.dedup.W303.metrics MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=800 CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT;
fi
if [ ! -f SRR567755.W303.intervals ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /opt/stajichlab/GATK/latest/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/genome/Saccharomyces_cerevisiae.fa -o SRR567755.W303.intervals -I SRR567755.dedup.W303.bam;
fi
if [ ! -f SRR567755.realign.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /opt/stajichlab/GATK/latest/GenomeAnalysisTK.jar -T IndelRealigner -R /bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/genome/Saccharomyces_cerevisiae.fa -targetIntervals SRR567755.W303.intervals -I SRR567755.dedup.W303.bam -o SRR567755.realign.W303.bam;
fi
