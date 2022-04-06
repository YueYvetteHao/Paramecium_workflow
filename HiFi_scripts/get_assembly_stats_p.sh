#!/bin/bash                                                                     
#SBATCH -p fn2                      # Use fn1 partition                         
#SBATCH -N 1                        # number of compute nodes                   
#SBATCH -n 8                                                                    
#SBATCH -J assemblystats                                                          



                                                                                                    
                                                                             
cd /scratch/yhao38/calkinsi   
# Convert GFA (reference graph) into FASTA (one at a time)
gfatools gfa2fa calkinsi_purge.asm.bp.p_ctg.gfa > calkinsi_p.asm.bp.p_ctg.fasta
#perl /home/yhao38/software/assemblathon2-analysis/assemblathon_stats.pl calkinsi_p.asm.bp.p_ctg.fasta
cp calkinsi_p.asm.bp.p_ctg.fasta /home/yhao38/software/assemblathon2-analysis
cd /home/yhao38/software/assemblathon2-analysis
./assemblathon_stats.pl calkinsi_p.asm.bp.p_ctg.fasta
mv calkinsi_p.asm.bp.p_ctg.fasta /home/yhao38/Genomes_busco
                                                  
cd /scratch/yhao38/duboscqui   
gfatools gfa2fa duboscqui_p.asm.bp.p_ctg.gfa > duboscqui_p.asm.bp.p_ctg.fasta
#perl /home/yhao38/software/assemblathon2-analysis/assemblathon_stats.pl duboscqui_p.asm.bp.p_ctg.fasta
cp duboscqui_p.asm.bp.p_ctg.fasta /home/yhao38/software/assemblathon2-analysis
cd /home/yhao38/software/assemblathon2-analysis 
./assemblathon_stats.pl duboscqui_p.asm.bp.p_ctg.fasta
mv duboscqui_p.asm.bp.p_ctg.fasta /home/yhao38/Genomes_busco


cd /scratch/yhao38/woodruffi   
gfatools gfa2fa woodruffi_p.asm.bp.p_ctg.gfa > woodruffi_p.asm.bp.p_ctg.fasta
#perl /home/yhao38/software/assemblathon2-analysis/assemblathon_stats.pl woodruffi_p.asm.bp.p_ctg.fasta
cp woodruffi_p.asm.bp.p_ctg.fasta /home/yhao38/software/assemblathon2-analysis
cd /home/yhao38/software/assemblathon2-analysis
./assemblathon_stats.pl woodruffi_p.asm.bp.p_ctg.fasta  
mv woodruffi_p.asm.bp.p_ctg.fasta /home/yhao38/Genomes_busco 
    
