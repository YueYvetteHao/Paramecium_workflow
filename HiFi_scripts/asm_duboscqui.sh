#!/bin/bash
#SBATCH --job-name="asmdubo"                                                     
##SBATCH --ntasks=8                # Number of cores requested                  
##SBATCH --qos=cmeqos               # The queue (line) we are in                 
##SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH -p fn2                      # Use fn1 partition
#SBATCH -N 1                        # number of compute nodes
#SBATCH -n 32                       # number of CPU cores to reserve on this compute node
#SBATCH --output=duboasm_%j.out                                                      
#SBATCH --error=duboasm_%j.err                                                       
#SBATCH --time=3-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu   

cd /scratch/yhao38/dubo_asm                                                                                
#cd /scratch/yhao38/duboscqui                                                    
#hifiasm -o duboscqui.asm -t 8 -l0 duboscqui.fastq.gz 2> duboscqui.asm.log                                    
#hifiasm -o duboscqui_p.asm -t 8 duboscqui.fastq.gz 2> duboscqui_p.asm.log                                                                                
hifiasm -o duboscqui_pop.asm -t 32 -l0 -s 0.1 -p 14400 --hom-cov 186 duboscqui.fastq.gz



