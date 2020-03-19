
%%%%% dv/dt = alpha*V_old + const2*F1*F2
%%%%% alpha is deceleration rate due to friction - can be function of position but here
%%%%% taken to be a constant
%%%%% F1 = V_max - V_old  ensures that once you reach V_max you no longer
%%%%% accelerate 
%%%%% F2 = (dis_h-rt*V_old)./dis_h  hyperbolic function of headway distance
%%%%% if headway distance is larger than rt*V_old you can accelerate
%%%%% else you decelerate

alpha=-0.2;  %constant1 for friction coefficent (vehicle to the road);
bta=0.2;     %bta for acceleration de-acceleration co-efficent
rt=.3;       %constant3 reaction time of the driver
X=[];        %initializing history array of positions of the cars
p=100;        %number of cars in the road
L=200;       %road length(length unit) with boundary condition
dutyratio=0.5; %ratio of green signal time to red signal time
rr = 0.6;    %limit of random term in the acceleration
dt=0.2;%10080/22156;        %%% fixed time interval (average value got from variable update scheme)

thresholdspeed=0.1; %speed below which a car is considered to be in a congestion
vel=0;
sim_running_time=1800;%running time of the simulation
%monitoring first car speed profile
%Speed=[];
fp=(1:1:p);  %fix the focusing point

%x is the array of positions of the p cars at each time: 1 by p array
l=randperm(L);%generating the randperm from 1 to L
l=sort(l(1:p),'ascend');%taking first 20 position as the vehicle position
%length of each vehicle is 1 unit length

%Dis=[];%update time interval
%Vel = [];
%Fp = [];

time=0;%initialize the time unit
vel_h = rand(1,p);%ones(1,p)*thresholdspeed;                                                         %%%% intitiaing all velocities



wt=cell(1,length(P));                                                       %%%array storing how long a car has speed less than thresholdspeed 
fp=(1:1:p);                                                                 %%%fix the focusing point
wt_zr_vl=[];                                                                %%%to store time of selected car whose velocity stays less than thresholdspeed;
tmp=zeros(1,p);
z_s_t=zeros(1,p);                                                           %%%intialize the starting time of car 1 whose velocity stays under thresholdspeed



signal_cylce=120;%length of duty cycle of the signal
green_time=dutyratio*sigcyc; %total time light is green during a signal cycle
red_time=sigcyc-green_time;


while (time<sim_running_time)
    
    
    green=0;   
        while (green < green_time)
    dis_h=[(diff(l)-1),(L-l(end)+l(1)-1)];%headway distance for each vehicle
    %diff(x)-1 is assuming length of car is 1
    %dis_h(dis_h<0.0001)=0;
    %dis_h = round(dis_h*1e8)/1e8;                                                     %%%% rounding off distance values to avoid math errors
    %Dis = [Dis;dis_h];    
        
        
    rndm_deceleration=zeros(1,p);                                       %%%initialize the random deaccelration
    rdm_arr=randperm(p);                                                %%%randomize the car numbers
    rndm_deceleration(rdm_arr(1))=-rr*rand;                             %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
        
    
    acc = (alpha - rndm_deceleration).*vel_h + bta*(((dis_h-(vel_h*rt)))./(dis_h+1));           %%% acceleration update
    %a(isinf(a))=-1;
     %emergency stop
    acc(dis_h==0)=-100;  %stop if you are too close to a car
    
    
    del = 2*acc.*dis_h + vel_h.^2;                                      %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as))/a
    ind_d = find(del>=0 & acc~=0);
    ind_d1 = find(del<0 & acc~=0);
    ind_d2 = find(acc==0 & vel_h~=0 & dis_h~=0);
    tou1 = [(sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d), -vel_h(ind_d1)./acc(ind_d1), dis_h(ind_d2)./vel_h(ind_d2)];
    tou = min(tou1(tou1~=0));
        
    
    d = find(dis_h~=0);
    l(d) = l(d) + vel_h(d)*dt + 0.5*acc(d)*dt*dt;                                      %%% distance update
    vel_h = vel_h + acc*dt;                                              %%% velocity update
    %vel_h(vel_h<0)=0;  %because velocity cannot be negative
    %l = l + vel_h*dt;
    
    %V_new=V_old+a*dt;%updating the speed for each vehicle
    %V_new = min(V_new,dis_h/dt);    %%% this is to make sure the car doesn't collide the front one
    %Dt=[Dt,dt];
    %x=x+V_new*dt;%updating the position for each vehicle in the road
    
%    vel=vel+sum(V_new*dt);
    
%    Speed=[Speed,V_new(fp==1)];%noting the particular speed of the vehicle
    cdi = vel_h;
    %Vel = [Vel;V_new];



        for klj=1:p
       if (cdi(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
       %if (cdi(klj)<thresholdspeed)%&&(l(fp==1)>65)
          if (tmp(klj)==0) 
              tmp(klj)=1;
              z_s_t(klj)=time+green + dt + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj);%%% time at which the velocity drops below the threshold
          end
       end
       %if (~(cdi(klj)<thresholdspeed))%&&(l(fp==1)>65)
        if (~(cdi(fp==klj)<thresholdspeed))
            if (tmp(klj)==1)
                tmp(klj)=0;
                wt_zr_vl=[wt_zr_vl,time+green-z_s_t(klj) + dt + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj)];%%% time at which the velocity rises above the threshold
            end
        end
        end
        
        
        
        vel_h(vel_h<0)=0;  %because velocity cannot be negative
        
        
        l = mod(l,L);                                              %%% to make sure periodic boundary condition
        [l,ind]=sort(l,'ascend');
