#!/bin/bash   
#PBS -l nodes=5:ppn=20               
#PBS -l walltime=40:00:00      
#PBS -N down_job 
#PBS -j oe 
cd ${PBS_O_WORKDIR}

for ((bbb=1; bbb<=4; bbb++))
do
cd ./Down_$bbb

mpirun -np 100 vasp_std>out_w.o
wait
cd ..
done

