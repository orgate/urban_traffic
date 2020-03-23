
#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -N osc_batch_2
#PBS -q nandaq
#PBS -V
#PBS -M alfredajay@imsc.res.in
#PBS -m n
#PBS -j oe

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > hostfile_$PBS_JOBID

export MCR_CACHE_ROOT = $PBS_O_WORKDIR/MCR
echo $MCR_CACHE_ROOT

./run_test1.sh /opt/apps/matlab/2010b 2 10000 120 1.0 100 200
#echo
