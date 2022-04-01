#!/bin/bash                                                                     

# Read mapping using BWA

# Required software:
# fastp v0.21.0
# fastQC v0.11.9
# bwa v0.7.17-r1188
# picard v2.25.0
# samtools v1.12 (using htslib v1.12)
# qualimap v2.2.1

# Working directory
cd /scratch/yhao38/Param_pop

# File name
File=$1

# Reference genome directory
RD=/scratch/yhao38/Paramecium_reference
Ref=$RD/biaurelia/V1-4/Paramecium_biaurelia+mt.fasta

echo 'Build index for the reference genome'
# only need to do once
bwa index $Ref


echo $File
# echo 'Remove adapters'
# toggle -g to remove poly-G tails
# fastp --detect_adapter_for_pe --overrepresentation_analysis --correction --cut_right -g --thread 2 --html $File.fastp.html --json $File.fastp.json -i $File.R1.fastq.gz -I $File.R2.fastq.gz -o $File.R1_paired.fastq.gz -O $File.R2_paired.fastq.gz --unpaired1 $File.R1_unpaired.fastq.gz --unpaired2 $File.R2_unpaired.fastq.gz 

# echo 'Generate FastQC reports'
# fastqc $File.R1_paired.fastq.gz &
# fastqc $File.R2_paired.fastq.gz &
# fastqc $File.R1_unpaired.fastq.gz &
# fastqc $File.R2_unpaired.fastq.gz &
# wait

gunzip $File.R1_paired.fastq.gz
gunzip $File.R2_paired.fastq.gz
gunzip $File.R1_unpaired.fastq.gz
gunzip $File.R2_unpaired.fastq.gz
	
echo 'Read mapping'
bwa mem -t 16 -M $Ref $File.R1_paired.fastq $File.R2_paired.fastq > $File.paired.sam &
bwa mem -t 16 -M $Ref $File.R1_unpaired.fastq > $File.R1_unpaired.sam &
bwa mem -t 16 -M $Ref $File.R2_unpaired.fastq > $File.R2_unpaired.sam &
wait

module load java/latest

echo 'Combine the SAM files using Picard'
java -jar /home/yhao38/bin/picard.jar MergeSamFiles I=$File.paired.sam I=$File.R1_unpaired.sam I=$File.R2_unpaired.sam O=$File.sam

echo 'Convert the SAM file to the BAM file using Samtools'
samtools view -bS $File.sam > $File.bam

echo 'Sort the BAM file using Picard'
java -jar /home/yhao38/bin/picard.jar SortSam INPUT=$File.bam OUTPUT=Sorted_$File.bam SORT_ORDER=coordinate

echo 'Filter the BAM file using Samtools'
samtools view -q 20 -f 3 -F 3844 -b Sorted_$File.bam > Filtered_Sorted_$File.bam

echo 'Check reads per contig'
samtools idxstats Filtered_Sorted_$File.bam > $File.mapping_stats.txt

echo 'Generate qualimap report'
# qualimap bamqc -bam Sorted_$File.bam -outfile qualimap_report_$File.pdf
qualimap bamqc -bam Filtered_Sorted_$File.bam -outfile qualimap_report_Filtered_$File.pdf
