tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = 0:0.1:1;
P = 10:10:190;%range(10,200,10);
roadlength = 200;

batch=1;
wt_times_sig = [];
wt_times_dr = [];
wt_times_P = [];
%for batch in range(len(sigcyc)*len(dutyratio)*len(P)):
for i=1:length(sigcyc)
	batch
    sig = sigcyc(1,i);
    wt = waiting(num2str(batch),num2str(tsimul),num2str(sig),'0.5','100',num2str(roadlength));
    wt_times_sig = [wt_times_sig;wt];
    batch = batch+1;
end


for j=1:length(dutyratio)
	batch
    dr = dutyratio(1,j);
    wt = waiting(num2str(batch),num2str(tsimul),'120',num2str(dr),'100',num2str(roadlength));
    wt_times_dr = [wt_times_dr;wt];
    batch = batch+1;
end

for k=1:length(P)
	batch
    p = P(1,k);
    wt = waiting(num2str(batch),num2str(tsimul),'120','0.5',num2str(p),num2str(roadlength));
    wt_times_P = [wt_times_P;wt];
    batch = batch+1;
end


save(['waiting_times_fig3.mat'],'wt_times_sig','wt_times_dr','wt_times_P');
