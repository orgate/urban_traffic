%%%%% dv/dt = alpha*V_old + const2*F1*F2
%%%%% alpha is deceleration rate due to friction - can be function of position but here
%%%%% taken to be a constant
%%%%% F1 = V_max - V_old  ensures that once you reach V_max you no longer
%%%%% accelerate 
%%%%% F2 = (dis_h-rt*V_old)./dis_h  hyperbolic function of headway distance
%%%%% if headway distance is larger than rt*V_old you can accelerate
%%%%% else you decelerate

p=100;        %number of cars in the road
alpha=-0.2*ones(1,p);  %constant1 for friction coefficent (vehicle to the road);
const2=0.2;  %constant2 for acceleration de-acceleration co-efficent
rt=0.3;%.3;       %constant3 reaction time of the driver
%V_max=2;     %maximum speed of each vehicle
X=[];        %initializing history array of positions of the cars
L=200;       %road length(length unit) with boundary condition

vel=0;
sim_running_time=200;%running time of the simulation
%monitoring first car speed profile
Speed=[];
fp=(1:1:p);  %fix the focusing point

%x is the array of positions of the p cars at each time: 1 by p array
x=randperm(L);%generating the randperm from 1 to L
x=sort(x(1:p),'ascend');%taking first 20 position as the vehicle position
%length of each vehicle is 1 unit length

Dt=[];%update time interval
dt=0.2;

time=0;%initialize the time unit
V_old=rand(1,p);%intitalizing the older velocity for each vehicle





while (time<sim_running_time)
    
    dis_h=[(diff(x)-1),(L-x(end)+x(1)-1)];%headway distance for each vehicle
    %diff(x)-1 is assuming length of the vehicle is 1
    %dis_h(dis_h<0.0001)=0;
    
    rndm_deceleration=zeros(1,p);%initialize the random deaccelration
    rdm_arr=randperm(p);%randomize the car numbers
    rndm_deceleration(rdm_arr(1,1))=-.6*rand;%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .4
    
    
    a=(alpha+rndm_deceleration).*V_old+const2*((dis_h-rt*V_old)./(dis_h+1));%calculate the acceleration quantity for each vehicle%
    %a(isinf(a))=-1;
    
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
    V_old=V_new;
  X=[X ; x];
  
end

figure;for i=1:length(Speed)
hold on;plot(X(i,:),dt*i*ones(1,p),'* r');end


figure;plot(dt*(1:length(Speed)),Speed,'>')
