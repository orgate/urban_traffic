#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name exp_nofin_var51
#SBATCH -p nandasq
#SBATCH --export=all
#SBATCH --mail-user=alfredajay@imsc.res.in
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR
cat $SLURM_JOB_NODELIST > hostfile_$SLURM_JOBID

./run_wt_times_exponent.sh /opt/apps/matlab/2010b 51
#echo
