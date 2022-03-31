#!/bin/bash                                                                     
#SBATCH --job-name="Par_biau"                                                     
#SBATCH --ntasks=10                # Number of cores requested                  
#SBATCH --qos=cmeqos               # The queue (line) we are in                 
#SBATCH --partition=cmecpu1         # The compute node set to submit to         
#SBATCH --output=pb_snp_%j.out                                                      
#SBATCH --error=pb_snp_%j.err                                                       
#SBATCH --time=2-00:00:00                                                       
                                          
                                                                                
# Working directory                                                             
cd /scratch/yhao38/biaurelia/snp_call                                           
                                                                                                                                                                                               
                                                                                
for bamfile in *.bam                                                            
do                                                                              
    echo $bamfile                                                               
    samtools idxstats $bamfile | cut -f 1 | grep -v chrM | xargs samtools view -b $bamfile > ${bamfile}_MAC.bam
    rm $bamfile                                                                
done                                                                            
                                                                                
                                                                                
# Reference genome directory                                                    
RD=/scratch/yhao38/Paramecium_reference//biaurelia/V1-4                         
#Ref=biaurelia_V1-4.assembly.fasta                                              
                                                                                
                                                                                
echo "Mapping of Reads and Detection of SNPs and Indels"                        
samtools mpileup -q 30 -Q 20 -t DP -uvf $RD/biaurelia_V1-4.assembly.fasta *_MAC.bam > Pbiau.vcf
bcftools call -f GQ -o Pbiau_snps.vcf -O v -V indels -cv Pbiau.vcf              
bcftools call -f GQ -o Pbiau_indels.vcf -O v -V snps -cv Pbiau.vcf              
                                                                                
echo "filtering snp and indel files for depth and biases"                       
perl /home/yhao38/bin/vcfutils.pl varFilter -d 50 -D 800 -1 -2 -3 -4 Pbiau_snps.vcf > Pbiau_snpsfiltered1.vcf
perl /home/yhao38/bin/vcfutils.pl varFilter -d 50 -D 800 -1 -2 -3 -4 Pbiau_indels.vcf > Pbiau_indelsfiltered1.vcf
vcftools --vcf Pbiau_snpsfiltered1.vcf --minQ 20 --minGQ 30 --minDP 4 --recode --recode-INFO-all --out Pbiau_snpsfiltered2
vcftools --vcf Pbiau_indelsfiltered1.vcf --minQ 20 --minGQ 30 --minDP 4 --recode --recode-INFO-all --out Pbiau_indelsfiltered2
                                                                                
echo "filter out the recoded sites that are not polymorphic anymore, that is, AF1/1"
bcftools view -q 0.001 Pbiau_snpsfiltered2.recode.vcf -o Pbiau_snpsfinal.vcf    
bcftools view -q 0.001 Pbiau_indelsfiltered2.recode.vcf -o Pbiau_indelsfinal.vcf
