#Sequence data

* Sanger
* Illumina
* 454
* PacBio
* Ion Torrent
* SOLiD

---
#File formats

[FASTQ](http://en.wikipedia.org/wiki/FASTQ_format)

    @SRR527545.1 1 length=76
    GTCGATGATGCCTGCTAAACTGCAGCTTGACGTACTGCGGACCCTGCAGTCCAGCGCTCGTCATGGAACGCAAACG
    +
    HHHHHHHHHHHHFGHHHHHHFHHGHHHGHGHEEHHHHHEFFHHHFHHHHBHHHEHFHAH?CEDCBFEFFFFAFDF9

FASTA format

    >SRR527545.1 1 length=76
    GTCGATGATGCCTGCTAAACTGCAGCTTGACGTACTGCGGACCCTGCAGTCCAGCGCTCGTCATGGAACGCAAACG

[SFF](http://en.wikipedia.org/wiki/Standard_Flowgram_Format) - Standard Flowgram Format - binary format for 454 reads

Colorspace (SOLiD) - CSFASTQ

    @0711.1 2_34_121_F3
    T11332321002210131011131332200002000120000200001000
    +
    64;;9:;>+0*&:*.*1-.5($2$3&$570*$575&$9966$5835'665

---
#FASTQ Quality score scale

1. PHRED (33 offset)
2. 

---
#Quality Scores in [FASTQ files](http://en.wikipedia.org/wiki/FASTQ_format) 


     SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS.....................................................
     ..........................XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX......................
     ...............................IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII......................
     .................................JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ......................
     LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL....................................................
     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
     |                         |    |        |                              |                     |
    33                        59   64       73                            104                   126

    S - Sanger        Phred+33,  raw reads typically (0, 40)
    X - Solexa        Solexa+64, raw reads typically (-5, 40)
    I - Illumina 1.3+ Phred+64,  raw reads typically (0, 40)
    J - Illumina 1.5+ Phred+64,  raw reads typically (3, 40)
        with 0=unused, 1=unused, 2=Read Segment Quality Control Indicator (bold) 
        (Note: See discussion above). 

---
#Read naming and Paired-End information

Paired-End naming
File: Project1_lane6_1_sequence.txt

    @HWI-ST397_0000:2:1:2248:2126#CTTGTA/1
    TTGGATCTGAAAGATGAATGTGAGAGACACAATCCAAGTCATCTCTCATG
    +HWI-ST397_0000:2:1:2248:2126#CTTGTA/1
    eeee\dZddaddddddeeeeeeedaed_ec_ab_\NSRNRcdddc[_c^d

File: Project1_lane6_2_sequence.txt

    @HWI-ST397_0000:2:1:2248:2126#CTTGTA/2
    CTGGCATTTTCACCCAAATTGCTTTTAACCCTTGGGATCGTGATTCACAA
    +HWI-ST397_0000:2:1:2248:2126#CTTGTA/2
    ]YYY_\[[][da_da_aa_a_a_b_Y]Z]ZS[]L[\ddccbdYc\ecacX



---
#Read 
---
#Data QC

* Plot quality info: FASTQC
* Trimming (FASTX_Toolkit, sickle)
    * Adapative vs hard cutoff
* 

---
#[Sequence aligners](http://wwwdev.ebi.ac.uk/fg/hts_mappers/)
![Mappers](./mappers_timeline.jpeg "HTS timeline")

---
#Short read aligners

Strategy requires faster searching than BLAST or FASTA
approach. Several approaches have been developed from only 

* Burrows-Wheeler Transform is a speed up that is accomplished
through a transformation of the data. Requires and indexing of the
search database (typically the genome).

---
#Workflow

* Trim
