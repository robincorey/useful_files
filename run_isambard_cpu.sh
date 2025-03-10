#!/bin/bash

#SBATCH --job-name=md
#SBATCH --output=md.out
#SBATCH --time=24:00:00         # Hours:Mins:Secs
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=144     # there are 144 cpus per node
#SBATCH --array=1-5              # if you want repeats

tpr=md_${SLURM_ARRAY_TASK_ID}

/home/u35q/birac.u35q/modules/gromacs-2024.4/build/bin/gmx mdrun -v -deffnm $tpr -s $tpr.tpr -nsteps 500000000 -cpi $tpr -nt 144
