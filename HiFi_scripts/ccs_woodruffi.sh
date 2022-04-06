#!/bin/bash                                                                     
#SBATCH --job-name="ccsccsw"                                                     
#SBATCH --ntasks=8                # Number of cores requested                  
#SBATCH --qos=cmeqos               # The queue (line) we are in                 
#SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH --output=pbccs_%j.out                                                      
#SBATCH --error=pbccs_%j.err                                                       
#SBATCH --time=2-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu                                            
                                                                                
                                                                                
cd /data/LynchLabCME/haoyue                                                                                                                                                   
cp m64044_210725_081729.subreads.demux.Woodruffi--Woodruffi.bam /scratch/yhao38/PacBio
cp m64044_210725_081729.subreads.demux.Woodruffi--Woodruffi.bam.pbi /scratch/yhao38/PacBio
    
cd /scratch/yhao38/PacBio  
mv m64044_210725_081729.subreads.demux.Woodruffi--Woodruffi.bam woodruffi.subreads.bam 
mv m64044_210725_081729.subreads.demux.Woodruffi--Woodruffi.bam.pbi woodruffi.subreads.bam.pbi                                                                           
module load anaconda/py2                                                        
source activate ccs                                                             
                                                                                
ccs woodruffi.subreads.bam woodruffi.ccs.1.bam --chunk 1/8 -j 8
ccs woodruffi.subreads.bam woodruffi.ccs.2.bam --chunk 2/8 -j 8
ccs woodruffi.subreads.bam woodruffi.ccs.3.bam --chunk 3/8 -j 8
ccs woodruffi.subreads.bam woodruffi.ccs.4.bam --chunk 4/8 -j 8
ccs woodruffi.subreads.bam woodruffi.ccs.5.bam --chunk 5/8 -j 8
ccs woodruffi.subreads.bam woodruffi.ccs.6.bam --chunk 6/8 -j 8
ccs woodruffi.subreads.bam woodruffi.ccs.7.bam --chunk 7/8 -j 8
ccs woodruffi.subreads.bam woodruffi.ccs.8.bam --chunk 8/8 -j 8
                                                                               
                                                                                
                                                                                
pbmerge -o woodruffi.ccs.bam woodruffi.ccs.*.bam                                  
pbindex woodruffi.ccs.bam                                                        
                                                                                
                                                                                
conda deactivate
