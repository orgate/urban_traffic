% code to plot iso surface lines used in figure 3. a), b) & c)

% for density  - fig3.b)
zval = 10.^(-5:0.5:0);
yz = zeros(2,21);
sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];

for j=1:length(zval)

    for i=1:21
        asd = load(['wt_times_fig3_less_sig_' num2str(sigcyc(1,i)) '.mat']);
        wt_tmp = sort(asd.wt{1},'descend');
%         wt_tmp = wt_tmp(wt_tmp<=3400);
        z2 = (1:length(wt_tmp))./length(wt_tmp);
        [val,ind] = min(abs(z2-zval(1,j)));
        yz(1,i) = wt_tmp(1,ind);
        yz(2,i) = z2(1,ind);
    end
    
    hold on, plot3(sigcyc,yz(1,:),yz(2,:),'r');
end



% % for density  - fig3.b)
% zval = 10.^(-4:0.5:0);
% yz = zeros(2,17);
% dens_P = 10:10:170;
% 
% for j=1:length(zval)
% 
%     for i=1:17
%         asd = load(['wt_times_fig3_less_P_' num2str(i.*10) '.mat']);
%         wt_tmp = sort(asd.wt{1},'descend');
%         wt_tmp = wt_tmp(wt_tmp<=3400);
%         z2 = (1:length(wt_tmp))./length(wt_tmp);
%         [val,ind] = min(abs(z2-zval(1,j)));
%         yz(1,i) = wt_tmp(1,ind);
%         yz(2,i) = z2(1,ind);
%     end
%     
%     hold on, plot3(dens_P,yz(1,:),yz(2,:),'r');
% end


% %for duty ratio  - fig3.c)
% zval = 10.^(-4:0.5:0);
% yz = zeros(2,11);
% dutyr = 0.0:0.1:1.0;
% 
% for j=1:length(zval)
% 
%     for i=1:11
%         asd = load(['wt_times_fig3_less_dr_' num2str(i-1) '.mat']);
%         wt_tmp = sort(asd.wt{1},'descend');
%         z2 = (1:length(wt_tmp))./length(wt_tmp);
%         [val,ind] = min(abs(z2-zval(1,j)));
%         yz(1,i) = wt_tmp(1,ind);
%         yz(2,i) = z2(1,ind);
%     end
%     
%     hold on, plot3(dutyr,yz(1,:),yz(2,:),'r');
% end
