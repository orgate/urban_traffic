roadlength=200; %total length of the road
tsimul=500; %Total time of simulation
sigcyc=120; %time signal is red + time signal is green
dutyratio=0.5; %ratio of green signal time to red signal time



alpha=0.2;  %constant1 for friction coefficent (vehicle to the road);
bta=0.2;     %bta for acceleration de-acceleration co-efficent
rt=0.3;       %constant3 reaction time of the driver
rr = 0.6*0;    %limit of random term in the acceleration
dt = [];     %%% collecting all time updates
Vel = [];    %%% collecting all velocity updates
X = [];

thresholdspeed=0.1; %speed below which a car is considered to be in a congestion
P=100; %P is total number of cars
%P=[30,35,40,45,50]; %for different densities
wt=cell(1,length(P)); %array storing how long a car has speed less than thresholdspeed 
c=1; %max speed of all cars
gammaK=1; %shape parameter for gamma distribution (=1 for exponential)

for kl=1:1%no of realization
for lk=1:length(P)
    p=P(lk);

fp=(1:1:p);%fix the focusing point


l=randperm(roadlength);

%fp(1,1)=1;

l=sort(l(1:p),'ascend');%initialize the space position in link 



vel_h = ones(1,p)*thresholdspeed;                                                         %%%% intitiaing all velocities



time=0;

wt_zr_vl=[];%to store time of selected car whose velocity stays less than thresholdspeed;
tmp=zeros(1,p);
z_s_t=zeros(1,p);%intialize the starting time of car 1 whose velocity stays under thresholdspeed

greentime=dutyratio*sigcyc; %total time light is green during a signal cycle
redtime=sigcyc-greentime;

