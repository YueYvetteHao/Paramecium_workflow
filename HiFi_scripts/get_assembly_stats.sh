#!/bin/bash                                                                     
#SBATCH -p fn2                      # Use fn1 partition                         
#SBATCH -N 1                        # number of compute nodes                   
#SBATCH -n 8                                                                    
#SBATCH -J assemblystats                                                          



                                                                                                    
                                                                             
cd /scratch/yhao38/calkinsi   
# Convert GFA (reference graph) into FASTA (one at a time)
gfatools gfa2fa calkinsi.asm.bp.p_ctg.gfa > calkinsi.asm.bp.p_ctg.fasta
perl /home/yhao38/software/assemblathon2-analysis/assemblathon_stats.pl calkinsi.asm.bp.p_ctg.fasta
                                                  
cd /scratch/yhao38/duboscqui   
gfatools gfa2fa duboscqui.asm.bp.p_ctg.gfa > duboscqui.asm.bp.p_ctg.fasta
perl /home/yhao38/software/assemblathon2-analysis/assemblathon_stats.pl duboscqui.asm.bp.p_ctg.fasta

cd /scratch/yhao38/woodruffi   
gfatools gfa2fa woodruffi.asm.bp.p_ctg.gfa > woodruffi.asm.bp.p_ctg.fasta
perl /home/yhao38/software/assemblathon2-analysis/assemblathon_stats.pl woodruffi.asm.bp.p_ctg.fasta
     
