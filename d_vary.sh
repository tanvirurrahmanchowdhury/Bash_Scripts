#!/bin/bash


read -p 'Enter the number of NH3 atom: ' NO_OF_NH3
read -p 'Now, enter the number of total atoms: ' ALL_ATOMS
read -p 'Enter y value: ' CELL_SIZE


#####  make the CONTCAR from optimization to be without select T or F

cp CONTCAR_backup   CONTCAR     ### make sure do not touch anything in CONTCAR_backup.

cp INCAR_2  INCAR             #### update to new INCAR 

#sed -e "s/
#//" CONTCAR > CONTCAR_1     ### this is to remove MS-dos end-line characters.

#rm CONTCAR

#mv CONTCAR_1 CONTCAR

#cp CONTCAR CONTCAR_original     ### Do not need this line.

# head -8 CONTCAR >  select0.pp
# tail -1 select0.pp > select.pp

# grep "Sel" select.pp
# R1=$?
# Ret1="${R1//[$'\t\r\n ']}"
# PP="0"

# if [ "$Retl" -eq "$PP" ]
# then

head -$((ALL_ATOMS+9))   CONTCAR    > 0.pp
 
head -7 0.pp >  1_1.pp
head -9 0.pp >  1_0.pp
tail -1 1_0.pp > 1_2.pp
cat  1_1.pp   1_2.pp  > 1.pp

tail -$ALL_ATOMS   0.pp > temp_xyz.pp


cat > JJJ.pp << EOF7
JJJ
EOF7

cat > JJJ1.pp << EOF8
JJJ
EOF8

       for ((j=1; j<=$((ALL_ATOMS-1)); j++))    # no_of_atoms -1
       do
        cat JJJ1.pp JJJ.pp > JJJ3.pp
        cp JJJ3.pp JJJ1.pp
        rm JJJ3.pp
       done

paste JJJ1.pp temp_xyz.pp > J_xyz.pp

grep "JJJ" J_xyz.pp | awk '{print $2, $3, $4}' | head -$ALL_ATOMS  > xyz.pp

rm CONTCAR 

cat 1.pp   xyz.pp >  CONTCAR


# else 
# echo "ok"

# fi

rm *.pp






###  do folders  1-4,   d is increasing from folders 1 to 4  

for ((i=1; i<=4; i++))
do

U=$i


mkdir Up_$U
cd ./Up_$U

# increment or decrement should be around (fixed 0.2 Ang)/CELL_SIZE = (VARy 0.005)
VAR=$(echo "0.2/$CELL_SIZE" | bc -l)    
D=$(echo "$i*$VAR-$VAR" | bc -l)


cp ../CONTCAR ./


# for NH3 above C_nanotube
# total number of lines
head -$((ALL_ATOMS+8)) CONTCAR    > 0.pp
# do not change
head -8 0.pp >  1.pp
#total number of atoms
tail -$ALL_ATOMS 0.pp > xyz.pp
# total number of atoms in  C_nanotube
head -$((ALL_ATOMS-NO_OF_NH3)) xyz.pp > 2.pp
# number of NH3
tail -$NO_OF_NH3 xyz.pp > G_xyz.pp
 
cat > AAA.pp << EOF
AAA  
EOF

cat > AAA1.pp << EOF2
AAA
EOF2
# j is no of NH3 atoms - 1
       for ((j=1; j<=$((NO_OF_NH3-1)); j++))
       do
        cat AAA1.pp AAA.pp > AAA3.pp
        cp AAA3.pp AAA1.pp
        rm AAA3.pp
       done
 
paste AAA1.pp G_xyz.pp > AG_xyz.pp

grep "AAA" AG_xyz.pp | awk '{print $2}' | head -$NO_OF_NH3 > G_x.pp #no of NH3 x_coordinates 
grep "AAA" AG_xyz.pp | awk '{print $4}' | head -$NO_OF_NH3 > G_z.pp #no of NH3 Z_coordinates

grep "AAA" AG_xyz.pp | awk '{print $3}' | head -$NO_OF_NH3 > G_y0.pp # no of NH3 y_coordinates


