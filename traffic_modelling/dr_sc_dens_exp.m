tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];
P = 10:10:190;
roadlength = 200;

N = length(sigcyc)*length(dutyratio)*length(P);

for batch=1169:N
	batch

    dr = mod(batch-1,length(dutyratio))+1;
    sig = mod(floor((batch-1)/length(dutyratio)),length(sigcyc))+1;
    p = floor((batch-1)/(length(dutyratio)*length(sigcyc)))+1;

    wt = waiting(num2str(batch),num2str(tsimul),num2str(sigcyc(sig)),num2str(dutyratio(dr)),num2str(P(p)),num2str(roadlength));
end

