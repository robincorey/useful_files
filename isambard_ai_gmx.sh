#!/bin/bash

#SBATCH --job-name=md
#SBATCH --output=md.out
#SBATCH --time=24:00:00         # Hours:Mins:Secs
#SBATCH --gpus=1
#SBATCH --cpus-per-task=144     # there are 144 cpus per node
#SBATCH --array=1-5              # if you want repeats

source /home/u5az/tr24321.u5az/gromacs-2024.4/build/scripts/GMXRC

tpr=md_${SLURM_ARRAY_TASK_ID}

gmx mdrun -v -deffnm $tpr -s $tpr.tpr -nsteps 500000000 -cpi $tpr 
