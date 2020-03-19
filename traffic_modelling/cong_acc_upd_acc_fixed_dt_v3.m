roadlength=200; %total length of the road
tsimul=1000; %Total time of simulation
sigcyc=120; %time signal is red + time signal is green
dutyratio=0.5; %ratio of green signal time to red signal time

P=100; %100; %P is total number of cars
%P=[30,35,40,45,50]; %for different densities
silon=0.2; %magnitude of heterogeneity in alpha, bta and rt
alpha=0.2*(1+silon*randn(1,P));%rand(1,P);%0.2;  %constant1 for friction coefficent (vehicle to the road);
bta=0.2*(1+silon*randn(1,P));%rand(1,P);%0.2;     %bta for acceleration de-acceleration co-efficent
rt=0.3*(1+silon*randn(1,P));%rand(1,P);%0.3;       %constant3 reaction time of the driver
rr = 0.6;    %limit of random term in the acceleration
dt = 0.1;    %%% fixed dt or time interval between updates
Dt = [];     %%% collecting all time updates
Vel = [];    %%% collecting all velocity updates
X = [];
Acc = [];

thresholdspeed=0.1; %speed below which a car is considered to be in a congestion
wt=cell(1,length(P)); %array storing how long a car has speed less than thresholdspeed 

for kl=1:1%no of realization
    for lk=1:length(P)
        p=P(lk);
        fp=(1:1:p);%fix the focusing point
        l=randperm(roadlength);
        l=sort(l(1:p),'ascend');%initialize the space position in link 
        vel_h = ones(1,p);                                   %%%% intitiaing all velocities
        time=0;
        wt_zr_vl=[];%to store time of selected car whose velocity stays less than thresholdspeed;
        tmp=zeros(1,p);
        z_s_t=zeros(1,p);%intialize the starting time of car 1 whose velocity stays under thresholdspeed
        greentime=dutyratio*sigcyc; %total time light is green during a signal cycle
        redtime=sigcyc-greentime;

        while (time<tsimul)
            green=0;
            while (green<greentime)
                dis_h=[(diff(l)-1),(roadlength-l(end)+l(1)-1)];%distance head
                %dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
                
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly from [0,rr]
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta.*(((dis_h-(vel_h.*rt)))./(dis_h+1));%%% acceleration update
                %acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front

%                 acc1 = -vel_h/dt;
%                 acc2 = 2*(dis_h-(vel_h*dt))/(dt^2);
%                 ind1 = find(acc1<acc2 & acc<acc1);
%                 ind2 = find(acc1>acc2 & acc<2*acc1);
%                 ind3 = find(acc>acc2);
%                 acc(ind1) = acc1(ind1);
%                 acc(ind2) = 2*acc1(ind2);
%                 acc(ind3) = acc2(ind3);
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front

                g=dt;                                              %%% crucial step that suggests almost fixed dt
                
                %g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to greentime
                green=green+g;
                Dt = [Dt,g];                                                %%% collecting all time updates
                d = find(dis_h~=0);
                
                l(d) = l(d) + vel_h(d)*g + 0.5*acc(d)*g*g;                  %%% distance update
                %l = l + vel_h*g + 0.5*acc*g*g;
                vel_h = vel_h + acc*g;                                      %%% velocity update
        
                for klj=1:p
                   
                    if (vel_h(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
                        if ((tmp(klj)==0))% & acc(fp==klj)~=0)
                            tmp(klj)=1;
                            z_s_t(klj)=time+green + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj);%%% time at which the velocity drops below the threshold
                        end
                   end
                   
                   if (~(vel_h(fp==klj)<thresholdspeed))
                       if ((tmp(klj)==1))% & acc(fp==klj)~=0)
                           tmp(klj)=0;
                           wt_zr_vl=[wt_zr_vl,time+green-z_s_t(klj) + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj)];%%% time at which the velocity rises above the threshold
                       end
                   end
                end
                
                vel_h(vel_h<0) = 0;                                         %%% negative velocities are not possible

                l = mod(l,roadlength);                                      %%% to make sure periodic boundary condition
                [l,ind]=sort(l,'ascend');
                fp=fp(ind);
                vel_h = vel_h(ind);
               Vel = [Vel, vel_h(fp==1)];              
               X = [X;l];
%                Acc = [Acc;acc];
            end
            
            l = mod(l,roadlength);                                          %%% to make sure periodic boundary condition
            [l,ind]=sort(l,'ascend');
            fp=fp(ind);
            %vel_h = vel_h(ind);
            red=0;

            while (red<redtime)
                %dis_h=[(diff(l)-1),(roadlength-l(end))];%position of the signal is 100
                %%%% the above line is replaced by the following line to include
                %%%% the case where a car just crosses the signal when it turns red
                dis_h=[(diff(l)-1),min((roadlength-l(end)),(roadlength-l(end)+l(1)-1))];%position of the signal is 100
                %dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
        
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta.*(((dis_h-(vel_h.*rt)))./(dis_h+1));%%% acceleration update
                %acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front

%                 acc1 = -vel_h/dt;
%                 acc2 = 2*(dis_h-(vel_h*dt))/(dt^2);
%                 ind1 = find(acc1<acc2 & acc<acc1);
%                 ind2 = find(acc1>acc2 & acc<2*acc1);
%                 ind3 = find(acc>acc2);
%                 acc(ind1) = acc1(ind1);
%                 acc(ind2) = 2*acc1(ind2);
%                 acc(ind3) = acc2(ind3);
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front

                r=dt;                                              %%% crucial step that suggests almost fixed dt
                
                %r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is redtime
                red=red+r;
                Dt = [Dt,r];                                                %%% collecting all time updates
                d = find(dis_h~=0);
                
                l(d) = l(d) + vel_h(d)*r + 0.5*acc(d)*r*r;                  %%% distance update
                %l = l + vel_h*r + 0.5*acc*r*r;
                vel_h = vel_h + acc*r;                                      %%% velocity update
        
                for klj=1:p

                    if (vel_h(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
                        if ((tmp(klj)==0))% & acc(fp==klj)~=0)
                            tmp(klj)=1;
                            z_s_t(klj)=time+green+red + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj);%%% time at which the velocity drops below the threshold
                        end
                    end
                    
                    if (~(vel_h(fp==klj)<thresholdspeed))
                        if ((tmp(klj)==1))% & acc(fp==klj)~=0)
                            tmp(klj)=0;
                            wt_zr_vl=[wt_zr_vl,time+green+red-z_s_t(klj) + (thresholdspeed-vel_h(fp==klj))/acc(fp==klj)];%%% time at which the velocity rises above the threshold
                        end
                    end
                end
                
                vel_h(vel_h<0) = 0;                                         %%% negative velocities are not possible
               Vel = [Vel, vel_h(fp==1)];              
               X = [X;l];
%                Acc = [Acc;acc];
            end
            
            time=time+sigcyc;
        end
        
        wt{kl,lk}=wt_zr_vl(1:end); %discarding the first 2000 waiting time values as transients   %%%% changed from 10000 to 1
    end
    
end%end of no of realization
figure,
for i=1:length(Vel),
hold on;
plot(X(i,:),dt*i*ones(1,p),'.');
end;

%for generating speed profile of the first car
%figure,
%plot(dt*(1:length(Vel)),Vel,'g <');
figure; loglog(sort(wt{1},'descend'),[1:length(wt{1})]/length(wt{1}),'b o');
