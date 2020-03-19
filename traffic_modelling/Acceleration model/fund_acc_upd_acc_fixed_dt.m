roadlength=200; %total length of the road
tsimul=1000; %Total time of simulation
sigcyc=120; %time signal is red + time signal is green
dutyratio=0.5; %ratio of green signal time to red signal time

alpha=0.2;  %constant1 for friction coefficent (vehicle to the road);
bta=0.2;     %bta for acceleration de-acceleration co-efficent
rt=0.3;       %constant3 reaction time of the driver
rr = 0.6;    %limit of random term in the acceleration
dt = 0.1;    %%% fixed dt or time interval between updates
Dt = [];     %%% collecting all time updates
%Vel = [];    %%% collecting all velocity updates

thresholdspeed=0.1; %speed below which a car is considered to be in a congestion
%P=100; %P is total number of cars
P=[25:5:190];%no of cars in the road
%P=[30,35,40,45,50]; %for different densities
mobility=zeros(1,length(P));

for kl=1:1%no of realization
    for lk=1:length(P)
        p=P(lk);
        fp=(1:1:p);%fix the focusing point
        l=randperm(roadlength);
        l=sort(l(1:p),'ascend');%initialize the space position in link 
        vel_h = zeros(1,p);                                   %%%% intitiaing all velocities
        time=0;
        greentime=dutyratio*sigcyc; %total time light is green during a signal cycle
        redtime=sigcyc-greentime;
        distance_travelled_by_allcar=0;

        while (time<tsimul)
            green=0;
            while (green<greentime)
                dis_h=[(diff(l)-1),(roadlength-l(end)+l(1)-1)];%distance head
%                 dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
                
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=-rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta*(((dis_h-(vel_h*rt)))./(dis_h+1));%%% acceleration update
%                 acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front
                
                acc1 = -vel_h/dt;
                acc2 = 2*(dis_h-(vel_h*dt))/(dt^2);
                ind1 = find(acc1<acc2 & acc<acc1);
                ind2 = find(acc1>acc2 & acc<2*acc1);
                ind3 = find(acc>acc2);
                acc(ind1) = acc1(ind1);
                acc(ind2) = 2*acc1(ind2);
                acc(ind3) = acc2(ind3);
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front
%                 ind1 = find(acc<-vel_h/dt);
%                 ind2 = find(acc>2*(dis_h-(vel_h*dt))/(dt^2));
%                 acc(ind1) = -vel_h(ind1)/dt;
%                 acc(ind2) = 2*(dis_h(ind2)-(vel_h(ind2)*dt))/(dt^2);
                
                g=dt;                                              %%% crucial step that suggests almost fixed dt
                
                g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to greentime
                green=green+g;
                Dt = [Dt,g];                                                %%% collecting all time updates
                d = find(dis_h~=0);
                dist = vel_h(d)*g + 0.5*acc(d)*g*g;
                l(d) = l(d) + vel_h(d)*g + 0.5*acc(d)*g*g;                  %%% distance update
                vel_h = vel_h + acc*g;                                      %%% velocity update
        
                vel_h(vel_h<0) = 0;                                         %%% negative velocities are not possible
         
                distance_travelled_by_allcar=distance_travelled_by_allcar+sum(dist);

                l = mod(l,roadlength);                                      %%% to make sure periodic boundary condition
                [l,ind]=sort(l,'ascend');
                fp=fp(ind);
                vel_h = vel_h(ind);
            end
            
            l = mod(l,roadlength);                                          %%% to make sure periodic boundary condition
            [l,ind]=sort(l,'ascend');
            fp=fp(ind);
            red=0;

            while (red<redtime)
                %dis_h=[(diff(l)-1),(roadlength-l(end))];%position of the signal is 100
                %%%% the above line is replaced by the following line to include
                %%%% the case where a car just crosses the signal when it turns red
                dis_h=[(diff(l)-1),min((roadlength-l(end)),(roadlength-l(end)+l(1)-1))];%position of the signal is 100
%                 dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
        
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=-rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta*(((dis_h-(vel_h*rt)))./(dis_h+1));%%% acceleration update
%                 acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front

                acc1 = -vel_h/dt;
                acc2 = 2*(dis_h-(vel_h*dt))/(dt^2);
                ind1 = find(acc1<acc2 & acc<acc1);
                ind2 = find(acc1>acc2 & acc<2*acc1);
                ind3 = find(acc>acc2);
                acc(ind1) = acc1(ind1);
                acc(ind2) = 2*acc1(ind2);
                acc(ind3) = acc2(ind3);
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front
%                 ind1 = find(acc<-vel_h/dt);
%                 ind2 = find(acc>2*(dis_h-(vel_h*dt))/(dt^2));
%                 acc(ind1) = -vel_h(ind1)/dt;
%                 acc(ind2) = 2*(dis_h(ind2)-(vel_h(ind2)*dt))/(dt^2);
                
                r=dt;                                              %%% crucial step that suggests almost fixed dt
                
                r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is redtime
                red=red+r;
                Dt = [Dt,r];                                                %%% collecting all time updates
                d = find(dis_h~=0);
                
                dist = vel_h(d)*r + 0.5*acc(d)*r*r;
                l(d) = l(d) + vel_h(d)*r + 0.5*acc(d)*r*r;                  %%% distance update
                vel_h = vel_h + acc*r;                                      %%% velocity update
        
                vel_h(vel_h<0) = 0;                                         %%% negative velocities are not possible
                distance_travelled_by_allcar=distance_travelled_by_allcar+sum(dist);

            end
            
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
