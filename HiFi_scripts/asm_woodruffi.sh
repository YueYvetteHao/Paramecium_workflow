#!/bin/bash
#SBATCH --job-name="asmwood"                                                     
##SBATCH --ntasks=8                # Number of cores requested                  
##SBATCH --qos=cmeqos               # The queue (line) we are in                 
##SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH -p fn3                      # Use fn1 partition
#SBATCH -N 1                        # number of compute nodes
#SBATCH -n 21                       # number of CPU cores to reserve on this compute node
#SBATCH --output=woodasm_%j.out                                                      
#SBATCH --error=woodasm_%j.err                                                       
#SBATCH --time=3-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu   

                                                                                                                                                            
cd /scratch/yhao38/wood_asm                                                    
#hifiasm -o woodruffi.asm -t 8 -l0 woodruffi.fastq.gz 2> woodruffi.asm.log                                    
#hifiasm -o woodruffi_p.asm -t 8 woodruffi.fastq.gz 2> woodruffi_p.asm.log

hifiasm -o woodruffi_180.asm -t 21 --hom-cov 180 woodruffi.fastq.gz        
 


