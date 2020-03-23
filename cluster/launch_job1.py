import sys
import os
#import numpy as np

tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
#sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];
P = range(10,200,10);
roadlength = 200;

batch=1

#for batch in range(len(sigcyc)*len(dutyratio)*len(P)):
for batch in range(29):
	batch = batch+1967
        print batch
	batch = batch-1
	dr = batch%len(dutyratio)
	sig = (batch/len(dutyratio))%len(sigcyc)
	p = ((batch/len(dutyratio))/len(sigcyc))%len(P)
	batch = batch+1

        pbs_fname = open('pbs_script1.sh', 'w')
        pbs_fname.write('''
#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -N osc_batch_%d
#PBS -q nandaitraq
#PBS -V
#PBS -M alfredajay@imsc.res.in
#PBS -m n
#PBS -j oe

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > hostfile_$PBS_JOBID

export MCR_CACHE_ROOT = $PBS_O_WORKDIR/MCR
echo $MCR_CACHE_ROOT

./run_figure_4_mats.sh /opt/apps/matlab/2010b %d %d %d %1.1f %d %d
#echo
''' %(batch, batch, tsimul, sigcyc[sig], dutyratio[dr], P[p], roadlength) )

        pbs_fname.close()

    	os.system('nohup qsub pbs_script1.sh')
