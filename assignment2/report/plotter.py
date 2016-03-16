import matplotlib.pyplot as plt
import sys
import csv

fnames = ['mpi2.txt','mpi4.txt','mpi8.txt', 'openMp.txt', 'singleThread.txt']
for filename in fnames:
    with open(filename) as f:
        reader = csv.reader(f)
        t = []
        n = []
        for row in reader:
            n.append(int(row[0]))
            t.append(float(row[1]))
        plt.loglog(n,t)
plt.show()
