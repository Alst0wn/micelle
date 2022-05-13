#!/bin/bash
#SBATCH -N 1
#SBATCH -p RT
#SBATCH --ntasks-per-node=4

srun ~/bin/lmp_mpi -in in.indent_for_run -log log.log

