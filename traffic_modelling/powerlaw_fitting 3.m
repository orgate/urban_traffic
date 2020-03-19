%sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
sigcyc = [10,16,25,40,63,100,158,251,398,631,1000];
P = 10:20:200;
%alpha0 = zeros(length(sigcyc),length(P));
%xmin0 = zeros(length(sigcyc),length(P));
%L0 = zeros(length(sigcyc),length(P));

%alpha1 = zeros(length(sigcyc),length(P));
%xmin1 = zeros(length(sigcyc),length(P));
%L1 = zeros(length(sigcyc),length(P));

%alpha5 = zeros(length(sigcyc),length(P));
%xmin5 = zeros(length(sigcyc),length(P));
%L5 = zeros(length(sigcyc),length(P));

for bat=103:550
    bat
    if(mod(bat-1,5)==1)
        sig = mod(floor((bat-1)/5),length(sigcyc))+1;
        p = floor((bat-1)/(length(sigcyc)*5))+1;
        mfil = load(['wait',num2str(bat-1),'_5000_',num2str(sigcyc(sig)),'_1_',num2str(P(p)),'_200.mat']);
        if(length(mfil.wt{1})>0)
%            [alpha5(sig,p), xmin, L5(sig,p)] = plfit(mfil.wt{1},'xmin',3.0);%fixing the xmin to be 3.0
%            [alpha0(sig,p), xmin0(sig,p), L0(sig,p)] = plfit(mfil.wt{1});%fixing the xmin to be 3.0
            [alpha1(sig,p), xmin1(sig,p), L1(sig,p)] = plfit(mfil.wt{1});%fixing the xmin to be 3.0
        end
%     else
%         sig = mod(floor((bat-1)/2),length(sigcyc))+1;
%         p = floor((bat-1)/(length(sigcyc)*2))+1;
%         mfil = load(['wait',num2str(bat-1),'_10000_',num2str(sigcyc(sig)),'_0_',num2str(P(p)),'_200.mat']);
%         if(length(mfil.wt{1})>0)
% %            [alpha0(sig,p), xmin, L0(sig,p)] = plfit(mfil.wt{1},'xmin',3.0);%fixing the xmin to be 3.0
%             [alpha0(sig,p), xmin0(sig,p), L0(sig,p)] = plfit(mfil.wt{1});%fixing the xmin to be 3.0
%         end
        clear mfil;
    end
end
