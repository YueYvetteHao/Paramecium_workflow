#!/bin/bash
#SBATCH --job-name="asmcalk"                                                     
##SBATCH --ntasks=4                # Number of cores requested                  
##SBATCH --qos=cmeqos               # The queue (line) we are in                 
##SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH -p fn3                      # Use fn1 partition
#SBATCH -N 1                        # number of compute nodes
#SBATCH -n 40                       # number of CPU cores to reserve on this compute node
#SBATCH --output=calkasm_%j.out                                                      
#SBATCH --error=calkasm_%j.err                                                       
#SBATCH --time=3-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu   



cd /scratch/yhao38/calkinsi_nophase                                                     
#hifiasm -o calkinsi.asm -t 8 -l0 calkinsi.fastq.gz 2> calkinsi.asm.log                                    
                                                                                
#hifiasm -o calkinsi_purge.asm -t 8 calkinsi.fastq.gz 2> calkinsi_purge.asm.log 


#hifiasm -o calkinsi_purge.asm -t 50 --hom-cov 198.4 calkinsi.fastq.gz

hifiasm -o calkinsi_pop.asm -t 40 -l0 -s 0.1 --hom-cov 198.4 -p 14400 calkinsi.fastq.gz

