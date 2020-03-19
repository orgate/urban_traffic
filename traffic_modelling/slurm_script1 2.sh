#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name exp_fig4_1994
#SBATCH -p nandasq
#SBATCH --export=all
#SBATCH --mail-user=alfredajay@imsc.res.in
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR
cat $SLURM_JOB_NODELIST > hostfile_$SLURM_JOBID

./run_powerlaw_exponent_v2.sh /opt/apps/matlab/2010b 1994
#echo
