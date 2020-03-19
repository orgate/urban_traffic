%short cut to calculate the deterministic mobility and flow vs density
%without simulation
%avg_distance=(L./P)-1
%mobility=c*(avg_distance.^2)./(1+(avg_distance.^2));
%density=P/L;
%flow=mobility.*density;%


alpha=0.2;  %constant1 for friction coefficent (vehicle to the road);
bta=0.2;     %bta for acceleration de-acceleration co-efficent
rt=.3;       %constant3 reaction time of the driver


P=[10:5:190];%no of cars in the road
L=201; %length of road (includes the traffic signal occupying unit length)
maxtime=10000; %Max time upto which simulation is done   %%%%changed from 10000
c=1; %maximum speed of cars
sigcyc=120; %Signal cycle
dutyratio=0.5; %duty ratio
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

vel_h = zeros(1,p);                                                         %%%% intitiaing all velocities

time=0; %initialize time
loop = 0; %%% just to check the number of loops the code is running

while (time<maxtime)

    green=0; 
    while (green<greentime)
        dis_h=[(diff(l)-1),(L-l(end)+l(1)-2)];%distance head                %%%changed from l(1,1) to l(1) to avoid confusio
        dis_h = round(dis_h*1e8)/1e8;                                                     %%%% rounding off distance values to avoid math errors
        
        %Function to determine mean velocity (cmax=1) from headway distance
        %Hyperbolic function
        %cmean=c*dis_h./(1+dis_h);
        %Sigmoidal function
        %if length(find(dis_h<0))>0 fprintf('green is %d, time is %d and lk is %d\ndis_h is\n',green,time,lk); fprintf('%d, ',dis_h); fprintf('\nl is\n'); fprintf('%d, ',l); fprintf('\n'); break; end    %%%checking for negative values
        %cmean=c*(dis_h.^2)./(1+(dis_h.^2));
        %Determ-inistic case
        %cdi=cmean;
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
        
        
        rndm_deceleration=zeros(1,p);                                       %%%initialize the random deaccelration
        rdm_arr=randperm(p);                                                %%%randomize the car numbers
        rndm_deceleration(rdm_arr(1))=-.6*rand;                             %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
        
        
        acc = -(alpha + rndm_deceleration).*vel_h + bta*((dis_h-(vel_h*rt))./(dis_h+1));           %%% acceleration update
        %acc(dis_h<0.0001) = -100;                                           %%% stop if too close to the car in front
        %vel_h = vel_h + acc;  %%% velocity updating step
        %vel_h(vel_h<0) = 0;                                                 %%% negative velocities are not possible
        %cdi = vel_h;                                                        %%% just using the same velocity term
        
        %tou=min(dis_h./cdi); %time interval after which next update to be done
        del = 2*acc.*dis_h + vel_h.^2;                                      %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as)0/a
        ind_d = intersect(find(dis_h>0),find(del>0));
        ind_d1 = intersect(find(acc<0), find(vel_h>0));
        if length(ind_d1)>0
            tou=min(min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d)), min((-vel_h(ind_d1)./acc(ind_d1))));%%% minimum time required for next update when acceleration is considered
        %checking wheather the update distance is safe to make. Similarly,
        %made sure that velocity remains positive
        else
            tou=min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d));
        end
        g=tou;
        %To esnsure that total time green is on does not exceed greentime 
        g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to 30
        green=green+g;
        %l=l+g*cdi;
        
        l = l + vel_h*g + 0.5*acc*g*g;                                      %%% distance update
        vel0 = vel_h;                                                       %%% velocity (of previous step) used for identifying when velocity crosses threshold
        vel_h = vel_h + acc*g;                                              %%% velocity update
        vel_h(vel_h<0) = 0;                                                 %%% negative velocities are not possible

        cdi = vel_h;
        
        %l(l>L)=l(l>L)-(L-1);  %%%this line replaced with the following
        %line
        %l(l>(L-1))=l(l>(L-1))-(L-1);
        %if l<=0 fprintf('l<=0\n%d, ',l(l<=0)); fprintf('\n'); break; elseif l>=L fprintf('l>=L\n%d, ',l(l>=L)); fprintf('\n'); break; end  %%%%checking for l values beyond range
        l = mod(l,L-1);                                              %%% to make sure periodic boundary condition
        [l,ind]=sort(l,'ascend');
        
        
       distance_travelled_by_allcar=distance_travelled_by_allcar+sum(g*cdi);
           
    end
    %l(l>(L-1))=l(l>(L-1))-(L-1);
    l = mod(l,L-1);                                              %%% to make sure periodic boundary condition
    [l,ind]=sort(l,'ascend');
    
    
   
   
   
    
    
    red=0;
    while (red<redtime)
        %dis_h=[(diff(l)-1),((L-1)-l(end))];%position of the signal is 100
        %%%% the above line is replaced by the following line to include
        %%%% the case where a car just crosses the signal when it turns red
        dis_h=[(diff(l)-1),min(((L-1)-l(end)),(L-l(end)+l(1)-2))];%position of the signal is 100
        dis_h = round(dis_h*1e8)/1e8;                                                     %%%% rounding off distance values to avoid math errors
        
        %Function to determine mean velocity (cmax=1) from headway distance
        %Hyperbolic function
        %cmean=c*dis_h./(1+dis_h);
        %Sigmoidal function
        %if length(find(dis_h<0))>0 fprintf('red is %d, time is %d and lk is %d\n',red,time,lk); break; end
        %cmean=c*(dis_h.^2)./(1+(dis_h.^2));
        %Deterministic case
        %cdi=cmean;
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
        
        rndm_deceleration=zeros(1,p);                                       %%%initialize the random deaccelration
        rdm_arr=randperm(p);                                                %%%randomize the car numbers
        rndm_deceleration(rdm_arr(1))=-.6*rand;                             %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
        
        
        acc = -(alpha + rndm_deceleration).*vel_h + bta*((dis_h-(vel_h*rt))./(dis_h+1));           %%% acceleration update
        acc(dis_h<0.0001) = -100;                                           %%% stop if too close to the car in front
        %vel_h = vel_h + acc;  %%% velocity updating step
        %vel_h(vel_h<0) = 0;                                                 %%% negative velocities are not possible
        %cdi = vel_h;                                                        %%% just using the same velocity term
        
        %tou=min(dis_h./cdi);
        del = 2*acc.*dis_h + vel_h.^2;                                      %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as)0/a
        ind_d = intersect(find(dis_h>0),find(del>0));
        ind_d1 = intersect(find(acc<0), find(vel_h>0));
        if length(ind_d1)>0
            tou=min(min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d)), min((-vel_h(ind_d1)./acc(ind_d1))));%%% minimum time required for next update when acceleration is considered
        %checking wheather the update distance is safe to make. Similarly,
        %made sure that velocity remains positive
        else
            tou=min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d));
        end
            r=tou;
        r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is 30  
        red=red+r;
        
        
        l = l + vel_h*r + 0.5*acc*r*r;                                      %%% distance update
        vel0 = vel_h;                                                       %%% velocity (of previous step) used for identifying when velocity crosses threshold
        vel_h = vel_h + acc*r;                                              %%% velocity update
        vel_h(vel_h<0) = 0;                                                 %%% negative velocities are not possible
        cdi = vel_h;
        %l=l+r*cdi;
        
        
       distance_travelled_by_allcar=distance_travelled_by_allcar+sum(r*cdi);
        
        
    end
    [l,ind]=sort(l,'ascend');                                               %%%% this line is added to avoid non-positive values in the distances
    
    time=time+sigcyc;
end


mobility(kl,lk)=distance_travelled_by_allcar/(time*p);
end

end%end of no of realization
density=P/L;
flow=mobility.*density;%
%loop; %%%%printng number of loops made

figure;subplot(1,2,1), plot(density,mobility);
subplot(1,2,2), plot(density,flow);