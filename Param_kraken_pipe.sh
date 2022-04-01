#!/bin/bash                                                                     

# Required software:
# fastp v0.21.0
# fastQC v0.11.9
# kraken2 v2.0.8-beta
# bracken v2.6
# krona v2.8.1
# KrakenTools v1.2

# Working directory
cd /scratch/yhao38/Param_pop

# File name
File=$1

echo $File
echo 'Remove adapters'
# Toggle -g to remove poly-G tails
fastp --detect_adapter_for_pe --overrepresentation_analysis --correction --cut_right -g --thread 2 --html $File.fastp.html --json $File.fastp.json -i $File.R1.fastq.gz -I $File.R2.fastq.gz -o $File.R1_paired.fastq.gz -O $File.R2_paired.fastq.gz --unpaired1 $File.R1_unpaired.fastq.gz --unpaired2 $File.R2_unpaired.fastq.gz 

echo 'Generate FastQC reports'
fastqc $File.R1_paired.fastq.gz #&
fastqc $File.R2_paired.fastq.gz #&
#fastqc $File.R1_unpaired.fastq.gz #&
#fastqc $File.R2_unpaired.fastq.gz #&
#wait


echo 'Begin classification'
kraken2 --threads 4 --db /scratch/yhao38/kraken_db/Paramecium_db --report $File.paired.kreport --paired $File.R1.fastq.gz $File.R2.fastq.gz > $File.paired.kraken
kraken2 --threads 4 --db /scratch/yhao38/kraken_db/Paramecium_db --report $File.R1.kreport $File.R1_unpaired.fastq.gz > $File.R1.kraken
kraken2 --threads 4 --db /scratch/yhao38/kraken_db/Paramecium_db --report $File.R2.kreport $File.R2_unpaired.fastq.gz > $File.R2.kraken

echo 'Combine kraken reports'
python /home/yhao38/software/KrakenTools/combine_kreports.py -r $File.paired.kreport $File.R1.kreport $File.R2.kreport -o $File.kreport --no-headers --only-combined

echo 'Bracken'
bracken -d /scratch/yhao38/kraken_db/Paramecium_db -i $File.kreport -l S -o species_$File.bracken

echo 'Plot'
python /home/yhao38/software/KrakenTools/kreport2krona.py -r $File.kreport -o $File.krona 
ktImportText $File.krona -o $File.krona.html