cat > AGY0.pp << EOF3
A
EOF3

# ii is no of NH3
for ((ii=1; ii<=$NO_OF_NH3; ii++))
do
cat > AGY.pp << EOF4
A$ii  
EOF4

wait

cat AGY0.pp AGY.pp > AGY1.pp

cp AGY1.pp AGY0.pp
rm AGY.pp AGY1.pp

done

# no of NH3
tail -$NO_OF_NH3 AGY0.pp > AG.pp

paste AG.pp G_y0.pp > G_y1.pp

cat > GY0.pp << EOF5
GY0
EOF5

#no of NH3 atoms
for ((q=1; q<=$NO_OF_NH3; q++))
do
ee1=$(grep "A$q " G_y1.pp | awk '{print $2}')
ee2=$(echo "$ee1 + $D" | bc -l)
printf "%20.12e\n" $ee2 > G_y2.pp
cat GY0.pp G_y2.pp > GY1.pp
wait
rm GY0.pp
wait
cp GY1.pp GY0.pp
wait
rm G_y2.pp GY1.pp
wait
done

# no of NH3
tail -$NO_OF_NH3 GY0.pp > G_y.pp

paste G_x.pp G_y.pp G_z.pp > 3.pp

cat 1.pp 2.pp 3.pp > POSCAR

rm *.pp

cp ../INCAR ./
cp ../KPOINTS ./
cp ../POTCAR ./



cd ../
done




###  do folders  W1-W4,   d is decreasing from folders W1 to W4  

for ((i=1; i<=4; i++))
do

U=$i


mkdir Down_$U
cd ./Down_$U

# increment or decrement should be around (fixed 0.2 Ang)/CELL_SIZE = (VARy 0.005)
VAR=$(echo "0.2/$CELL_SIZE" | bc -l)    
D=$(echo "$i*$VAR" | bc -l)


cp ../CONTCAR ./


# for NH3 above C_nanotube
# total number of lines
head -$((ALL_ATOMS+8)) CONTCAR    > 0.pp
# do not change
head -8 0.pp >  1.pp
#total number of atoms
tail -$ALL_ATOMS 0.pp > xyz.pp
# total number of atoms in  C_nanotube
head -$((ALL_ATOMS-NO_OF_NH3)) xyz.pp > 2.pp
# number of NH3
tail -$NO_OF_NH3 xyz.pp > G_xyz.pp
 
cat > AAA.pp << EOF
AAA  
EOF

cat > AAA1.pp << EOF2
AAA
EOF2
# j is no of NH3 atoms - 1
       for ((j=1; j<=$((NO_OF_NH3-1)); j++))
       do
        cat AAA1.pp AAA.pp > AAA3.pp
        cp AAA3.pp AAA1.pp
        rm AAA3.pp
       done
 
paste AAA1.pp G_xyz.pp > AG_xyz.pp

grep "AAA" AG_xyz.pp | awk '{print $2}' | head -$NO_OF_NH3 > G_x.pp #no of NH3 x_coordinates 
grep "AAA" AG_xyz.pp | awk '{print $4}' | head -$NO_OF_NH3 > G_z.pp #no of NH3 Z_coordinates

grep "AAA" AG_xyz.pp | awk '{print $3}' | head -$NO_OF_NH3 > G_y0.pp # no of NH3 y_coordinates


cat > AGY0.pp << EOF3
A
EOF3

# ii is no of NH3
for ((ii=1; ii<=$NO_OF_NH3; ii++))
do
cat > AGY.pp << EOF4
A$ii  
EOF4

wait

cat AGY0.pp AGY.pp > AGY1.pp

cp AGY1.pp AGY0.pp
rm AGY.pp AGY1.pp

done

# no of NH3
tail -$NO_OF_NH3 AGY0.pp > AG.pp

paste AG.pp G_y0.pp > G_y1.pp

cat > GY0.pp << EOF5
GY0
EOF5

