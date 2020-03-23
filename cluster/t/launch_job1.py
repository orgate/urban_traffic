import sys
import os
#import numpy as np

tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
#sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];
P = range(10,200,10);
roadlength = 200;
#batcharray = [83,88,162,172,187,302,307,312,390,391,396,397,399,600,697];

batcharray = [83,98,162,172,187,302,307,312,827,830,831,832,833,834,835,837,838,896,897,898,899,900,1151,1152,1153,1154,1155,1156,1157,1158,1159,1160,1702,1807,1828,1854,1913,1917,1922,1957,1962,1963];

#for batch in range(len(sigcyc)*len(dutyratio)*len(P)):
for batch in batcharray:
#	batch = batch+1791
        print batch

        pbs_fname = open('pbs_script1.sh', 'w')
        pbs_fname.write('''
#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -N exp_batch_%d
#PBS -q nandasq
#PBS -V
#PBS -M alfredajay@imsc.res.in
#PBS -m n
#PBS -j oe

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > hostfile_$PBS_JOBID

export MCR_CACHE_ROOT = $PBS_O_WORKDIR/MCR
echo $MCR_CACHE_ROOT

./run_exponents.sh /opt/apps/matlab/2010b %d
#echo
''' %(batch, batch) )

        pbs_fname.close()

    	os.system('nohup qsub pbs_script1.sh')
