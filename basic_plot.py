# import python modules here - you may need to install them first
import matplotlib.pyplot as plt
import numpy as np
import sys

# load your files. here we're just reading one gmx rms output file
x = np.loadtxt("rmsd_1.xvg", usecols=0, comments=['#','@'], unpack=True)
y = np.loadtxt("rmsd_1.xvg", usecols=1, comments=['#','@'], unpack=True)

# plot - you can change loads here
plt.plot(x,y, color='green', linewidth=2)
plt.xlabel('Time (ns)', fontsize=90)
plt.ylabel('RMSD (nm)')
plt.title('whatver you want')

# save
plt.savefig('whatever.pdf', format='pdf')

# show plot (useful if editing your script - very tedious if not)
plt.show()
