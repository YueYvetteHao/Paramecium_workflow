#!/bin/bash                                                                     
#SBATCH --job-name="asmwood"                                                     
##SBATCH --ntasks=8                # Number of cores requested                  
##SBATCH --qos=cmeqos               # The queue (line) we are in                 
##SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH -p fn3                      # Use fn1 partition                         
#SBATCH -N 1                        # number of compute nodes                   
#SBATCH -n 40                       # number of CPU cores to reserve on this compute node
#SBATCH --output=woodpurge_%j.out                                                      
#SBATCH --error=woodpurge_%j.err                                                       
#SBATCH --time=3-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu                                            
                                                                                
#cd /scratch/yhao38/wood_asm/purge_dups
#gfatools gfa2fa woodruffi_180.asm.bp.p_ctg.gfa > woodruffi_180.asm.bp.p_ctg.fasta
cd /scratch/yhao38/canuwood
#pri_asm=woodruffi_180.asm.bp.p_ctg.fasta
#pri_asm=p_ctg.fasta
pri_asm=asm.contigs.fasta
pb=woodruffi.fastq.gz

minimap2 -xmap-pb $pri_asm $pb | gzip -c - > $pb.paf.gz
/home/yhao38/software/purge_dups/bin/pbcstat *.paf.gz
/home/yhao38/software/purge_dups/bin/calcuts PB.stat > cutoffs 2>calcults.log

/home/yhao38/software/purge_dups/bin/split_fa $pri_asm > $pri_asm.split
minimap2 -xasm5 -DP $pri_asm.split $pri_asm.split | gzip -c - > $pri_asm.split.self.paf.gz

/home/yhao38/software/purge_dups/bin/purge_dups -2 -T cutoffs -c PB.base.cov $pri_asm.split.self.paf.gz > dups.bed 2> purge_dups.log

/home/yhao38/software/purge_dups/bin/get_seqs -e dups.bed $pri_asm 

 
