#!/bin/bash
#SBATCH --job-name=aDGN
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=2
#SBATCH --time=5-00:00:00
#####SBATCH --mem=100M
#SBATCH --account=PHPH030024
#SBATCH --output=out
#SBATCH --error=err
#SBATCH --array=1-5

cd $SLURM_SUBMIT_DIR

module purge
module load gromacs/2024.2-netlib-lapack

tpr=md_${SLURM_ARRAY_TASK_ID}

gmx_mpi mdrun -deffnm $tpr -s $tpr -nsteps 500000000
