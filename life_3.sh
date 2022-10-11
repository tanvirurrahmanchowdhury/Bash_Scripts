#!/bin/bash

cd PBE
qsub d_vary_job.sh

for VAR in PBE_rVV10 SCAN SCAN_rVV10
do 

cd ../$VAR
qsub d_vary_job.sh

echo "I'm done!"

done
