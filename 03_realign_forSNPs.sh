cd data
GENOME=genome/Saccharomyces.fa
DICTIONARY=genome/Saccharomyces.dict

# make index from picard
java -jar $PICARD/CreateSequenceDictionary.jar \
R=$GENOME OUTPUT=$DICTIONARY

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
java -Xmx3g -jar $GATK -T RealignerTargetCreator -R $GENOME \
    -o W303.intervals -I W303.readgroup.bam

# run realignment
java -Xmx3g -jar $GATK -T IndelRealigner \
    -R $GENOME \
    -targetIntervals W303.intervals -I W303.readgroup.bam \
    -o W303.realign.bam
