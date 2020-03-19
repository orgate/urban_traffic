import sys
import os
import subprocess
import time


tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
#sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];
P = range(10,200,10);
roadlength = 200;

batchrange = len(sigcyc)*len(dutyratio)*len(P);

for batch in range(batchrange-1000):
#for batch in range(20):
	batch = batch+1000
	print(batch)

	with open("slurm_script_raw.sh", 'r') as file_raw:
		slurm_string = file_raw.read()
	ps = subprocess.Popen(['qstat','-u', 'alfredajay'], stdout = subprocess.PIPE)
	x = subprocess.check_output(['wc', '-l'], stdin = ps.stdout).decode('utf-8')

	while(int(x)>101):
		print("On Halt")
		time.sleep(600)
		x = subprocess.check_output(['wc', '-l'], stdin = ps.stdout).decode('utf-8')
	slurm_string = slurm_string.replace("PARAM1", str(batch))
	slurm_string = slurm_string.replace("PARAM2", str(batch))
#	slurm_string = slurm_string.replace("PARAM3", str(k))
#	slurm_string = slurm_string.replace("PARAM4", str(T))

	with open('slurm_script1.sh', 'w') as slurm_fname:
		slurm_fname.write(slurm_string)
	os.system('qsub slurm_script1.sh')
