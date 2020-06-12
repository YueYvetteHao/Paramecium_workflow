# Paramecium_workflow

## [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
Reports are merged using [MultiQC](https://multiqc.info/).
![](https://i.imgur.com/YYiCU6j.png)

## Remove adapters
[Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
```
>i5_f
>i5_r
>i7_f
>i7_r
```

## Prepare reference genomes

## Read mapping
[BWA](http://bio-bwa.sourceforge.net/) MEM
For Illumina/454/LonTorreent paired-end reads longer than ~70bp,the command is:
$ bwa mem ref.fa read1.fq read2.>aln.sam
We will get SAM files.
## Check mapping quality
[Qualimap](http://qualimap.bioinfo.cipf.es/)
We use Samtools transfer .sam to .bam and check the quality.

## Variance calling
