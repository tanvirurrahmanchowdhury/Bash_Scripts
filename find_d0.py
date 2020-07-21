import numpy as np

scaling_factor = float(input('Enter universal scaling factor: '))

ay = float(input('Enter ay (ayy of CUC): '))

c_atom = eval(input('Enter the number of C atoms: '))
all_atoms = eval(input('Enter total number of atoms: '))
#read the CONTCAR file
z_data = np.loadtxt('CONTCAR_backup',skiprows=9,usecols=1,max_rows=all_atoms,unpack=True)
#seperate nanotube z data
nanotube = z_data[0:c_atom]

# seperate ammonia
molecule = z_data[c_atom:all_atoms]

N_atom = molecule[0]

direct_distance = scaling_factor * ay * abs(nanotube[9]-N_atom)
print('d_0 = ', direct_distance)
