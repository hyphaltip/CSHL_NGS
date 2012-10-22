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
 if [ ! -f aln_out/$base.sai ]; then
  bwa aln -q $QUALITY -t 16 -f aln_out/$base.sai $GENOMEFILE $file
 fi
done

for file in aln_out/*_1.sai
do
 base=`basename $file _1.sai`
 if [ ! -f aln_out/$base.sam ]; then
  bwa sampe -f aln_out/$base.sam $GENOMEFILE aln_out/$base"_1.sai" aln_out/$base"_2.sai" $FASTQDIR/$base"_1.trim.fq" $FASTQDIR/$base"_2.trim.fq"
 fi
done

for file in aln_out/*.sam
do
 base=`basename $file .sam`
 if [ ! -f aln_out/$base.bam ]; 
 then
  samtools view -bS $file > $base.unsrt.bam
  samtools sort $base.unsrt.bam aln_out/$base.bam
  rm $base.unsrt.bam
 fi
done
