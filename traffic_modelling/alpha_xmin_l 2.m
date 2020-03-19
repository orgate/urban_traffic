%function alpha = approx_power_law(batch)

tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];
P = 10:10:190;
roadlength = 200;
bat_array = [83,98,162,172,187,302,307,312,1702,1807,1828,1854,1913,1917,1922,1957,1962,1963];

N = length(sigcyc)*length(dutyratio)*length(P);

alpha0 = zeros(length(sigcyc),length(P));
xmin0 = zeros(length(sigcyc),length(P));
L0 = zeros(length(sigcyc),length(P));

alpha1 = zeros(length(sigcyc),length(P));
xmin1 = zeros(length(sigcyc),length(P));
L1 = zeros(length(sigcyc),length(P));

alpha5 = zeros(length(sigcyc),length(P));
xmin5 = zeros(length(sigcyc),length(P));
L5 = zeros(length(sigcyc),length(P));

alpha9 = zeros(length(sigcyc),length(P));
xmin9 = zeros(length(sigcyc),length(P));
L9 = zeros(length(sigcyc),length(P));

alpha10 = zeros(length(sigcyc),length(P));
xmin10 = zeros(length(sigcyc),length(P));
L10 = zeros(length(sigcyc),length(P));


%batch = str2num(batch);
for batch=1:1995
    batch
    if(~ismember(batch,bat_array))
        dr = mod(batch-1,length(dutyratio))+1;
        sig = mod(floor((batch-1)/length(dutyratio)),length(sigcyc))+1;
        p = floor((batch-1)/(length(dutyratio)*length(sigcyc)))+1;


%pfil = load(['wait_batch' num2str(batch) '_tsimul' num2str(tsimul) '_sigcyc' num2str(sigcyc(sig)) '_dr' num2str(dutyratio(dr)*10) '_p' num2str(P(p)) '_L' num2str(round(roadlength)) '.mat']);
        approx = load(['power_law_exponents_v2_batch',num2str(batch),'.mat']);

%        if(length(pfil.wt{1})>0)
        if(dutyratio(dr)==0.0)
            alpha0(sig,p)   = approx.alpha;
            xmin0(sig,p)    = approx.xmin;
            L0(sig,p)       = approx.L;
        elseif(dutyratio(dr)==0.1)
            alpha1(sig,p)   = approx.alpha;
            xmin1(sig,p)    = approx.xmin;
            L1(sig,p)       = approx.L;
        elseif(dutyratio(dr)==0.5)
            alpha5(sig,p)   = approx.alpha;
            xmin5(sig,p)    = approx.xmin;
            L5(sig,p)       = approx.L;
        elseif(dutyratio(dr)==0.9)
            alpha9(sig,p)   = approx.alpha;
            xmin9(sig,p)    = approx.xmin;
            L9(sig,p)       = approx.L;
        elseif(dutyratio(dr)==1.0)
            alpha10(sig,p)   = approx.alpha;
            xmin10(sig,p)    = approx.xmin;
            L10(sig,p)       = approx.L;
        end
    end
end   
    %wt = waiting(num2str(batch),num2str(tsimul),num2str(sigcyc(sig)),num2str(dutyratio(dr)),num2str(P(p)),num2str(roadlength));
%save(['approx_power_law_batch',num2str(batch),'.mat'],'alpha','xmin','L');
save(['figure_4_exp_nofinite.mat'],'alpha0','xmin0','L0','alpha1','xmin1','L1','alpha5','xmin5','L5','alpha9','xmin9','L9','alpha10','xmin10','L10');

%end