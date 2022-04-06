#!/bin/bash
#SBATCH --job-name="spawn_duboscqui"                                                     
#SBATCH --ntasks=1                # Number of cores requested                  
#SBATCH --qos=cmeqos               # The queue (line) we are in                 
#SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH --output=snake_%j.out                                                      
#SBATCH --error=snake_%j.err                                                       
#SBATCH --time=7-00:00:00                                                       
#SBATCH --mail-type=ALL                                                         
##SBATCH --mail-user=yue.hao@asu.edu   

module load anaconda/py3
source activate ipa



dir=/scratch/yhao38/duboscqui
cd $dir

#File=duboscqui.hifi.bam
File=duboscqui.fastq.gz

#ipa local --dry-run --nthreads 24 --njobs 1 --run-dir $dir -i $File

#ipa dist -i ../hifi_long_read_data/ELF_19kb.m64001_190914_015449.Q20.38X.fasta \
#--nthreads 24 --njobs 30 --cluster-args 'sbatch -J zev-ipa.{rule} -t 45 \
#-c {params.num_threads} -e stderr -o stdout --get-user-env \
#--chdir pacbio_2020_data_drosophila/hifi_long_read_diploid_ipa_assembly_cluster '

ipa dist -i $File --nthreads 4 --njobs 4 --run-dir $dir --cluster-args 'sbatch -J duboscqui.{rule} -t 3-00:00:00 -c {params.num_threads} -e ipa_%j.err -o ipa_%j.out -p cmecpu1 -q cmeqos'



conda deactivate


