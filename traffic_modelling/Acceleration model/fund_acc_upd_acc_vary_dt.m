roadlength=200; %total length of the road
tsimul=10000; %Total time of simulation
sigcyc=120; %time signal is red + time signal is green
dutyratio=0.5; %ratio of green signal time to red signal time

silon = 0.5;     %%NOV17
%alpha=0.02;  %constant1 for friction coefficent (vehicle to the road);
%bta=0.2;     %bta for acceleration de-acceleration co-efficent
%rt=0.03;       %constant3 reaction time of the driver
rr = 0.6;    %limit of random term in the acceleration
dt = [];     %%% collecting all time updates
%Vel = [];    %%% collecting all velocity updates

thresholdspeed=0.1; %speed below which a car is considered to be in a congestion
%P=100; %P is total number of cars
P=[5:5:190];%no of cars in the road
%P=[30,35,40,45,50]; %for different densities
mobility=zeros(1,length(P));

for kl=1:1%no of realization
    for lk=1:length(P)
        p=P(lk)
        alpha=0.02;%gamrnd(silon,0.02/silon,1,p);%rand(1,P);%0.2;  %constant1 for friction coefficent (vehicle to the road);  %%NOV17
        bta=0.2;%gamrnd(silon,0.2/silon,1,p);%rand(1,P);%0.2;     %bta for acceleration de-acceleration co-efficent  %%NOV17
        rt=0.03;%gamrnd(silon,0.03/silon,1,p);%rand(1,P);%0.3;       %constant3 reaction time of the driver  %%NOV17
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
                dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
                diff_v = [diff(vel_h),vel_h(1)-vel_h(end)];                  %%%% relative velocities  %%NOV17
                
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta.*(((dis_h+(diff_v.*rt)))./(dis_h+1));%%% acceleration update  %%NOV17
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front
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
                dist = vel_h(d)*g + 0.5*acc(d)*g*g;
                l(d) = l(d) + vel_h(d)*g + 0.5*acc(d)*g*g;                  %%% distance update
                
                vel_h0 = vel_h;                                             %%% collecting the previous velocity  %%NOV17
                
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
                dis_h = round(dis_h*1e8)/1e8;                               %%%% rounding off distance values to avoid math errors
                diff_v = [diff(vel_h),vel_h(1)-vel_h(end)];                  %%%% relative velocities  %%NOV17
        
                rndm_deceleration=zeros(1,p);                               %%%initialize the random deaccelration
                rdm_arr=randperm(p);                                        %%%randomize the car numbers
                rndm_deceleration(rdm_arr(1))=rr*rand;                     %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
                
                acc = -(alpha + rndm_deceleration).*vel_h + bta.*(((dis_h+(diff_v.*rt)))./(dis_h+1));%%% acceleration update  %%NOV17
                acc(dis_h==0) = -100;                                       %%% stop if too close to the car in front
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

density=P/roadlength;
flow=mobility.*density;%
%loop; %%%%printng number of loops made

figure;subplot(1,2,1), plot(density,mobility);
subplot(1,2,2), plot(density,flow);
