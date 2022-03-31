#!/bin/bash
#SBATCH --job-name="buildDB"                                                     
#SBATCH -p fn3                      # Use fn1 partition                         
#SBATCH -N 1                        # number of compute nodes                   
#SBATCH -n 8                       # number of CPU cores to reserve on this compute node
#SBATCH --output=build_%j.out                                                      
#SBATCH --error=build_%j.err                                                       
#SBATCH --time=2-00:00:00                                                       

# cd /scratch/yhao38/Kraken
# cp *.fa /scratch/yhao38/kraken_db
cd /scratch/yhao38/kraken_db

# Paramecium DB

for file in *.fa
do
    kraken2-build --add-to-library $file --db Paramecium_db
    rm $file
done

kraken2-build --build --db Paramecium_db
bracken-build -d /scratch/yhao38/kraken_db/Paramecium_db -t 8 -k 35 -x /home/yhao38/bin

# 16s DB

kraken2-build --db Greengenes --special greengenes
kraken2-build --build --db Greengenes
bracken-build -d /scratch/yhao38/kraken_db/Greengenes -t 8 -k 35 -x /home/yhao38/bin
