#!/home/common/studtscm04/anaconda3/bin/python
#SBATCH -N 1
#SBATCH --cpus-per-task=4 # OpenMP threads

from ase.io import read
import pickle
from multiprocessing import Pool

def readdump (st):
    print(st)
    read('logsndumps/'+st+'.dump', index = ':')

num = ['0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0', '1.1', '1.2', '1.3']
with Pool(4) as p:
    data1 = p.map(readdump,num)
for n in num:
    with open ('pickles/'+n+'.pickle', 'wb') as f:
        pickle.dump(data1, f)