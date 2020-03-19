function alpha = approx_power_law(batch)

tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];
P = 10:10:190;
roadlength = 200;

alpha = 0;
xmin = 0;
L = 0;

batch = str2num(batch);

dr = mod(batch-1,length(dutyratio))+1;
sig = mod(floor((batch-1)/length(dutyratio)),length(sigcyc))+1;
p = floor((batch-1)/(length(dutyratio)*length(sigcyc)))+1;


pfil = load(['wait_batch' num2str(batch) '_tsimul' num2str(tsimul) '_sigcyc' num2str(sigcyc(sig)) '_dr' num2str(dutyratio(dr)*10) '_p' num2str(P(p)) '_L' num2str(round(roadlength)) '.mat']);
    
if(length(pfil.wt{1})>0)
    if(mod(batch-1,5)==0)
        [alpha, xmin, L] = plfit(pfil.wt{1})%,'sample',100);%fixing the xmin to be 3.0
    elseif(mod(batch-1,5)==1)
        [alpha, xmin, L] = plfit(pfil.wt{1})%,'sample',100);%fixing the xmin to be 3.0                
    elseif(mod(batch-1,5)==2)
        [alpha, xmin, L] = plfit(pfil.wt{1})%,'sample',100);%fixing the xmin to be 3.0                
    elseif(mod(batch-1,5)==3)
        [alpha, xmin, L] = plfit(pfil.wt{1})%,'sample',100);%fixing the xmin to be 3.0                
    elseif(mod(batch-1,5)==4)
        [alpha, xmin, L] = plfit(pfil.wt{1})%,'sample',100);%fixing the xmin to be 3.0                
    end
end
    
    %wt = waiting(num2str(batch),num2str(tsimul),num2str(sigcyc(sig)),num2str(dutyratio(dr)),num2str(P(p)),num2str(roadlength));
save(['approx_power_law_batch',num2str(batch),'.mat'],'alpha','xmin','L');

end