#!/bin/bash   
#PBS -l nodes=5:ppn=20               
#PBS -l walltime=40:00:00      
#PBS -N mono_job 
#PBS -j oe 
cd ${PBS_O_WORKDIR}


cd nanotube
mpirun -np 100 vasp_std>out_mono.o
wait
cd ..


cd ammonia
mpirun -np 100 vasp_std>out_mono.o
wait
cd ..
done
