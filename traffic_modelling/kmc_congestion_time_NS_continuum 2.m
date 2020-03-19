roadlength=200; %total length of the road
tsimul=10000; %Total time of simulation
sigcyc=120; %time signal is red + time signal is green
dutyratio=1; %ratio of green signal time to red signal time

thresholdspeed=0.001; %speed below which a car is considered to be in a congestion
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





time=0;

wt_zr_vl=[];%to store time of selected car whose velocity stays less than thresholdspeed;
tmp=zeros(1,p);
z_s_t=zeros(1,p);%intialize the starting time of car 1 whose velocity stays under thresholdspeed

greentime=dutyratio*sigcyc; %total time light is green during a signal cycle
redtime=sigcyc-greentime;

while (time<tsimul)

    green=0;
    while (green<greentime)
        dis_h=[(diff(l)-1),(roadlength+1-l(end)+l(1,1)-2)];%distance head
        
        %cmean=c*dis_h./(.5+dis_h);%mean speed of each vehicle (cMax=1 hyperbolic function)
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));%mean speed of each vehicle (cMax=1 sigmoidal function)

        %Deterministic velocity
        %cdi=cmean;
        %
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));%exprnd(cmean);%exponentially genereting speed of the vehicle
        %
        %gamma distributed velocities
        %cdi=gamrnd(gammaK,cmean/gammaK,1,P);                               %%%%commented due to license errors
        xx = rand([1,P]);                                                %%%%(uniformly distributed) random number for the artificial gamma distribution
        cdi = (1./(((cmean/gammaK).^gammaK)*gamma(gammaK)))*(xx(1)^gammaK).*(exp(1).^(-xx(1)./(cmean/gammaK)));    %%%artificial gamma distribution
        
        tou=min(dis_h./cdi);
        %checking wheather the update distance is safe or make to safe
            g=tou;
        g=(~((green+g)<greentime))*(greentime-green)+((green+g)<greentime)*g;%adjust the green time to make the total green time equals to greentime
        green=green+g;
        l=l+g*cdi;
        
        for klj=1:p
       if (cdi(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
          if (tmp(klj)==0) 
              tmp(klj)=1;
              z_s_t(klj)=time+green-g;
          end
       end
        if (~(cdi(fp==klj)<thresholdspeed))
            if (tmp(klj)==1)
                tmp(klj)=0;
                wt_zr_vl=[wt_zr_vl,time+green-z_s_t(klj)];
            end
        end
        end
        
        l(l>roadlength+1)=l(l>roadlength+1)-roadlength;
        [l,ind]=sort(l,'ascend');
        
        
        fp=fp(ind);
        
    tmp=tmp(ind);
    z_s_t=z_s_t(ind);
           
    end
    l(l>roadlength)=l(l>roadlength)-roadlength;
    [l,ind]=sort(l,'ascend');
    
    
    fp=fp(ind);
    tmp=tmp(ind);
    z_s_t=z_s_t(ind);
    
    
    red=0;
    while (red<-1)
        dis_h=[(diff(l)-1),(roadlength-l(end))];%position of the signal is equal to roadlength
        
        %cmean=1*dis_h./(.5+dis_h);%mean speed of each vehicle (cMax=1 hyperbolic function)
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));%mean speed of each vehicle (cMax=1 sigmoidal fuction)

        %Deterministic
        %cdi=cmean;
        %
        %cdi=(-cmean.*log(1-rand(1,length(cmean))));%exprnd(cmean);%exponentially genereting speed of the vehicle
        %
        %Gamma distributed velocities
        %cdi=gamrnd(gammaK,cmean/gammaK,1,P);                               %%%%commented due to license errors
        xx = rand([1,P]);                                                %%%%(uniformly distributed) random number for the artificial gamma distribution
        cdi = (1./(((cmean/gammaK).^gammaK)*gamma(gammaK)))*(xx(1)^gammaK).*(exp(1).^(-xx(1)./(cmean/gammaK)));    %%%artificial gamma distribution
        
        tou=min(dis_h./cdi);
        %checking wheather the update distance is safe or make to safe
            r=tou;
        r=(~((red+r)<redtime))*(redtime-red)+((red+r)<redtime)*r;%adjust kmc ts to make the total red time is redtime
        red=red+r;
        l=l+r*cdi;
        
        for klj=1:p
        if (cdi(fp==klj)<thresholdspeed)%&&(l(fp==1)>65)
          if (tmp(klj)==0) 
              tmp(klj)=1;
              z_s_t(klj)=time+green+red-r;
          end
       end
        if (~(cdi(fp==klj)<thresholdspeed))
            if (tmp(klj)==1)
                tmp(klj)=0;
                wt_zr_vl=[wt_zr_vl,time+green+red-z_s_t(klj)];
            end
        end
        end
        
        
    end
    time=time+sigcyc;
end


wt{kl,lk}=wt_zr_vl(10000:end); %discarding the first 2000 waiting time values as transients
end

end%end of no of realization

figure, loglog(sort(wt{1},'descend'),[1:length(wt{1})]/length(wt{1}),'b o')
