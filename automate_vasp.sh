#!/bin/bash

module load intel-compilers/18.1
module load mpich/3.2.1-intel18.1
module load mkl/18.1

INCR=
KPTS=
PTCR=
PSCR=

CALC_PARAM="folder_name_"
aexx=( )

# Run Calculation
for VAR in "${aexx[@]}"; do
  if [ ! -d $CALC_PARAM$VAR ]; then mkdir $CALC_PARAM$VAR; fi
  
  # Copy files
  if [ -d $CALC_PARAM$VAR ]; then
  cp $INCR $CALC_PARAM$VAR/INCAR
  cp $PTCR $CALC_PARAM$VAR/POTCAR
  cp $KPTS $CALC_PARAM$VAR/KPOINTS
  cp $PSCR $CALC_PARAM$VAR/POSCAR
  
  # Edit INCAR/KPOINTS/POSCAR. Comment any lines don't needed
  sed -i "s/.*AEXX.*/AEXX = $VAR/" $CALC_PARAM$VAR/INCAR
  sed -i "4s/.* .*/$VAR $VAR $VAR/" $CALC_PARAM$VAR/KPOINTS
  sed -i "2s/.*/$VAR/" $CALC_PARAM$VAR/POSCAR
  # Run VASP
  cd $CALC_PARAM$VAR; mpirun vasp_std > vasp.out; cd ../
  
fi
