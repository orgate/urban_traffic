load waiting_times_fig3_approximated_v3.mat

signal_cycle=floor(10.^[1:0.1:3]);
%dutyratio = 0:0.1:1;
%P = 10:10:170;

%figure, hold on,
for i=1:21,
    
dumm=wt_times_sig2{i,1};
hh1=sort(dumm,'descend');
plot3(signal_cycle(i)*ones(size(hh1)),hh1,[1:length(hh1)]/length(hh1),'-'); hold on;
end;
set(gca,'ZScale','log'), set(gca,'YScale','log'), set(gca,'XScale','log'),
set(gca,'FontSize',14)
xlabel('signal cycle T');ylabel('waiting times \tau');zlabel('P ( \tau | T )')
%xlabel('Duty ratio');ylabel('waiting times \tau');zlabel('P ( \tau )');
%xlabel('No. of cars P');ylabel('waiting times \tau');zlabel('P ( \tau | P )');
grid;

