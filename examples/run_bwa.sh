module load bwa/0.6.2
module load samtools
#quality score cutoff
QUALITY=20

#index genome
GENOMEDIR=genome
GENOMEFILE=$GENOMEDIR/Saccharomyces_cerevisiae
if [ ! -f $GENOMEFILE.pac ];
then
 bwa index -p $GENOMEFILE $GENOMEFILE.fa
fi

# perform alignment
FASTQDIR=fastq
for file in $FASTQDIR/*.trim.fq
do
 base=`basename $file .trim.fq`
 if [ ! -f $base.sai ]; then
  bwa aln -q $QUALITY -t 16 -f $base.sai $GENOMEFILE $file
 fi
done

for file in *_1.sai
do
 base=`basename $file _1.sai`
 if [ ! -f $base.sam ]; then
  bwa sampe -f $base.sam $GENOMEFILE $base"_1.sai" $base"_2.sai" $FASTQDIR/$base"_1.trim.fq" $FASTQDIR/$base"_2.trim.fq"
 fi
done

for file in *.sam
do
 base=`basename $file .sam`
 if [ ! -f $base.bam ]; 
 then
  samtools view -bS $file > $base.unsrt.bam
  samtools sort $base.unsrt.bam $base.bam
  rm $base.unsrt.bam
 fi
done
