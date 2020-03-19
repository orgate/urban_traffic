function npcount = exponent_nofinite(batchP_str)

batchP = str2num(batchP_str);
tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];

bat_array = [83,98,162,172,187,302,307,312,1702,1807,1828,1854,1913,1917,1922,1957,1962,1963];

%P = 10:10:190;
roadlength = 200;

Np = length(sigcyc)*length(dutyratio);

alpha = zeros(1,19);
xmin = zeros(1,19);
l = zeros(1,19);

npcount_list = [];

for n=1:19

    dr = mod(batchP-1,length(dutyratio))+1;
    sig = mod(floor((batchP-1)/length(dutyratio)),length(sigcyc))+1;
    p = n*10;%floor((batch-1)/(length(dutyratio)*length(sigcyc)))+1;

	bat = (n-1)*105 + (sig-1)*5 + dr

    
    if(~ismember(bat,bat_array))
    
        pfil = load(['wait_batch',num2str(bat),'_tsimul',num2str(tsimul),'_sigcyc',num2str(sigcyc(sig)),'_dr',num2str(dutyratio(dr)*10),'_p',num2str(p),'_L',num2str(round(roadlength)),'.mat']);
    
        tempwt = pfil.wt{1};
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)
    
        if(length(tempwt)>0)
            [alpha(1,n), xmin(1,n), L(1,n)] = plfit1(tempwt,'nosmall');%fixing the xmin to be 3.0
        else
            npcount_list = [npcount_list,n];
        end
    end

    %wt = waiting(num2str(batch),num2str(tsimul),num2str(sigcyc(sig)),num2str(dutyratio(dr)),num2str(P(p)),num2str(roadlength));
end

npcount = length(npcount_list);

%save(['power_law_exponents_nofinite_',num2str(batchP),'.mat'],'alpha0','xmin0','L0','alpha1','xmin1','L1','alpha5','xmin5','L5','alpha9','xmin9','L9','alpha10','xmin10','L10');
save(['power_law_exponents_nofinite_',num2str(batchP),'.mat'],'alpha','xmin','L');
