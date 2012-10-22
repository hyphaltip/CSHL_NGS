#PBS -N SRR527545.realn -l nodes=1:ppn=4,walltime=99:99:99,mem=8gb -q js -j oe
hostname
module load stajichlab
module load java
cd /bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/
if [ ! -f SRR527545.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /usr/local/java/common/lib/picard-tools/AddOrReplaceReadGroups.jar INPUT=SRR527545.W303.sam OUTPUT=SRR527545.W303.bam RGID=SRR527545 RGLB=SRR527545 RGPL=illumina RGPU=Genomic RGSM=SRR527545 RGCN=Cornell SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT MAX_RECORDS_IN_RAM=1000000
fi
if [ ! -f SRR527545.sort_ordered.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /usr/local/java/common/lib/picard-tools/ReorderSam.jar INPUT=SRR527545.W303.bam OUTPUT=SRR527545.sort_ordered.W303.bam REFERENCE=/bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/genome/Saccharomyces_cerevisiae.fa MAX_RECORDS_IN_RAM=1000000 CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT;
fi
if [ ! -f SRR527545.dedup.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /usr/local/java/common/lib/picard-tools/MarkDuplicates.jar INPUT=SRR527545.sort_ordered.W303.bam OUTPUT=SRR527545.dedup.W303.bam METRICS_FILE=SRR527545.dedup.W303.metrics MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=800 CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT;
fi
if [ ! -f SRR527545.W303.intervals ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /opt/stajichlab/GATK/latest/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/genome/Saccharomyces_cerevisiae.fa -o SRR527545.W303.intervals -I SRR527545.dedup.W303.bam;
fi
if [ ! -f SRR527545.realign.W303.bam ]; then
  java -Djava.io.tmpdir=/home_stajichlab/jstajich/bigdata/tmp/ -Xmx6g -jar /opt/stajichlab/GATK/latest/GenomeAnalysisTK.jar -T IndelRealigner -R /bigdata/jstajich/Teaching/CSHL_2012_NGS/examples/genome/Saccharomyces_cerevisiae.fa -targetIntervals SRR527545.W303.intervals -I SRR527545.dedup.W303.bam -o SRR527545.realign.W303.bam;
fi
