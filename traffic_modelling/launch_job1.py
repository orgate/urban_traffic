import sys
import os
import numpy as np

tsimul = 1000;
sigcyc = 120;
dutyratio = 0.5;
P = 100;
roadlength = 200;

batch=1

for batch in range(3):
        print batch

        pbs_fname = open('pbs_script1.sh', 'w')
        pbs_fname.write('''
#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -N osc_batch_%d
#PBS -q nandaq
#PBS -V
#PBS -M alfredajay@imsc.res.in
#PBS -m n
#PBS -j oe

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > hostfile_$PBS_JOBID

export MCR_CACHE_ROOT = $PBS_O_WORKDIR/MCR
echo $MCR_CACHE_ROOT

./run_test1.sh /usr/local/matlab2010b/ %d %d %d %1.1f %d %d
#echo
''' %(batch, tsimul, sigcyc, dutyratio, P, roadlength) )

        pbs_fname.close()

    	os.system('nohup qsub pbs_script1.sh')
