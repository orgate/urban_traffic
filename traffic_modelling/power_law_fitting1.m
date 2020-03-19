tsimul = 5000;
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
%sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
dutyratio = [0.0,0.1,0.5,0.9,1.0];

%bat_array = [83,98,162,172,187,302,307,312,1702,1807,1828,1854,1913,1917,1922,1957,1962,1963];
bat_array = [83,98,162,172,187,302,307,312,1702,1807,1828,1854,1913,1917,1922,1949,1957,1962,1963,1979];

P = 10:10:190;
roadlength = 200;

N = length(sigcyc)*length(dutyratio)*length(P);

p0 = zeros(length(sigcyc),length(P));
gof0 = zeros(length(sigcyc),length(P));

p1 = zeros(length(sigcyc),length(P));
gof1 = zeros(length(sigcyc),length(P));

p5 = zeros(length(sigcyc),length(P));
gof5 = zeros(length(sigcyc),length(P));

p9 = zeros(length(sigcyc),length(P));
gof9 = zeros(length(sigcyc),length(P));

p10 = zeros(length(sigcyc),length(P));
gof10 = zeros(length(sigcyc),length(P));


for batch=1:N
	batch
    if(~ismember(batch,bat_array))
        dr = mod(batch-1,length(dutyratio))+1;
        sig = mod(floor((batch-1)/length(dutyratio)),length(sigcyc))+1;
        p = floor((batch-1)/(length(dutyratio)*length(sigcyc)))+1;
    
        pfil = load(['wait_batch' num2str(batch) '_tsimul' num2str(tsimul) '_sigcyc' num2str(sigcyc(sig)) '_dr' num2str(dutyratio(dr)*10) '_p' num2str(P(p)) '_L' num2str(round(roadlength)) '.mat']);
    
        tempwt = pfil.wt{1};
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)
    
        if(length(tempwt)>0)
            if(mod(batch-1,5)==0)
                [p0(sig,p), gof0(sig,p)] = plpva(tempwt,1,'xmin',1,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==1)
                [p1(sig,p), gof1(sig,p)] = plpva(tempwt,1,'xmin',1,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==2)
                [p5(sig,p), gof5(sig,p)] = plpva(tempwt,1,'xmin',1,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==3)
                [p9(sig,p), gof9(sig,p)] = plpva(tempwt,1,'xmin',1,'silent');%fixing the xmin to be 3.0
            elseif(mod(batch-1,5)==4)
                [p10(sig,p), gof10(sig,p)] = plpva(tempwt,1,'xmin',1,'silent');%fixing the xmin to be 3.0
            end
        end
        
        clear pfil;
        
    end    
    %wt = waiting(num2str(batch),num2str(tsimul),num2str(sigcyc(sig)),num2str(dutyratio(dr)),num2str(P(p)),num2str(roadlength));
end

%save(['power_law_exponents_approx5.mat'],'p0','gof0','p1','gof1','p5','gof5','p9','gof9','p10','gof10');