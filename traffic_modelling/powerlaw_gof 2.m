
tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];
P = 10:10:190;
roadlength = 200;
bat_array = [83,98,162,172,187,302,307,312,1702,1807,1828,1854,1913,1917,1922,1957,1962,1963];



% gof0 = zeros(length(sigcyc),length(P));
% gof1 = zeros(length(sigcyc),length(P));
% gof5 = zeros(length(sigcyc),length(P));
% gof9 = zeros(length(sigcyc),length(P));
% gof10 = zeros(length(sigcyc),length(P));


%batch = str2num(batch);
for batch=1216:1995
    batch
    if(~ismember(batch,bat_array))
        dr = mod(batch-1,length(dutyratio))+1;
        sig = mod(floor((batch-1)/length(dutyratio)),length(sigcyc))+1;
        p = floor((batch-1)/(length(dutyratio)*length(sigcyc)))+1;

        pfil = load(['wait_batch' num2str(batch) '_tsimul' num2str(tsimul) '_sigcyc' num2str(sigcyc(sig)) '_dr' num2str(dutyratio(dr)*10) '_p' num2str(P(p)) '_L' num2str(round(roadlength)) '.mat']);
        approx = load(['power_law_exponents_v2_batch',num2str(batch),'.mat']);

        tempwt = pfil.wt{1};
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)


        if(length(tempwt)>0)
            if(mod(batch-1,5)==0)
                [gof0(sig,p)] = power_gof(tempwt,approx.xmin,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==1)
                [gof1(sig,p)] = power_gof(tempwt,approx.xmin,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==2)
                [gof5(sig,p)] = power_gof(tempwt,approx.xmin,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==3)
                [gof9(sig,p)] = power_gof(tempwt,approx.xmin,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==4)
                [gof10(sig,p)] = power_gof(tempwt,approx.xmin,'silent');%fixing the xmin to be 3.0
            end
        end
    
    end
end   
    %wt = waiting(num2str(batch),num2str(tsimul),num2str(sigcyc(sig)),num2str(dutyratio(dr)),num2str(P(p)),num2str(roadlength));
%save(['approx_power_law_batch',num2str(batch),'.mat'],'alpha','xmin','L');
save(['figure_4_gof.mat'],'gof0','gof1','gof5','gof9','gof10');
