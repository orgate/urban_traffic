%continous space continous time true kinetic monte corlo simulation
L=201; %length of road (includes the traffic signal occupying unit length)
p=60; %10; %Number of vehicles
maxtime=2000; %Max time upto which simulation is done
%simulation will be done upto a integer multiple of sigcyc which is just
%higher than maxtime
c=1; %maximum speed of cars
sigcyc=maxtime+1; %Signal cycle = time signal is red + time signal is green
dutyratio=1; %ratio of green signal time to red signal time
%gcov=0.1; %coefficient of variation of gaussian distribution for car velocities
%gammaK=10; %shape parameter for gamma distribution (=1 for exponential)
specimen_speed=[];
l=randperm(L-1); %randomly generate integers between 1 and L-1 to
%place cars at random positions in the road of length L
l=sort(l(1:p),'ascend');%take the first p numbers for the positions of p cars
space_position_eachcar=cell(1,p);
%Initialization for recording whether signal is green or red for the road
%we are looking at
signalcolor=[];

%Which car to focus on for calculating instantaneous speed
focalcar=10;

%initialization for computing ensemble avg speed
sys_speed=[];

time=0; %initialize time
mob=[]; %mobility: instantaneous velocity of car
flow=0; %flow: number of cars that leave signal per signal cycle
T=[]; %time instants
t_s=[]; %position vector of the cars

%fp=zeros(1,p); %fix the car to focus on for calculating instantaneous velocity
fp=[1:p]; %fix the car to focus on for calculating instantaneous velocity
%cdi=rand(1,p);

greentime=dutyratio*sigcyc; %total time light is green during a signal cycle
redtime=sigcyc-greentime;

while (time<maxtime)

    green=0; 
    while (green<greentime)
        
        signalcolor=[signalcolor,1];
        dis_h=[(diff(l)-1),(L-l(end)+l(1,1)-2)];%distance head
        
        %Function to determine mean velocity (cmax=1) from headway distance
        %Hyperbolic function
        %cmean=c*dis_h./(1+dis_h);
        %Sigmoidal function
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));
        
        %Determine individual car velocity from a random distribution having the above mean
        %%Deterministic
        cdi=cmean;
        
        %Exponential distribution (method 1)
        %cdi=exprnd(cmean); %using statistical toolbox
        %Exponential distribution (method 2)
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));
        %Gaussian distribution with coefficient of variation gcv
        %cdi=cmean+sqrt(gcv*cmean).*randn(1,p);%min(cdi,cmean)+rand(1,p).*(max(cdi,cmean)-min(cdi,cmean));
        %cdi(cdi<0)=0; %ensures that all velocities are non-negative
        
        %%Gamma distributed velocities
        %cdi=gamrnd(gammaK,cmean/gammaK,1,p);
        
        tou=min(dis_h./cdi); %time interval after which next update to be done
        %checking whether the update distance is safe or make to safe
        g=tou;
        %To esnsure that total time green is on does not exceed greentime 
        g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to 30
        green=green+g;
        l=l+g*cdi;
        %mob=mob+sum(g*cdi)/length(l);
        flow(end)=flow(end)+length(l(l>L));
        
        %for computing avg speed
        sys_speed=[sys_speed,mean(cdi)];
       
        
        mob=[mob,cdi(fp==focalcar)];
        l(l>(L-1))=l(l>(L-1))-(L-1);
        [l,ind]=sort(l,'ascend');
        fp=fp(ind); 
        t_s=[t_s;l];
        T=[T,g];
        for jjjjj=1:p
            space_position_eachcar{1,jjjjj}=[space_position_eachcar{1,jjjjj},l(fp==jjjjj)];
        end
    end
    flow(end)=flow(end)+length(l(l>L-1));
    l(l>(L-1))=l(l>(L-1))-(L-1);
    [l,ind]=sort(l,'ascend');

    fp=fp(ind);
    
    %flow=[flow,0];
    red=0;
    while (red<-1)
        signalcolor=[signalcolor,0];
        dis_h=[(diff(l)-1),((L-1)-l(end))];%position of the signal is 100
        
        %Function to determine mean velocity (cmax=1) from headway distance
        %Hyperbolic function
        %cmean=c*dis_h./(1+dis_h);
        %Sigmoidal function
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));
        
        %Determine individual car velocity from a random distribution having the above mean
        %%Deterministic
        cdi=cmean;
        %Exponential distribution (method 1)
        %cdi=exprnd(cmean); %using statistical toolbox
        %Exponential distribution (method 2)
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));
        %Gaussian distribution with coefficient of variation gcv
        %cdi=cmean+sqrt(gcv*cmean).*randn(1,p);%min(cdi,cmean)+rand(1,p).*(max(cdi,cmean)-min(cdi,cmean));
        %cdi(cdi<0)=0;
        
        %%Gamma distributed vehicle speeds 
        %cdi=gamrnd(gammaK,cmean/gammaK,1,p);
        
        tou=min(dis_h./cdi);
        %checking wheather the update distance is safe or make to safe
            r=tou;
        r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is 30
        red=red+r;
        l=l+r*cdi;
        
        %for computing avg speed
        sys_speed=[sys_speed,mean(cdi)];
        
        
        %mob=mob+sum(r*cdi)/length(l);
        mob=[mob,cdi(fp==focalcar)];
        t_s=[t_s;l];
        T=[T,r];
        
        for jjjjj=1:p
            space_position_eachcar{1,jjjjj}=[space_position_eachcar{1,jjjjj},l(fp==jjjjj)];
        end
    end
    flow=[flow,0];
    time=time+sigcyc;
end

c1=cumsum(T);
figure, subplot(2,1,1), 
	for i=1:length(c1),
	hold on,
	plot3(t_s(i,:),c1(i)*ones(1,p),ones(1,p),'r .');
    end
subplot(2,1,2),    
plot(c1,mob,'b-');
hold on,
plot(c1,sys_speed,'r--');
plot(c1,signalcolor,'k .');
figure;
for jjjjj=1:p
    x=diff(space_position_eachcar{1,jjjjj});
    y=find(x<0);
    y=[0,y];
    z=space_position_eachcar{1,jjjjj};
    t=c1;
    for jjj=1:length(y) -1
    hold on;plot(space_position_eachcar{1,jjjjj}(y(jjj)+1:y(jjj+1)),c1(y(jjj)+1:y(jjj+1)),'color',[1,1,1]/30);
    end
end