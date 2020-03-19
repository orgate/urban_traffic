
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

vel=0;
sim_running_time=500;%running time of the simulation
%monitoring first car speed profile
Speed=[];
fp=(1:1:p);  %fix the focusing point

%x is the array of positions of the p cars at each time: 1 by p array
x=randperm(L);%generating the randperm from 1 to L
x=sort(x(1:p),'ascend');%taking first 20 position as the vehicle position
%length of each vehicle is 1 unit length

Dt=[];%update time interval
dt=0.1;

time=0;%initialize the time unit
V_old=rand(1,p);%intitalizing the older velocity for each vehicle

signal_cylce=120;%length of duty cycle of the signal
green_time=60;%green signal duration
red_time  =60;%red signal duration


while (time<sim_running_time)
    
    
    green=0;   
        while (green < green_time)
    dis_h=[(diff(x)-1),(L-x(end)+x(1)-1)];%headway distance for each vehicle
    %diff(x)-1 is assuming length of car is 1
    %dis_h(dis_h<0.0001)=0;
    
    a=alpha*V_old+bta*((dis_h-rt*V_old)./(dis_h+1));%calculate the acceleration quantity for each vehicle%
    %a(isinf(a))=-1;
     %emergency stop
    a(dis_h<0.0001)=-100;  %stop if you are too close to a car
    
    V_new=V_old+a*dt;%updating the speed for each vehicle
    V_new(V_new<0)=0;  %because velocity cannot be negative
    %Dt=[Dt,dt];
    x=x+V_new*dt;%updating the position for each vehicle in the road
    
    vel=vel+sum(V_new*dt);
    
    Speed=[Speed,V_new(fp==1)];%noting the particular speed of the vehicle
    
    
    
    x(x>L)=x(x>L)-(L);
        [x,ind]=sort(x,'ascend');
        V_new=V_new(ind);
        
        fp=fp(ind);
        
        
        
        
        
    time=time+dt;%updating the time
    green=green+dt;%updating the green time duration
    V_old=V_new;
    X=[X ; x];
        end
        
        x(x>(L-1))=x(x>(L-1))-(L-1);
    [x,ind]=sort(x,'ascend');
  
  
  red=0;
        while (red < red_time)
    dis_h=[(diff(x)-1),(L-x(end))];%headway distance for each vehicle
    %diff(x)-1 is assuming length of car is 1
    %dis_h(dis_h<0.0001)=0;
     
    
    %emergency stop
    a=alpha*V_old+bta*((dis_h-rt*V_old)./(dis_h+1));%calculate the acceleration quantity for each vehicle%
    %a(isinf(a))=-1;
    
    a(dis_h<0.0001)=-100;  %stop if you are too close to a car
    
    V_new=V_old+a*dt;%updating the speed for each vehicle
    V_new(V_new<0)=0;  %because velocity cannot be negative
    if (dis_h(end)<.25)
        V_new(end)=0;
    end
    %Dt=[Dt,dt];
    x=x+V_new*dt;%updating the position for each vehicle in the road
    
    vel=vel+sum(V_new*dt);
    
    Speed=[Speed,V_new(fp==1)];%noting the particular speed of the vehicle
    
    
    
    %x(x>L)=x(x>L)-(L);
        %[x,ind]=sort(x,'ascend');
        %V_new=V_new(ind);
        
        %fp=fp(ind);
        
        
        
        
        
    time=time+dt;%updating the time
    red=red+dt;%updating the green time duration
    V_old=V_new;
    X=[X ; x];
       end
  
end
figure;for i=1:length(Speed)
hold on;plot(X(i,:),dt*i*ones(1,p),'.','MarkerSize',4);end


figure;plot(dt*(1:length(Speed)),Speed,'>')