%        l(l>L+1)=l(l>L+1)-(L);
%        [l,ind]=sort(l,'ascend');
        
        
        fp=fp(ind);
        vel_h = vel_h(ind);
        %x(x>L+1)=x(x>L+1)-(L);
        %[x,ind]=sort(x,'ascend');
        %V_new=V_new(ind);
        %Fp = [Fp;fp];   %% just added to check
        %fp=fp(ind);
        
        
        
        
        
    %time=time+dt;%updating the time
    green=green+dt;%updating the green time duration
%    V_old=V_new;
    X=[X ; l];
        end
        
        %x(x>(L-1))=x(x>(L-1))-(L-1);
%    l(l>L)=l(l>L)-(L);
%    [l,ind]=sort(l,'ascend');
    l = mod(l,L);                                              %%% to make sure periodic boundary condition
    [l,ind]=sort(l,'ascend');
    fp=fp(ind);
    vel_h = vel_h(ind);
  
  
  red=0;
        while (red < red_time)
    %dis_h=[(diff(l)-1),(L-l(end))];%headway distance for each vehicle
    dis_h=[(diff(l)-1),min(L-l(end),L-l(end)+l(1)-1)];%headway distance for each vehicle
    %diff(x)-1 is assuming length of car is 1
    %dis_h(dis_h<0.0001)=0;
    %dis_h = round(dis_h*1e8)/1e8;                                                     %%%% rounding off distance values to avoid math errors
    %Dis = [Dis;dis_h];    
        

        
        
    rndm_deceleration=zeros(1,p);                                       %%%initialize the random deaccelration
    rdm_arr=randperm(p);                                                %%%randomize the car numbers
    rndm_deceleration(rdm_arr(1))=-rr*rand;                             %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
        

    
    %emergency stop
    acc = (alpha - rndm_deceleration).*vel_h + bta*(((dis_h-(vel_h*rt)))./(dis_h+1));           %%% acceleration update
    %a=(alpha - rndm_deceleration).*V_old+bta*((dis_h-rt*V_old)./(dis_h+1));%calculate the acceleration quantity for each vehicle%
    %a(isinf(a))=-1;
    
    acc(dis_h==0)=-100;  %stop if you are too close to a car
    

    del = 2*acc.*dis_h + vel_h.^2;                                      %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as)0/a
    ind_d = find(del>=0 & acc~=0);
    ind_d1 = find(del<0 & acc~=0);
    ind_d2 = find(acc==0 & vel_h~=0 & dis_h~=0);
    tou1 = [(sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d), -vel_h(ind_d1)./acc(ind_d1), dis_h(ind_d2)./vel_h(ind_d2)];
    tou = min(tou1(tou1>0));
    
    %V_new=V_old+a*dt;%updating the speed for each vehicle
    %V_new = min(V_new,dis_h/dt);    %%% this is to make sure the car doesn't collide the front one
%    if (dis_h(end)<.25)
%        V_new(end)=0;
%    end
    %Dt=[Dt,dt];
    %x=x+V_new*dt;%updating the position for each vehicle in the road

    
    d = find(dis_h~=0);
    l(d) = l(d) + vel_h(d)*dt + 0.5*acc(d)*dt*dt;                                      %%% distance update
    vel_h = vel_h + acc*dt;                                              %%% velocity update
    %vel_h(vel_h<0)=0;  %because velocity cannot be negative
    %l = l + vel_h*dt;
    %if (dis_h(end)<.25)
    %    vel_h(end)=0;
    %end
    cdi = vel_h;

%    vel=vel+sum(V_new*dt);
    
%    Speed=[Speed,V_new(fp==1)];%noting the particular speed of the vehicle
    %cdi = V_new;
    %Vel = [Vel;V_new];



        for klj=1:p
       %if (cdi(klj)<thresholdspeed)%&&(l(fp==1)>65)
       if (cdi(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
          if (tmp(klj)==0) 
              tmp(klj)=1;
              z_s_t(klj)=time+green_time+red + dt + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj);%%% time at which the velocity drops below the threshold
          end
       end
       %if (~(cdi(klj)<thresholdspeed))%&&(l(fp==1)>65)
       if (~(cdi(fp==klj)<thresholdspeed))
            if (tmp(klj)==1)
                tmp(klj)=0;
                wt_zr_vl=[wt_zr_vl,time+green_time+red-z_s_t(klj) + dt + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj)];%%% time at which the velocity rises above the threshold
            end
        end
        end


        
    vel_h(vel_h<0)=0;  %because velocity cannot be negative
        
    
    %x(x>L)=x(x>L)-(L);
        %[x,ind]=sort(x,'ascend');
        %V_new=V_new(ind);
        
        %fp=fp(ind);
        
        
        
        
        
    %time=time+dt;%updating the time
    red=red+dt;%updating the green time duration
%    V_old=V_new;
    X=[X ; l];
       end
  time=time+sigcyc;
end
%figure;for i=1:length(Speed)
%hold on;plot(X(i,:),dt*i*ones(1,p),'* r');end


%figure;plot(dt*(1:length(Speed)),Speed,'>')

wt{kl,lk}=wt_zr_vl(1:end); %discarding the first 2000 waiting time values as transients   %%%% chenged from 10000 to 1


figure; loglog(sort(wt{1},'descend'),[1:length(wt{1})]/length(wt{1}),'b o');
