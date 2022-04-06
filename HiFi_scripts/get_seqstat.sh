#!/bin/bash
#SBATCH -p fn2                      # Use fn1 partition                         
#SBATCH -N 1                        # number of compute nodes                   
#SBATCH -n 8
#SBATCH -J fastq-stats
### Load Modules

module load seqkit/0.12.0
### Run app on file


cd /scratch/yhao38/calkinsi 
seqkit stats calkinsi.fastq.gz > calkinsi_fastq_stats.txt

cd /scratch/yhao38/duboscqui                                                     
seqkit stats duboscqui.fastq.gz > duboscqui_fastq_stats.txt 

cd /scratch/yhao38/woodruffi                                                     
seqkit stats woodruffi.fastq.gz > woodruffi_fastq_stats.txt 

