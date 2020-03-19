roadlength=200; %total length of the road
tsimul=10000; %Total time of simulation
sigcyc=120; %time signal is red + time signal is green
dutyratio=0.5; %ratio of green signal time to red signal time

silon = 10.0;%10.0;     %%NOV17
%alpha=0.02;  %constant1 for friction coefficent (vehicle to the road);
%bta=0.2;     %bta for acceleration de-acceleration co-efficent
%rt=0.03;       %constant3 reaction time of the driver
rr = 0.0;%0.6;    %limit of random term in the acceleration
dt = [];     %%% collecting all time updates
Vel = [];    %%% collecting all velocity updates

thresholdspeed=0.1; %speed below which a car is considered to be in a congestion
P=100; %P is total number of cars
%P=[5:5:190];%no of cars in the road
%P=[30,35,40,45,50]; %for different densities
%mobility=zeros(1,length(P));
L = roadlength;
Acc = [];

for kl=1:1%no of realization
    alpha=0.6;%gamrnd(silon,0.6/silon,1,P);%rand(1,P);%0.2;  %constant1 for friction coefficent (vehicle to the road);
    bta=0.2;%gamrnd(silon,0.2/silon,1,P);%rand(1,P);%0.2;     %bta for acceleration de-acceleration co-efficent
    rt=0.02;%gamrnd(silon,0.02/silon,1,P);%rand(1,P);%0.3;       %constant3 reaction time of the driver
    for lk=1:length(P)
        p=P(lk)

        specimen_speed=[];
        space_position_eachcar=cell(1,p);
        signalcolor=[];
        focalcar=10;
        sys_speed=[];

        time=0; %initialize time
        mob=[]; %mobility: instantaneous velocity of car
        flow=0; %flow: number of cars that leave signal per signal cycle
        T=[]; %time instants
        t_s=[]; %position vector of the cars



        fp=(1:1:p);%fix the focusing point
        l=randperm(roadlength);
        l=sort(l(1:p),'ascend');%initialize the space position in link 
        vel_h = zeros(1,p);                                   %%%% intitiaing all velocities
        time=0;
        greentime=dutyratio*sigcyc; %total time light is green during a signal cycle
        redtime=sigcyc-greentime;
%        distance_travelled_by_allcar=0;

        while (time<tsimul)
            green=0;
            while (green<greentime)
                
                signalcolor=[signalcolor,1];

                dis_h=[(diff(l)-1),(roadlength-l(end)+l(1)-1)];%distance head
                dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
                diff_v = [diff(vel_h),vel_h(1)-vel_h(end)];                  %%%% relative velocities  %%NOV17
                
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta.*(((dis_h+(diff_v.*rt)))./(dis_h+1));%%% acceleration update  %%NOV17
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front

                Acc = [Acc, acc(fp==10)];
                
                det = 2*acc.*dis_h + vel_h.^2;                              %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as))/a
                ind_d = find(det>=0 & acc~=0);
                ind_d1 = find(det<0 & acc~=0);
                ind_d2 = find(acc==0 & vel_h~=0 & dis_h~=0);
                Tou = [(sqrt(det(ind_d)) - vel_h(ind_d))./acc(ind_d), -vel_h(ind_d1)./acc(ind_d1), dis_h(ind_d2)./vel_h(ind_d2)];
                tou = min(Tou(Tou~=0));
                g=tou;
                g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to greentime
                green=green+g;
                dt = [dt,g];                                                %%% collecting all time updates
                d = find(dis_h~=0);
%                dist = vel_h(d)*g + 0.5*acc(d)*g*g;
                l(d) = l(d) + vel_h(d)*g + 0.5*acc(d)*g*g;                  %%% distance update

                flow(end)=flow(end)+length(l(l>L));

              
                vel_h0 = vel_h;                                             %%% collecting the previous velocity  %%NOV17
                
                vel_h = vel_h + acc*g;                                      %%% velocity update
        
                vel_h(vel_h<0) = 0;                                         %%% negative velocities are not possible
         
                sys_speed=[sys_speed,mean(vel_h)];
