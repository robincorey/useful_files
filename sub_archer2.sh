#!/bin/bash
#SBATCH --job-name=job
#SBATCH --nodes=4
#SBATCH --tasks-per-node=128  # 4 x 32
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --array=1-3

#SBATCH --account=e280-Corey
#SBATCH --partition=standard
#SBATCH --qos=long

# Setup the environment
module load gromacs/2023.4 # gromacs/2024.2
tpr=md_$SLURM_ARRAY_TASK_ID

export OMP_NUM_THREADS=1

srun --distribution=block:block --hint=nomultithread gmx_mpi mdrun -deffnm $tpr -s $tpr -cpi $tpr.cpt -nsteps 750000000
