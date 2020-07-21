"""
Created on Thu Aug 29 17:30:08 2019
Modified 7-May-2020 5:18 am
@author: Tanvir Chowdhury
"""
import numpy as np
from scipy.interpolate import CubicSpline

d0 = float(input('Enter the equillibrium distance: '))

# Down_4 to Up_4
distance = np.zeros(8)

#loop to create the distance array
for n in range(-4,4):
    distance[n + 4] = d0 + n * 0.2
    
#read file, skip the first line, read 2nd column
raw_energy = np.loadtxt('energy_data.txt',skiprows=1,usecols=1,max_rows=10,unpack=True)

monomer_energy = np.sum([raw_energy[-1], raw_energy[-2]]) #last two rows, 2nd column
nanotube_molecule_energy = raw_energy[0:8] #first 7 rows (0 to 7 I mean n-1)

#calculate binding energy
binding_nrg = nanotube_molecule_energy - monomer_energy

# interpolation
f2 = CubicSpline(distance,binding_nrg)

# 100 point interpolation
distance_new = np.linspace(distance[0],distance[7],100)
print('E_min = ',1000*(f2(distance_new).min()),'meV')

# grab the index where Energy is minimum
#ii = np.where(f2(distance_new) == f2(distance_new).min())
ii = np.argmin(f2(distance_new))

# find d_min there
print('D_min =  ',distance_new[ii], 'Angstroms')

'''
plt.plot(distance,1000*nrg_per_C,'o',distance_new,1000*f2(distance_new),'--')
plt.legend(['original data','cubic interpolation'], loc = 'best')
plt.xlabel('Distance (Angstroms)')
plt.ylabel('Binding Energy per C atom (meV)')
plt.show()'''

#writing data into a file
info = 'Binding Energy data'
info += '\nAuthor: Tanvir Chowdhury'
info += '\n Nanotube-NH3 system\n\n'
info += 'Distance (Angstrom) Binding Energy(meV)'
np.savetxt('binding_energy.txt',list(distance_new,f2(distance_new)), header=info,fmt='%20.8f')
