%continous space continous time true kinetic monte corlo simulation
function [flow,ql,mob]=kmc_cirrd(p)

l=randperm(100);
l=sort(l(1:p),'ascend');%initialize the space position in link 
time=0;
mob=0;
flow=0;
ql=[];
c=1;%max speed of vehicle
while (time<7200)

    green=0;
    while (green<30)
        dis_h=[(diff(l)-1),(101-l(end)+l(1,1)-2)];%distance head
        
        %cmean=c*dis_h./(1+dis_h);%mean speed of each vehicle (cMax=1 hyperbolic function)
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));%mean speed of each vehicle (cMax=1 sigmoidal function)
        %cdi=exprnd(cmean);%exponentially genereting speed of the vehicle
        cdi=cmean;%cdi=(-cmean.*log(1-rand(1,length(cmean))));%exprnd(cmean);%exponentially genereting speed of the vehicle
        tou=min(dis_h./cdi);
        %checking wheather the update distance is safe or make to safe
            g=min(tou,1);
        g=(~((green+g)<30))*(30-green)+((green+g)<30)*g;%adjust the green time to make the total green time equals to 30
        green=green+g;
        l=l+g*cdi;
        mob=mob+sum(g*cdi)/length(l);
        flow(end)=flow(end)+length(l(l>101));
        l(l>101)=l(l>101)-100;
        l=sort(l,'ascend');
            
        
    end
    flow(end)=flow(end)+length(l(l>100));
    l(l>100)=l(l>100)-100;
    l=sort(l,'ascend');
    flow=[flow,0];
    red=0;
    while (red<30)
        dis_h=[(diff(l)-1),(100-l(end))];%position of the signal is 100
        
        %cmean=c*dis_h./(1+dis_h);%mean speed of each vehicle (cMax=1 hyperbolic function)
        cmean=c*(dis_h.^2)./(1+(dis_h.^2));%mean speed of each vehicle (cMax=1 sigmoidal fuction)
        %cdi=exprnd(cmean);%exponentially genereting speed of the vehicle
        cdi=cmean;%cdi=(-cmean.*log(1-rand(1,length(cmean))));%exprnd(cmean);%exponentially genereting speed of the vehicle
        tou=min(dis_h./cdi);
        %checking wheather the update distance is safe or make to safe
            r=min(tou,1);
        r=(~((red+r)<30))*(30-red)+((red+r)<30)*r;%adjust kmc ts to make the total red time is 30
        red=red+r;
        l=l+r*cdi;
        mob=mob+sum(r*cdi)/length(l);
        
    end
    q=find(cdi<.001);
    
    if (~isempty(q))
    ql=[ql,q(1,1)];
    else
        ql=[ql,0];
    end
    flow=[flow,0];
    time=time+60;
end

end