tic;
%calculate the taxi waited in congestion in much more precise way. precise
%way in the sense look at the data which has more frequncey gps point
%(say)points less than 2 min intervel
load bangalore_latlong_data
load ind_taxi_calc_bsd_difftime_neg

wt=cell(1,30);
for days=1:30
    for taxi=1:length(ind_taxi{1,days})
        if (taxi~=length(ind_taxi{1,days}))
        time_strip=Time{1,days}(ind_taxi{1,days}(taxi):ind_taxi{1,days}(taxi+1)-1);%get the time strip of the particular taxi on particular day
        speed=Vel{1,days}(ind_taxi{1,days}(taxi):ind_taxi{1,days}(taxi+1)-1);%get the velocity of a taxi on particular day
        lat=Latitude{1,days}(ind_taxi{1,days}(taxi):ind_taxi{1,days}(taxi+1)-1);%get the north to south co-ordinates
        lon=Longitude{1,days}(ind_taxi{1,days}(taxi):ind_taxi{1,days}(taxi+1)-1);%get the east to west co-ordinates
        else
        time_strip=Time{1,days}(ind_taxi{1,days}(taxi):end);
        speed=Vel{1,days}(ind_taxi{1,days}(taxi):end);
        lat=Latitude{1,days}(ind_taxi{1,days}(taxi):end);
        lon=Longitude{1,days}(ind_taxi{1,days}(taxi):end);
        end
        V=speed;
        T=time_strip;
        
        %X=zeros(1,length(T)-1);%displacement between two gps point
        if (length(lon)>1)
            y=diff(lat)*pi/180;%y-axis
            x=(diff(lon)*pi/180).*cos(((lat(2:end)+lat(1:end-1))*pi/180)/2);%y axis
            X=6371*sqrt((x.^2)+(y.^2));%calculated_distance between two nearby points
        %for l=1:length(T)-1
         %   y=(lat(l+1)-lat(l))*pi/180;%y axis
         %   x=((long(l+1)-long(l))*pi/180)*cos(((lat(l+1)+lat(l))*pi/180)/2);%x axis
         %   X(1,l)=6371*sqrt((x^2)+(y^2));%calculated_distance between two nearby points
        %end
            w=0;
            for l=1:length(X)
                t_d=T(l+1)-T(l);%%time difference
                if ((X(l)/(t_d/3600))<10)&&((X(l)/(t_d/3600))>1)&&(t_d<5*60)%if the speed is less than 10kmperhr and greater than 1kmperhr then it is  in congestion&&gps data pt is within 3min interval
                    w=w+t_d;
                else
                    wt{1,days}=[wt{1,days},w];
                    w=0;
                end
            end
        end
    end%taxi in a day ends here
end%number of days ends here
toc;