#!/bin/bash
#SBATCH --job-name="bam2fastq"                                                     
#SBATCH --ntasks=4                # Number of cores requested                  
#SBATCH --qos=cmeqos               # The queue (line) we are in                 
#SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH --output=bam2fastq_%j.out                                                      
#SBATCH --error=bam2fastq_%j.err                                                       
#SBATCH --time=2-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu   



module load anaconda/py2                                                        
source activate ccs

cd /scratch/yhao38/calkinsi
pbindex calkinsi.hifi.bam

cd /scratch/yhao38/duboscqui
pbindex duboscqui.hifi.bam

cd /scratch/yhao38/woodruffi
pbindex woodruffi.hifi.bam

conda deactivate

module load anaconda/py2
source activate bam2fastx

cd /scratch/yhao38/calkinsi
#bam2fasta -o projectName m54008_160330_053509.subreads.bam
bam2fastq -o calkinsi calkinsi.hifi.bam

cd /scratch/yhao38/duboscqui
bam2fastq -o duboscqui duboscqui.hifi.bam

cd /scratch/yhao38/woodruffi
bam2fastq -o woodruffi woodruffi.hifi.bam


conda deactivate