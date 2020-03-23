import sys
import os
#import numpy as np

silon = [0.5,1.0,10.0];
rr = [0.6,2.0];
alp = [0.02,0.2,2.0];
bet = [5,10,20];  #multiplying factors not actual values
ret = [0.01,0.02,0.03];

batch=1


for batch in range(9):
	batch = batch + 40
        print batch

	si = batch/54
	rri = (batch/27)%2
	ai = (batch/9)%3
	bi = (batch/3)%3
	beti = alp[ai]*bet[bi]
	ri = batch%3

        slurm_fname = open('slurm_script1.sh', 'w')
        slurm_fname.write('''#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name conj_acc%d
#SBATCH -p nandasq
#SBATCH --export=all
#SBATCH --mail-user=alfredajay@imsc.res.in
#SBATCH --mail-type=FAIL

cd $SLURM_SUBMIT_DIR
cat $SLURM_JOB_NODELIST > hostfile_$SLURM_JOBID

./run_acc_traffic.sh /opt/apps/matlab/2010b %d %2.1f %1.2f %1.2f %1.2f %1.2f
#echo
'''%(batch,batch,silon[si],rr[rri],alp[ai],beti,ret[ri]))

        slurm_fname.close()

    	os.system('sbatch slurm_script1.sh')

