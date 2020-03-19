h = zeros(1,100);
p=1;
g=0.3;

for r=1:10000
    htemp = zeros(1,100);
    L = 200*rand(1,200);
    l=sort(L(1:100),'ascend');
    dis_h=[(diff(l)-1),(199-l(end)+l(1))];
    flag=0;
    for i=1:100
        if((dis_h(1,i)<p)&&(flag==0))
            flag = 1;
            clock=i;
        elseif((dis_h(1,i)>=p)&&(flag==1))
            flag = 0;
            htemp(1,i-clock) = htemp(1,i-clock) + 1;
        end
    end

    if(flag==1)
        for i=1:100
            if(dis_h(1,i)>=p)
                flag=0;
                htemp(1,i+100-clock) = htemp(1,i+100-clock) + 1;
            end
        end
    end
    
    for i=2:100
        htemp(1,i) = htemp(1,i) + htemp(1,i-1)*g;
    end
    
    h = h + htemp;
     
end