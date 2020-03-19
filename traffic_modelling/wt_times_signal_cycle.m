load waiting_times_fig3_v2.mat

%signal_cycle=floor(10.^[1:0.1:3]);
%dutyratio = 0:0.1:1;
P = 10:10:170;

%for i=1:21,hh(i)=max(wt_times_sig{i,1});end;
intvl=0.05;
jj1=10.^([-1:intvl:3]);
%wttimedist=zeros(length(signal_cycle),length(jj1)-1);
%wttimedist=zeros(length(dutyratio),length(jj1)-1);
wttimedist=zeros(length(P),length(jj1)-1);

for i=1:17,
    
dumm=wt_times_P{i,1};

hh1=histc(dumm,jj1); %log-binning
kk1=diff(jj1); %finding non=uniform bin-sizes
hh2=hh1(1:end-1)./(length(dumm)*kk1);  %calculating PDF (dividing by num of data points and the non-uniform bin-sizes)
jj2=mean([jj1(1:end-1);jj1(2:end)]); %mid-point of bins
wttimedist(i,:)=hh2;
end;

%[X,Y]=meshgrid(signal_cycle,jj2);
%[X,Y]=meshgrid(dutyratio,jj2);
[X,Y]=meshgrid(P,jj2);
%figure, mesh(X,Y,wttimedist'), set(gca,'XScale','log'), set(gca,'YScale','log'), set(gca,'ZScale','log')
%figure, surf(X,Y,wttimedist'), set(gca,'XScale','log'), set(gca,'YScale','log'), set(gca,'ZScale','log')
%figure, surf(X,Y,log10(wttimedist')), set(gca,'XScale','log'), set(gca,'YScale','log'), 
figure, surf(X,Y,log10(wttimedist')), set(gca,'YScale','log'), %set(gca,'XScale','log'), 
a=colormap('hot');b=a(end:-1:1,:);colormap(b)

set(gca,'FontSize',14)
%xlabel('signal cycle T');ylabel('waiting times \tau');zlabel('log_{10} (P ( \tau | T ) )')
%xlabel('Duty ratio');ylabel('waiting times \tau');zlabel('log_{10} (P ( \tau ) )')
xlabel('No. of cars');ylabel('waiting times \tau');zlabel('log_{10} (P ( \tau ) )')
