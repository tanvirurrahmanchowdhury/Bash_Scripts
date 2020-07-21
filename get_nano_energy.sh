#!/bin/bash

cat > energy_data.txt << EOF2
EE eV
EOF2

for i in {4..1}
do 

cat > 01.pp << EOF3
Down_$i
EOF3

wait

grep "energy without entropy" Down_$i/OUTCAR | awk '{print $8}' | tail -1> 02.pp

paste 01.pp 02.pp > 03.pp
 
cat 03.pp >> energy_data.txt

rm 01.pp 02.pp 03.pp

done



for i in {1..4}
do 

cat > 01.pp << EOF3
Up_$i
EOF3

wait

grep "energy without entropy" Up_$i/OUTCAR | awk '{print $8}' | tail -1> 02.pp

paste 01.pp 02.pp > 03.pp
 
cat 03.pp >> energy_data.txt

rm 01.pp 02.pp 03.pp



done


# monomers



cat > 01.pp << EOF4
Nanotube
EOF4

wait


grep "energy without entropy" nanotube/OUTCAR | awk '{print $8}' | tail -1> 02.pp

paste 01.pp 02.pp > 03.pp

cat 03.pp >> energy_data.txt

rm 01.pp 02.pp 03.pp






cat > 01.pp << EOF4
NH3
EOF4

wait


grep "energy without entropy" ammonia/OUTCAR | awk '{print $8}' | tail -1> 02.pp

paste 01.pp 02.pp > 03.pp

cat 03.pp >> energy_data.txt

rm 01.pp 02.pp 03.pp

