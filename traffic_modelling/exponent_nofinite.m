function npcount = exponent_nofinite(batchP)

tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];

%bat_array = [83,98,162,172,187,302,307,312,1702,1807,1828,1854,1913,1917,1922,1957,1962,1963];

%P = 10:10:190;
roadlength = 200;

Np = length(sigcyc)*length(dutyratio);

alpha0 = zeros(1,length(sigcyc));
xmin0 = zeros(1,length(sigcyc));
L0 = zeros(1,length(sigcyc));

alpha1 = zeros(1,length(sigcyc));
xmin1 = zeros(1,length(sigcyc));
L1 = zeros(1,length(sigcyc));

alpha5 = zeros(1,length(sigcyc));
xmin5 = zeros(1,length(sigcyc));
L5 = zeros(1,length(sigcyc));

alpha9 = zeros(1,length(sigcyc));
xmin9 = zeros(1,length(sigcyc));
L9 = zeros(1,length(sigcyc));

alpha10 = zeros(1,length(sigcyc));
xmin10 = zeros(1,length(sigcyc));
L10 = zeros(1,length(sigcyc));

npcount_list = [];

for n=1:Np
	dr = mod(n-1,length(dutyratio))+1;
    sig = mod(floor((n-1)/length(dutyratio)),length(sigcyc))+1;
    p = batchP/10;%floor((batch-1)/(length(dutyratio)*length(sigcyc)))+1;

	batch = (p-1)*105 + (sig-1)*5 + dr

    
    pfil = load(['wait_batch' num2str(batch) '_tsimul' num2str(tsimul) '_sigcyc' num2str(sigcyc(sig)) '_dr' num2str(dutyratio(dr)*10) '_p' num2str(batchP) '_L' num2str(round(roadlength)) '.mat']);
    
    tempwt = pfil.wt{1};
    tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)
    
    if(length(tempwt)>0)
        if(mod(batch-1,5)==0)
            [alpha0(sig), xmin0(sig), L0(sig)] = plfit1(tempwt,'nosmall','sample',10);%fixing the xmin to be 3.0
        elseif(mod(batch-1,5)==1)
        	[alpha1(sig), xmin1(sig), L1(sig)] = plfit1(tempwt,'nosmall','sample',10);%fixing the xmin to be 3.0                
        elseif(mod(batch-1,5)==2)
        	[alpha5(sig), xmin5(sig), L5(sig)] = plfit1(tempwt,'nosmall','sample',10);%fixing the xmin to be 3.0                
        elseif(mod(batch-1,5)==3)
        	[alpha9(sig), xmin9(sig), L9(sig)] = plfit1(tempwt,'nosmall','sample',10);%fixing the xmin to be 3.0                
        elseif(mod(batch-1,5)==4)
        	[alpha10(sig), xmin10(sig), L10(sig)] = plfit1(tempwt,'nosmall','sample',10);%fixing the xmin to be 3.0                
        end
    else
        npcount_list = [npcount_list,n];
	end

    %wt = waiting(num2str(batch),num2str(tsimul),num2str(sigcyc(sig)),num2str(dutyratio(dr)),num2str(P(p)),num2str(roadlength));
end

npcount = length(npcount_list);

save(['power_law_exponents_nofinite_',batchP,'.mat'],'alpha0','xmin0','L0','alpha1','xmin1','L1','alpha5','xmin5','L5','alpha9','xmin9','L9','alpha10','xmin10','L10');