#no of NH3 atoms
for ((q=1; q<=$NO_OF_NH3; q++))
do
ee1=$(grep "A$q " G_y1.pp | awk '{print $2}')
ee2=$(echo "$ee1 - $D" | bc -l)
printf "%20.12e\n" $ee2 > G_y2.pp
cat GY0.pp G_y2.pp > GY1.pp
wait
rm GY0.pp
wait
cp GY1.pp GY0.pp
wait
rm G_y2.pp GY1.pp
wait
done

# no of NH3
tail -$NO_OF_NH3 GY0.pp > G_y.pp

paste G_x.pp G_y.pp G_z.pp > 3.pp

cat 1.pp 2.pp 3.pp > POSCAR

rm *.pp

cp ../INCAR ./
cp ../KPOINTS ./
cp ../POTCAR ./



cd ../
done



# monomer_1 / nanotube
mkdir nanotube     # for 

cd nanotube

cp ../CONTCAR ./
#total number of lines
head -$((ALL_ATOMS+8)) CONTCAR    > 0.pp
#do not change
head -6 0.pp >  atom_nanotube_0.pp
# do not change
tail -1 atom_nanotube_0.pp   >  atom_nanotube_1.pp
grep "C "   atom_nanotube_1.pp     | awk '{print $1}' | head -1 > atom_nanotube_ok.pp
# do not change
head -7 0.pp >  num_nanotube_0.pp
tail -1 num_nanotube_0.pp   >  num_nanotube_1.pp
# 2 after grep will be changed because it is the number of C atom
grep "$((ALL_ATOMS-NO_OF_NH3)) "   num_nanotube_1.pp     | awk '{print $1}' | head -1 > num_nanotube_ok.pp
#do no change
head -5 0.pp >  1_0.pp

#do not change
head -8    0.pp > dirct_0.pp
#do not change
tail -1 dirct_0.pp  >   direct.pp

cat  1_0.pp    atom_nanotube_ok.pp     num_nanotube_ok.pp    direct.pp  > 1.pp   


#total number of atoms in our system
tail -$ALL_ATOMS 0.pp > xyz.pp




##########  below is for monomer POSCAR 

# number of C
head -$((ALL_ATOMS-NO_OF_NH3)) xyz.pp > G_xyz.pp    ####
 
cat  1.pp     G_xyz.pp    >   POSCAR 
 
rm *.pp

cp ../INCAR ./
cp ../KPOINTS ./
cp ../POTCAR_1 ./POTCAR



cd ../

############

mkdir ammonia   
cd ammonia

cp ../CONTCAR ./
# total number of lines
head -$((ALL_ATOMS+8)) CONTCAR    > 0.pp
# do not change 
head -6 0.pp >  atom_monomer_1_0.pp
#do not change
tail -1 atom_monomer_1_0.pp   >  atom_monomer_1_1.pp
grep "C "   atom_monomer_1_1.pp     | awk '{print $2, $3}' | head -1 > atom_monomer_1_ok.pp
#do not change
head -7 0.pp >  num_monomer_1_0.pp
#do not change
tail -1 num_monomer_1_0.pp   >  num_monomer_1_1.pp
# 2 after grep will change
grep "$((ALL_ATOMS-NO_OF_NH3))" num_monomer_1_1.pp | awk '{print $2, $3}' | head -1 > num_monomer_1_ok.pp                       #######
# - 5 do not change
head -5 0.pp >  1_0.pp
# do not change
head -8    0.pp > dirct_0.pp
#do not change
tail -1 dirct_0.pp  >   direct.pp

cat  1_0.pp    atom_monomer_1_ok.pp     num_monomer_1_ok.pp    direct.pp  > 1.pp           


#number of all the atoms
tail -$ALL_ATOMS 0.pp > xyz.pp


##########  below is for monomer POSCAR 

# all atoms except carbon
tail -$NO_OF_NH3 xyz.pp > 3.pp                  ################
 
cat  1.pp     3.pp    >   POSCAR 
 
rm *.pp

cp ../INCAR ./
cp ../KPOINTS ./
cp ../POTCAR_2 ./POTCAR



cd ../


#########






