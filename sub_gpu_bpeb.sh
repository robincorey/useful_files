#!/bin/bash

#SBATCH --job-name=test_gmx
#SBATCH --nodes=1
#SBATCH --gres=gpu:2          # GPU
#SBATCH --ntasks-per-node=2    
#SBATCH --cpus-per-task=4
#SBATCH --partition gpu      # GPU
#SBATCH --time=48:00:00      # this can be changed
#SBATCH --account=phph030024
#SBATCH --output=out
#SBATCH --error=err
#SBATCH --array=1-1          # changed this for more reps

cd "${SLURM_SUBMIT_DIR}"

module purge
module load openmpi/5.0.3
module load gromacs/2024.2-netlib-lapack

tpr=md_5

gmx_mpi mdrun -deffnm $tpr -s $tpr -nsteps 500000000  &> run-gromacs.out
