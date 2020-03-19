    for ilt=1:126
        t=T_month{1,ilt};
        v=V_month{1,ilt};
        v(v==0)=-2;
        v(v>0)=0;
        v(v<0)=1;
        v1=[0,diff(v)];
        v=v+v1;
        i1=t(find(v==-1));
        i2=t(find(v==2));
        I=[];
        if (size(i1,2)~=0)&&(size(i2,2)~=0)
        if (v(1,1)==1)&&(v(1,end)==1)%start with zero velocity and end with zero velocity
           
            I=i1(1,2:end)-i2(1,1:end-1);
        end
        if (v(1,1)==0)&&(v(1,end)==1)%start with non zero velocity and end with zero velocity
            I=i1(1,1:end)-i2(1,1:end-1);
        end
        if (v(1,1)==1)&&(v(1,end)==0)%start with zero velocity and end with non zero velocity
          
            I=i1(1,2:end)-i2(1,1:end);
        end
        if(v(1,1)==0)&&(v(1,end)==0)%start with non zero velocity and end with non zero velocity
            I=i1-i2;
        end
        if(v(1,1)==1)&&(v(1,end)==2)%start with zero velocity and end with zero velocity starting point
            
            I=i1(1,2:end)-i2(1,1:end-1);
        end
        if(v(1,1)==1)&&(v(1,end)==-1)%start with zero velocity and end with non zero velocity starting point
            
            I=i1(1,2:end)-i2;
        end
        if(v(1,1)==0)&&(v(1,end)==2)%start with non zero velocity and end with zero velocity starting point
            I=i1-i2(1,1:end-1);
        end
        if(v(1,1)==0)&&(v(1,end)==-1)%start with non zero velocity and end with non zero velocity starting point
            I=i1-i2;
        end
        end
        zero_velocity{1,ilt}=I;
    end