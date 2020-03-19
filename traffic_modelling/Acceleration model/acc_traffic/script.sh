#!/bin/bash
#SLURM -N 1
#SLURM --ntasks-per-node=28
#SLURM -J <testrun>
# Available Partition names/Queuename are: 1) nandaq, 2) nandaknlq, 2)nandasq, 3)nandagpuq, 4)nandaphiq
#SLURM -p <partitionname>
#SLURM --export=all
#SLURM --mail-user=<username>@imsc.res.in
#SLURM --mail-type=ALL

cd $SLURM_SUBMIT_DIR
echo $SLURM_JOB_NODELIST > hostfile_$SLURM_JOBID

module load intel/2017
##OpenMP Case
## Make sure the ppn value and OMP_NUM_THREADS value are same or
## leave with SLURM_NTASKS env variable
###   Only One Exectable allowed
export OMP_NUM_THREADS=$SLURM_NTASKS
<your executable> >& out_$SLURM_JOBID

##MPI Case
###   Only One Exectable allowed
#mpirun -np <npvalue> <your/executable/with/path>  >& out_$SLURM_JOBID
