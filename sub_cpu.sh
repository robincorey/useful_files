#!/usr/bin/env bash
#SBATCH --job-name=TMEM
#SBATCH --time=48:00:00      # Walltime
#SBATCH --nodes=4            # number of compute nodes
#SBATCH --tasks-per-node=8   # number of tasks per node
#SBATCH --cpus-per-task=1    # the number of CPUs to devote to each task
#SBATCH --mem=8GB            # Total memory for the job.
#SBATCH --partition=cpu      # Queueu name
#SBATCH -o myFileName_out_%j.txt
#SBATCH -e myFileName_err_%j.txt
#SBATCH --account=PHPH030024
#SBATCH --array=1-5

module load openmpi/5.0.3
module load gromacs/2022.6-openblas

cd "${SLURM_SUBMIT_DIR}"

conf_file="nodes_${SLURM_JOBID}.conf"
mynodes=$(scontrol show hostnames ${SLURM_JOB_NODELIST})
# populate MPI hostfile
for node  in ${mynodes}; do
    echo "${node} slots=${SLURM_NTASKS_PER_NODE}" >> ${conf_file}
done

# number of MPI processes
nprocs=$((${SLURM_JOB_NUM_NODES}*${SLURM_NTASKS_PER_NODE}))

tpr=md_${SLURM_ARRAY_TASK_ID}

mpi_cmd01="mpirun -np ${nprocs} --hostfile ${conf_file} gmx_mpi mdrun -deffnm $tpr -s $tpr -cpi $tpr -nice 19 -pin auto"
time ${mpi_cmd01}
