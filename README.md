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

[Samtools](http://samtools.sourceforge.net/)
We use Samtools transfer .sam to .bam and check the quality.
1. Transfer .sam to .bam.

$ samtools view -b -S abc.sam -o abc.bam

2. Sort the bam files.

$ samtools sort abc.bam abc.sort.bam

3. Index the bam files after the sort step.

$ samtools index abc.sort

4. Check the quality.

$ samtools flagstat abc.bam

$ samtools stats abc.sort.bam |grep '^SN'|cut -f 2-

## Variance calling
