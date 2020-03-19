import sys
import os
import numpy as np

N = 10
b=0.16
D=0.002
batch=1

for batch in np.linspace(1,50,50):
        print batch

        pbs_fname = open('pbs_script1.sh', 'w')
        pbs_fname.write('''
#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -N osc_batch_%d
#PBS -q satpuraq
#PBS -V
#PBS -M parveenasa@imsc.res.in
#PBS -m n
#PBS -j oe

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > hostfile_$PBS_JOBID

export MCR_CACHE_ROOT = $PBS_O_WORKDIR/MCR
echo $MCR_CACHE_ROOT

./run_thresholdspod_new.sh /usr/local/matlab2010b/ %d %d %2.3f %2.4f
#echo
''' %(batch, N, batch, b, D) )

        pbs_fname.close()

    	os.system('nohup qsub pbs_script1.sh')
