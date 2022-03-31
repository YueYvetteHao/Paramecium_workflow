#!/bin/bash                                                                     
                                                                                
                                                                                
# Working directory                                                             
cd /scratch/yhao38/Param_pop                                                  
                                                                                
# File list                                                                                           
input='/scratch/yhao38/Param_pop/filelist.txt'                          
                                                                                
                                                                                
while IFS= read -r line                                                         
do                                                                              
                                                                                
    rm ${line}_agave.sh                                                         
    echo "#!/bin/bash                                                                      " >> ${line}_agave.sh
    echo "#SBATCH --job-name='${line}'                                                      " >> ${line}_agave.sh
    echo "#SBATCH -p fn1                                   " >> ${line}_agave.sh
    echo "#SBATCH -N 1                                 " >> ${line}_agave.sh    
    echo "#SBATCH -n 4                   " >> ${line}_agave.sh                  
    echo "#SBATCH --output=${line}_%j.out                                                       " >> ${line}_agave.sh
    echo "#SBATCH --error=${line}_%j.err                                                        " >> ${line}_agave.sh
    echo "#SBATCH --time=2-00:00:00                                                        " >> ${line}_agave.sh
    echo "#SBATCH --mail-type=ALL                                                          " >> ${line}_agave.sh
    echo "##SBATCH --mail-user=yue.hao@asu.edu   " >> ${line}_agave.sh          
    echo " " >> ${line}_agave.sh                                                
    echo "./Param_kraken_pipe.sh ${line}" >> ${line}_agave.sh                   
                                                                                
    chmod +x ${line}_agave.sh                                                   
                                                                                
    sbatch ${line}_agave.sh                                                     
                                                                                
                                                                                
                                                                                
done < $input 
