#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name conj_acc48
#SBATCH -p nandasq
#SBATCH --export=all
#SBATCH --mail-user=alfredajay@imsc.res.in
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR
cat $SLURM_JOB_NODELIST > hostfile_$SLURM_JOBID

./run_acc_traffic.sh /opt/apps/matlab/2010b 48 0.5 2.00 2.00 20.00 0.01
#echo
