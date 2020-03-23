
#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -N exp_batch_1812
#PBS -q nandaitraq
#PBS -V
#PBS -M alfredajay@imsc.res.in
#PBS -m n
#PBS -j oe

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE > hostfile_$PBS_JOBID

export MCR_CACHE_ROOT = $PBS_O_WORKDIR/MCR
echo $MCR_CACHE_ROOT

./run_exponents.sh /opt/apps/matlab/2010b 1812
#echo
