#!/bin/bash                                                                     
#SBATCH --job-name="download"                                                   
#SBATCH --ntasks=4              # Number of cores requested                  
#SBATCH --qos=cmeqos               # The queue (line) we are in                 
#SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH --output=download_%j.out                                                     
#SBATCH --error=download_%j.err                                                       
#SBATCH --time=2-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu                                            
                                                                                

export ASPERA_SCP_PASS=Ce3uA_Rdop5$
                                                                                
cd /data/LynchLabCME/haoyue/TGEN                                                                                                                                                  
ascp -Q -l 500m -k 1 tgen_csc_drop5@ft10.tgen.org:/data/Aspera_Drops/CSC_Drop5 .


