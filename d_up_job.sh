#!/bin/bash   
#PBS -l nodes=5:ppn=20               
#PBS -l walltime=40:00:00      
#PBS -N up_job 
#PBS -j oe 
cd ${PBS_O_WORKDIR}


for ((bbb=1; bbb<=4; bbb++))
do
cd ./Up_$bbb

mpirun -np 100 vasp_std>out.o
wait
cd ..
done
