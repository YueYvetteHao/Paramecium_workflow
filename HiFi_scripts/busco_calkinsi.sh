#!/bin/bash                                                                     
#SBATCH --job-name="busco"                                                     
#SBATCH --ntasks=4                # Number of cores requested                  
#SBATCH --qos=cmeqos               # The queue (line) we are in                 
#SBATCH --partition=cmecpu1         # The compute node set to submit to         

#SBATCH --output=busco_%j.out                                                      
#SBATCH --error=busco_%j.err                                                       
#SBATCH --time=3-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu       


module load singularity/3.3.0-1

singularity run -B /scratch/yhao38/calkinsi:/scratch/yhao38/calkinsi /home/yhao38/busco_v5.1.2_cv1.sif

cd /scratch/yhao38/calkinsi/assembly-results

busco -m genome -i final.p_ctg.fasta -o busco_denti -l alveolata_odb10

exit
