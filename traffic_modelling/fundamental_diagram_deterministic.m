%short cut to calculate the deterministic mobility and flow vs density
%without simulation
%avg_distance=(L./P)-1
%mobility=c*(avg_distance.^2)./(1+(avg_distance.^2));
%density=P/L;
%flow=mobility.*density;%





P=[5:5:190];%no of cars in the road
L=201; %length of road (includes the traffic signal occupying unit length)
maxtime=10000; %Max time upto which simulation is done
c=1; %maximum speed of cars
sigcyc=120; %Signal cycle
dutyratio=.5; %duty ratio
%gcv=0.1; %coefficient of variation of gaussian distribution for car velocities
greentime=dutyratio*sigcyc; %total time light is green during a signal cycle
redtime=sigcyc-greentime;
shape_parameter=20;

Realization=1;%no of realization
mobility=zeros(1,length(P));
for kl=1:Realization
for lk=1:length(P)
    p=P(lk);%Number of vehicles


distance_travelled_by_allcar=0;


l=randperm(L-1); %randomly generate integers between 1 and L-1 to
%place cars at random positions in the road of length L
l=sort(l(1:p),'ascend');%take the first p numbers for the positions of p cars

time=0; %initialize time


while (time<maxtime)

    green=0; 
    while (green<greentime)
        dis_h=[(diff(l)-1),(L-l(end)+l(1,1)-2)];%distance head
        
        %Function to determine mean velocity (cmax=1) from headway distance
        %Hyperbolic function
        %cmean=c*dis_h./(1+dis_h);
        %Sigmoidal function
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));
        %Deterministic case
        cdi=cmean;
        %Determine individual car velocity from a random distribution having the above mean
        
        %Exponential distribution (method 1)
        %cdi=exprnd(cmean); %using statistical toolbox
        %Exponential distribution (method 2)
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));
        %Gamma distribution
        %scale_parameter=cmean/shape_parameter;
        %cdi=gamrnd(shape_parameter,scale_parameter);
        
        %Gaussian distribution with coefficient of variation gcv
        %cdi=cmean+sqrt(gcv*cmean).*randn(1,p);%min(cdi,cmean)+rand(1,p).*(max(cdi,cmean)-min(cdi,cmean));
        %cdi(cdi<0)=0; %ensures that all velocities are non-negative
        tou=min(dis_h./cdi); %time interval after which next update to be done
        %checking whether the update distance is safe or make to safe
        g=tou;
        %To esnsure that total time green is on does not exceed greentime 
        g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to 30
        green=green+g;
        l=l+g*cdi;
        
       
        
        l(l>L)=l(l>L)-(L-1);
        [l,ind]=sort(l,'ascend');
        
        
       distance_travelled_by_allcar=distance_travelled_by_allcar+sum(g*cdi);
           
    end
    l(l>(L-1))=l(l>(L-1))-(L-1);
    [l,ind]=sort(l,'ascend');
    
    
   
   
   
    
    
    red=0;
    while (red<redtime)
        dis_h=[(diff(l)-1),((L-1)-l(end))];%position of the signal is 100
        
        %Function to determine mean velocity (cmax=1) from headway distance
        %Hyperbolic function
        %cmean=c*dis_h./(1+dis_h);
        %Sigmoidal function
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));
        %Deterministic case
        cdi=cmean;
        %Determine individual car velocity from a random distribution having the above mean
        %Exponential distribution (method 1)
        %cdi=exprnd(cmean); %using statistical toolbox
        %Exponential distribution (method 2)
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));
        %Gamma distribution
        %scale_parameter=cmean/shape_parameter;
        %cdi=gamrnd(shape_parameter,scale_parameter);
        
        %Gaussian distribution with coefficient of variation gcv
        %cdi=cmean+sqrt(gcv*cmean).*randn(1,p);%min(cdi,cmean)+rand(1,p).*(max(cdi,cmean)-min(cdi,cmean));
        %cdi(cdi<0)=0;
        tou=min(dis_h./cdi);
        %checking wheather the update distance is safe or make to safe
            r=tou;
        r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is 30
        red=red+r;
        l=l+r*cdi;
        
        
       distance_travelled_by_allcar=distance_travelled_by_allcar+sum(r*cdi);
        
        
    end
    time=time+sigcyc;
end


mobility(kl,lk)=distance_travelled_by_allcar/(time*p);
end

end%end of no of realization
density=P/L;
flow=mobility.*density;%

figure;subplot(1,2,1), plot(density,mobility);
subplot(1,2,2), plot(density,flow);