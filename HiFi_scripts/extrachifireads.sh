#!/bin/bash                                                                     
#SBATCH --job-name="extrahifi"                                                     
#SBATCH --ntasks=12                # Number of cores requested                  
#SBATCH --qos=cmeqos               # The queue (line) we are in                 
#SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH --output=extrahifi_%j.out                                                      
#SBATCH --error=extrahifi_%j.err                                                       
#SBATCH --time=2-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu                                            
                                                                                
                                                                                
#cd /data/LynchLabCME/haoyue                                                                                                                                                   
#cp m64044_210725_081729.subreads.demux.Duboscqui--Duboscqui.bam /scratch/yhao38/PacBio
#cp m64044_210725_081729.subreads.demux.Duboscqui--Duboscqui.bam.pbi /scratch/yhao38/PacBio
    
cd /scratch/yhao38/PacBio  
#mv m64044_210725_081729.subreads.demux.Duboscqui--Duboscqui.bam duboscqui.subreads.bam 
#mv m64044_210725_081729.subreads.demux.Duboscqui--Duboscqui.bam.pbi duboscqui.subreads.bam.pbi                                                                           
module load anaconda/py3                                                        
source activate extrahifi

extracthifi woodruffi.ccs.bam woodruffi.hifi.bam
extracthifi duboscqui.ccs.bam duboscqui.hifi.bam
extracthifi calkinsi.ccs.bam calkinsi.hifi.bam                                                                                                                          
                                                                                
conda deactivate