%                distance_travelled_by_allcar=distance_travelled_by_allcar+sum(dist);

                mob=[mob,vel_h(fp==focalcar)];

                l = mod(l,roadlength);                                      %%% to make sure periodic boundary condition
                [l,ind]=sort(l,'ascend');
                fp=fp(ind);
                vel_h = vel_h(ind);
                
                Vel = [Vel, vel_h(fp==10)];    
                
                
                t_s=[t_s;l];
                T=[T,g];
                for jjjjj=1:p
                    space_position_eachcar{1,jjjjj}=[space_position_eachcar{1,jjjjj},l(fp==jjjjj)];
                end

        
            end
            
            l = mod(l,roadlength);                                          %%% to make sure periodic boundary condition
            [l,ind]=sort(l,'ascend');
            fp=fp(ind);
            red=0;

            
            
            time
            
            
            while (red<redtime)
                signalcolor=[signalcolor,0];
                 %dis_h=[(diff(l)-1),(roadlength-l(end))];%position of the signal is 100
                %%%% the above line is replaced by the following line to include
                %%%% the case where a car just crosses the signal when it turns red
                dis_h=[(diff(l)-1),min((roadlength-l(end)),(roadlength-l(end)+l(1)-1))];%position of the signal is 100
                dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
                diff_v = [diff(vel_h),vel_h(1)-vel_h(end)];                  %%%% relative velocities  %%NOV17
        
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta.*(((dis_h+(diff_v.*rt)))./(dis_h+1));%%% acceleration update  %%NOV17
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front

                Acc = [Acc, acc(fp==10)];
                
                det = 2*acc.*dis_h + vel_h.^2;                              %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as)0/a
                ind_d = find(det>=0 & acc~=0);
                ind_d1 = find(det<0 & acc~=0);
                ind_d2 = find(acc==0 & vel_h~=0 & dis_h~=0);
                Tou = [(sqrt(det(ind_d)) - vel_h(ind_d))./acc(ind_d), -vel_h(ind_d1)./acc(ind_d1), dis_h(ind_d2)./vel_h(ind_d2)];
                tou = min(Tou(Tou>0));
                r=tou;
                r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is redtime
                red=red+r;
                dt = [dt,r];                                                %%% collecting all time updates
                d = find(dis_h~=0);
                
%                dist = vel_h(d)*r + 0.5*acc(d)*r*r;
                l(d) = l(d) + vel_h(d)*r + 0.5*acc(d)*r*r;                  %%% distance update
                vel_h = vel_h + acc*r;                                      %%% velocity update
        
                vel_h(vel_h<0) = 0;                                         %%% negative velocities are not possible
%                distance_travelled_by_allcar=distance_travelled_by_allcar+sum(dist);
                sys_speed=[sys_speed,mean(vel_h)];
                
                
                Vel = [Vel, vel_h(fp==10)];    
                
                
                mob=[mob,vel_h(fp==focalcar)];
                t_s=[t_s;l];
                T=[T,r];
        
                for jjjjj=1:p
                    space_position_eachcar{1,jjjjj}=[space_position_eachcar{1,jjjjj},l(fp==jjjjj)];
                end

        
        
            end

            flow=[flow,0];
            time=time+sigcyc;
        end
        
%        mobility(kl,lk)=distance_travelled_by_allcar/(time*p);
    end
    
end%end of no of realization

% density=P/roadlength;
% flow=mobility.*density;%
% %loop; %%%%printng number of loops made
% 
% figure;subplot(1,2,1), plot(density,mobility);
% subplot(1,2,2), plot(density,flow);


c1=cumsum(T);
figure, %subplot(2,1,1), 
%	for i=1:length(c1),
%	hold on,
%	plot3(t_s(i,:),c1(i)*ones(1,p),ones(1,p),'r .');
%    end
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
    hold on;plot(space_position_eachcar{1,jjjjj}(y(jjj)+1:y(jjj+1)),c1(y(jjj)+1:y(jjj+1)),'b');%,'color',[1,1,1]/30);
    end
end