while (time<tsimul)

    green=0;
    while (green<greentime)
        dis_h=[(diff(l)-1),(roadlength+1-l(end)+l(1)-2)];%distance head
        dis_h = round(dis_h*1e8)/1e8;                                                     %%%% rounding off distance values to avoid math errors
        
        %cmean=c*dis_h./(.5+dis_h);%mean speed of each vehicle (cMax=1 hyperbolic function)
        %cmean=c*(dis_h.^2)./(1+(dis_h.^2));%mean speed of each vehicle (cMax=1 sigmoidal function)

        %Deterministic velocity
        %cdi=cmean;
        %
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));%exprnd(cmean);%exponentially genereting speed of the vehicle
        %
        %gamma distributed velocities
        %cdi=gamrnd(gammaK,cmean/gammaK,1,P);                               %%%%commented due to license errors
        %xx = rand([1,P]);                                                %%%%(uniformly distributed) random number for the artificial gamma distribution
        %cdi = (1./(((cmean/gammaK).^gammaK)*gamma(gammaK)))*(xx(1)^gammaK).*(exp(1).^(-xx(1)./(cmean/gammaK)));    %%%artificial gamma distribution

        
        
        rndm_deceleration=zeros(1,p);                                       %%%initialize the random deaccelration
        rdm_arr=randperm(p);                                                %%%randomize the car numbers
        rndm_deceleration(rdm_arr(1))=-rr*rand;                             %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
        
        acc = -(alpha + rndm_deceleration).*vel_h + bta*(((dis_h-(vel_h*rt)))./(dis_h+1));           %%% acceleration update
        %acc = -(alpha)*vel_h + bta*((dis_h-(vel_h*rt))./(dis_h+1));           %%% acceleration update
        acc(dis_h==0) = -100;                                           %%% stop if too close to the car in front
        %vel_h = vel_h + acc;  %%% velocity updating step
        %cdi = vel_h;                                                        %%% just using the same velocity term

        %vel0 = vel_h;                                                       %%% velocity (of previous step) used for identifying when velocity crosses threshold
        %Vel = [Vel; vel_h(fp)];
        %acc(dis_h<0.0001) = 0;                                              %%% to make sure cars don't reverse when close to other cars
        %vel_h(dis_h<0.0001) = 0;                                            %%% to make sure cars stop when close to other cars
        
        
        %tou=min(dis_h./cdi);
        del = 2*acc.*dis_h + vel_h.^2;                                      %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as))/a
        ind_d = find(del>=0 & acc~=0);
        ind_d1 = find(del<0 & acc~=0);
        ind_d2 = find(acc==0 & vel_h~=0 & dis_h~=0);
        tou1 = [(sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d), -vel_h(ind_d1)./acc(ind_d1), dis_h(ind_d2)./vel_h(ind_d2)];
        tou = min(tou1(tou1~=0));
        
        %ind_d = find(acc>0);%intersect(find(dis_h~=0),find(del>0));
        %ind_d1 = intersect(find(acc<0), find(vel_h>0));
        %if length(ind_d)>0 & length(ind_d1)>0
        %    tou=min(min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d)), min((-vel_h(ind_d1)./acc(ind_d1))));%%% minimum time required for next update when acceleration is considered
        %checking wheather the update distance is safe to make. Similarly,
        %made sure that velocity remains positive
        %elseif length(ind_d)>0 & ~(length(ind_d1)>0)
        %    tou = min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d));
        %elseif ~(length(ind_d)>0) & length(ind_d1)>0
        %    tou=min((-vel_h(ind_d1)./acc(ind_d1)));
        %end
            g=tou;
        g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to greentime
        green=green+g;
        dt = [dt,g];                                                        %%% collecting all time updates
        
        d = find(dis_h~=0);
        l(d) = l(d) + vel_h(d)*g + 0.5*acc(d)*g*g;                                      %%% distance update
        vel_h = vel_h + acc*g;                                              %%% velocity update
        
        cdi = vel_h;
        %l=l+g*cdi;
        
        for klj=1:p
       if (cdi(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
          if ((tmp(klj)==0))% & (acc(fp==klj)~=0))
              tmp(klj)=1;
              z_s_t(klj)=time+green + ((thresholdspeed-vel_h(fp==klj))/acc(fp==klj));%%% time at which the velocity drops below the threshold
          end
       end
        if (~(cdi(fp==klj)<thresholdspeed))
            if ((tmp(klj)==1))% & (acc(fp==klj)~=0))
                tmp(klj)=0;
                wt_zr_vl=[wt_zr_vl,time+green-z_s_t(klj) + ((thresholdspeed-vel_h(fp==klj))/acc(fp==klj))];%%% time at which the velocity rises above the threshold
            end
        end
        end
        
        vel_h(vel_h<0) = 0;                                                 %%% negative velocities are not possible

        %l(l>roadlength+1)=l(l>roadlength+1)-roadlength;  %%%this line replaced with the following
        %line
        %l(l>roadlength)=l(l>roadlength)-roadlength;
        %if (length(l(l>roadlength))>0)                      %%% fp helps to locate the position of the car in the cyclic road
        %    fp = circshift(fp',1)';
        %end
        l = mod(l,roadlength);                                              %%% to make sure periodic boundary condition
        [l,ind]=sort(l,'ascend');
        
        
        fp=fp(ind);
        vel_h = vel_h(ind);
        Vel = [Vel, vel_h(fp==1)];
        X = [X;l];
    %tmp=tmp(ind);
    %z_s_t=z_s_t(ind);
           
    end
    %l(l>roadlength)=l(l>roadlength)-roadlength;                             %%%% this line is replaced with the following line
    %l(l>roadlength)=l(l>roadlength)-roadlength;
    %if (length(l(l>roadlength))>0)
    %    fp = circshift(fp',1)';
    %end
    l = mod(l,roadlength);                                              %%% to make sure periodic boundary condition
    [l,ind]=sort(l,'ascend');
    
    
    fp=fp(ind);
    %tmp=tmp(ind);
    %z_s_t=z_s_t(ind);
    
    
    red=0;
    while (red<redtime)
        %dis_h=[(diff(l)-1),(roadlength-l(end))];%position of the signal is 100
        %%%% the above line is replaced by the following line to include
        %%%% the case where a car just crosses the signal when it turns red
        dis_h=[(diff(l)-1),min((roadlength-l(end)),(roadlength-l(end)+l(1)-1))];%position of the signal is 100
        dis_h = round(dis_h*1e8)/1e8;                                                     %%%% rounding off distance values to avoid math errors
        
        %cmean=1*dis_h./(.5+dis_h);%mean speed of each vehicle (cMax=1 hyperbolic function)
        %cmean=c*(dis_h.^2)./(1+(dis_h.^2));%mean speed of each vehicle (cMax=1 sigmoidal fuction)

        %Deterministic
        %cdi=cmean;
        %
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));%exprnd(cmean);%exponentially genereting speed of the vehicle
        %
        %Gamma distributed velocities
        %cdi=gamrnd(gammaK,cmean/gammaK,1,P);                               %%%%commented due to license errors
        %xx = rand([1,P]);                                                %%%%(uniformly distributed) random number for the artificial gamma distribution
        %cdi = (1./(((cmean/gammaK).^gammaK)*gamma(gammaK)))*(xx(1)^gammaK).*(exp(1).^(-xx(1)./(cmean/gammaK)));    %%%artificial gamma distribution
        
        
        
        rndm_deceleration=zeros(1,p);                                       %%%initialize the random deaccelration
        rdm_arr=randperm(p);                                                %%%randomize the car numbers
        rndm_deceleration(rdm_arr(1))=-rr*rand;                             %%%pick the first number in rdm_arr and assign the deceleration radomly between 0 to .6
        
        
        acc = -(alpha + rndm_deceleration).*vel_h + bta*(((dis_h-(vel_h*rt)))./(dis_h+1));           %%% acceleration update
        %acc = -(alpha).*vel_h + bta*((dis_h-(vel_h*rt))./(dis_h+1));           %%% acceleration update
        acc(dis_h==0) = -100;                                           %%% stop if too close to the car in front
        %vel_h = vel_h + acc;  %%% velocity updating step
        %cdi = vel_h;                                                        %%% just using the same velocity term
        
        
        %vel0 = vel_h;                                                       %%% velocity (of previous step) used for identifying when velocity crosses threshold
        %Vel = [Vel; vel_h(fp)];

        %acc(dis_h<0.0001) = 0;                                              %%% to make sure cars don't reverse when close to other cars
        %vel_h(dis_h<0.0001) = 0;                                            %%% to make sure cars stop when close to other cars
        
        
        
        
        
        %tou=min(dis_h./cdi);
        del = 2*acc.*dis_h + vel_h.^2;                                      %%% determinant: u0^2 + 2as, while calculating time, t = (-v0 + sqrt(u0^2 + 2as)0/a
        ind_d = find(del>=0 & acc~=0);
        ind_d1 = find(del<0 & acc~=0);
        ind_d2 = find(acc==0 & vel_h~=0 & dis_h~=0);
        tou1 = [(sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d), -vel_h(ind_d1)./acc(ind_d1), dis_h(ind_d2)./vel_h(ind_d2)];
        tou = min(tou1(tou1>0));
        %ind_d = intersect(find(dis_h~=0),find(del>0));
        %ind_d1 = intersect(find(acc<0), find(vel_h>0));
        %if length(ind_d)>0 & length(ind_d1)>0
        %    tou=min(min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d)), min((-vel_h(ind_d1)./acc(ind_d1))));%%% minimum time required for next update when acceleration is considered
        %checking wheather the update distance is safe to make. Similarly,
        %made sure that velocity remains positive
        %elseif length(ind_d)>0 & ~(length(ind_d1)>0)
        %    tou = min((sqrt(del(ind_d)) - vel_h(ind_d))./acc(ind_d));
        %elseif ~(length(ind_d)>0) & length(ind_d1)>0
        %    tou=min((-vel_h(ind_d1)./acc(ind_d1)));
        %end
            r=tou;
        r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is redtime
        red=red+r;
        dt = [dt,r];                                                        %%% collecting all time updates

        
        d = find(dis_h~=0);
        l(d) = l(d) + vel_h(d)*r + 0.5*acc(d)*r*r;                                      %%% distance update
        vel_h = vel_h + acc*r;                                              %%% velocity update
        cdi = vel_h;
        %l=l+r*cdi;
        
        for klj=1:p
        if (cdi(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
          if ((tmp(klj)==0))% & (acc(fp==klj)~=0))
              tmp(klj)=1;
              z_s_t(klj)=time+green+red + ((thresholdspeed-vel_h(fp==klj))/acc(fp==klj));%%% time at which the velocity drops below the threshold
          end
       end
        if (~(cdi(fp==klj)<thresholdspeed))
            if ((tmp(klj)==1))% & (acc(fp==klj)~=0))
                tmp(klj)=0;
                wt_zr_vl=[wt_zr_vl,time+green+red-z_s_t(klj) + ((thresholdspeed-vel_h(fp==klj))/acc(fp==klj))];%%% time at which the velocity rises above the threshold
            end
        end
        end
        
        vel_h(vel_h<0) = 0;                                                 %%% negative velocities are not possible
        
        Vel = [Vel, vel_h(fp==1)];
        X = [X;l];
        %l = mod(l,roadlength);                                              %%% to make sure periodic boundary condition
        %[l,ind]=sort(l,'ascend');
    end
    %[l,ind]=sort(l,'ascend');                                               %%%% this line is added to avoid non-positive values in the distances
    time=time+sigcyc;
    
    time
end


wt{kl,lk}=wt_zr_vl(1:end); %discarding the first 2000 waiting time values as transients   %%%% chenged from 10000 to 1
end

end%end of no of realization
figure,
for i=1:length(Vel),
hold on;
plot(X(i,:),sum(dt(1:i))*ones(1,p),'.');
end;

%for generating speed profile of the first car
figure,
plot(cumsum(dt),Vel,'g <');
%figure; loglog(sort(wt{1},'descend'),[1:length(wt{1})]/length(wt{1}),'b o');
