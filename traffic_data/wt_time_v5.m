%/usr/local/matlab2010b
function w = wt_time_v5(month,days);

%month = '01';%considering only January month of 2013
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];%Week days for JAN, 2013
%D = str2num(days);
%D = length(weekdays);
D = days;

cty_tx_ind=cell(1,3);%storing the current day ind of  cities of bombay bangalore and delhi
wt1a=cell(3,D);%waiting times while considering dist/time
wait1a = cell(3,D,40000);%assuming taxi ids are about 39340
wt2a=cell(3,D);%waiting times while considering dist/time
wait2a = cell(3,D,40000);%assuming taxi ids are about 39340
wt3a=cell(3,D);%waiting times while considering dist/time
wait3a = cell(3,D,40000);%assuming taxi ids are about 39340
wt4a=cell(3,D);%waiting times while considering dist/time
wait4a = cell(3,D,40000);%assuming taxi ids are about 39340
wt5a=cell(3,D);%waiting times while considering dist/time
wait5a = cell(3,D,40000);%assuming taxi ids are about 39340
wt6a=cell(3,D);%waiting times while considering dist/time
wait6a = cell(3,D,40000);%assuming taxi ids are about 39340
wt7a=cell(3,D);%waiting times while considering dist/time
wait7a = cell(3,D,40000);%assuming taxi ids are about 39340
wt8a=cell(3,D);%waiting times while considering dist/time
wait8a = cell(3,D,40000);%assuming taxi ids are about 39340
wt9a=cell(3,D);%waiting times while considering dist/time
wait9a = cell(3,D,40000);%assuming taxi ids are about 39340

wt1b=cell(3,D);%waiting times while considering dist/time
wait1b = cell(3,D,40000);%assuming taxi ids are about 39340
wt2b=cell(3,D);%waiting times while considering dist/time
wait2b = cell(3,D,40000);%assuming taxi ids are about 39340
wt3b=cell(3,D);%waiting times while considering dist/time
wait3b = cell(3,D,40000);%assuming taxi ids are about 39340
wt4b=cell(3,D);%waiting times while considering dist/time
wait4b = cell(3,D,40000);%assuming taxi ids are about 39340
wt5b=cell(3,D);%waiting times while considering dist/time
wait5b = cell(3,D,40000);%assuming taxi ids are about 39340
wt6b=cell(3,D);%waiting times while considering dist/time
wait6b = cell(3,D,40000);%assuming taxi ids are about 39340
wt7b=cell(3,D);%waiting times while considering dist/time
wait7b = cell(3,D,40000);%assuming taxi ids are about 39340
wt8b=cell(3,D);%waiting times while considering dist/time
wait8b = cell(3,D,40000);%assuming taxi ids are about 39340
wt9b=cell(3,D);%waiting times while considering dist/time
wait9b = cell(3,D,40000);%assuming taxi ids are about 39340

% taxis = cell(3,D,288);%counting no. of taxis for every 5 mins interval
vel = cell(3,D,288);%collecting speeds of taxis for every 5 mins interval
avg = cell(3,D);%collecting speeds of taxis for every 5 mins interval
% mean_vel = zeros(3,D,288);%collecting mean speed values for every 5 mins interval
% median_vel = zeros(3,D,288);%collecting median speed values for every 5 mins interval

%t_seg=cell(3,30);
for l1=1:D
%     l1 = weekdays(l)
        l = l1
        if (l1<10)
            file=(['AlignedData_2013',month,'0' num2str(l1),'.dat']);%for loading the eventdata dat file
        else
            file=(['AlignedData_2013',month, num2str(l1),'.dat']);%for loading the eventdata dat file 
        end
    
        M=load(file);
    
        lat_ind2=find(M(:,3)<20);
        lat_ind1=find(M(:,3)>18);
        long_ind2=find(M(:,4)<73);
        long_ind1=find(M(:,4)>72);
        cty_tx_ind{1,1}=intersect(intersect(long_ind1,long_ind2),intersect(lat_ind1,lat_ind2));%bombay

        lat_ind1=find(M(:,3)>12);
        lat_ind2=find(M(:,3)<14);
        long_ind1=find(M(:,4)>77);
        long_ind2=find(M(:,4)<78);
        cty_tx_ind{1,2}=intersect(intersect(long_ind1,long_ind2),intersect(lat_ind1,lat_ind2));%bang

        lat_ind1=find(M(:,3)>28);
        lat_ind2=find(M(:,3)<29);
        long_ind1=find(M(:,4)>76);
        long_ind2=find(M(:,4)<78);
        cty_tx_ind{1,3}=intersect(intersect(long_ind1,long_ind2),intersect(lat_ind1,lat_ind2));%delhi
        m1=M(:,1);%tx_number
        m2=M(:,([2,5,6]));
        clear M;

        for i=1:3 
    
            taxi_no=unique(m1(cty_tx_ind{1,i}));%taxi id number
            no_tx=length(taxi_no);%total number of taxi present in the city for a day
            
            time_stamp = m2(:,1);
            speed_col = m2(:,2);
%             
             for ts=1:length(time_stamp)
                ts_ind = floor(mod(time_stamp(ts),86400)/300)+1;
%                 taxis{i,l,ts_ind} = [taxis{i,l,ts_ind},m1(ts,1)];
                vel{i,l,ts_ind} = [vel{i,l,ts_ind},speed_col(ts_ind)];
             end
%             
%             for ve=1:288
%                 mean_vel(i,l,ve) = mean(vel{i,l,ve});
%                 median_vel(i,l,ve) = median(vel{i,l,ve});
%             end
%             
            if(no_tx>0)   %check whether there is atleast one taxi present
%                wait{i,l} = cell(1,no_tx);
    
                for j=1:no_tx
    
                    ind=find(m1(:,1)==taxi_no(j));
                    if(length(ind)>60)

                        m=m2(ind,:);%extracting the particular taxi data alone
                        [time_st,ind1]=sort(m(:,1),'ascend');
                        distance_tr=m(ind1,3); % changed to 3 for distance travelled column
                        speed = m(ind1,2); % speed of the car at each instant
                        time=diff(time_st);%time between the each gps point
                        distance_tr=distance_tr(2:end);%distance traveled between each time seqment
                        speed = speed(2:end); % included for consistency in DEC 2017
                        ind1=find(time==0);%throw out the zero time difference
                        time(ind1)=[];
                        distance_tr(ind1)=[];
                        speed(ind1) = [];
                        time_st(ind1+1) = []; % included in DEC 2017

                        avg_kph=3600*(distance_tr./time);%finding the avg kph between two gps point where taxi travelled
                        avg{i,l1} = [avg{i,l1},avg_kph']; % added just to get a collection of average velocities (only in this if loop)

                      
                        v1a=find(avg_kph<0.25);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t1a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt1a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c1a=intersect(v1a,intersect(t1a,tt1a));%common indices between the v1 and t1

                        if (~isempty(c1a))
                            w1a=time(c1a(1));

                            for k=1:length(c1a)-1
                                if (c1a(k+1)==c1a(k)+1)
                                    w1a=w1a+time(c1a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt1a{i,l}=[wt1a{i,l},w1a];%storing waiting time for 30 days for three city
                                    wait1a{i,l,taxi_no(j)+1} = [wait1a{i,l,taxi_no(j)+1},w1a];
                                    w1a=0;
                                end
                            end
                        end
                        
                        
                        v1b=find(avg_kph<0.25);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t1b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt1b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c1b=intersect(v1b,intersect(t1b,tt1b));%common indices between the v1 and t1

                        if (~isempty(c1b))
                            w1b=time(c1b(1));

                            for k=1:length(c1b)-1
                                if (c1b(k+1)==c1b(k)+1)
                                    w1b=w1b+time(c1b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt1b{i,l}=[wt1b{i,l},w1b];%storing waiting time for 30 days for three city
                                    wait1b{i,l,taxi_no(j)+1} = [wait1b{i,l,taxi_no(j)+1},w1b];
                                    w1b=0;
                                end
                            end
                        end
                        

                        

                        v2a=find(avg_kph<0.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t2a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt2a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c2a=intersect(v2a,intersect(t2a,tt2a));%common indices between the v1 and t1

                        if (~isempty(c2a))
                            w2a=time(c2a(1));

                            for k=1:length(c2a)-1
                                if (c2a(k+1)==c2a(k)+1)
                                    w2a=w2a+time(c2a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt2a{i,l}=[wt2a{i,l},w2a];%storing waiting time for 30 days for three city
                                    wait2a{i,l,taxi_no(j)+1} = [wait2a{i,l,taxi_no(j)+1},w2a];
                                    w2a=0;
                                end
                            end
                        end
                        
                        
                        v2b=find(avg_kph<0.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t2b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt2b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c2b=intersect(v2b,intersect(t2b,tt2b));%common indices between the v1 and t1

                        if (~isempty(c2b))
                            w2b=time(c2b(1));

                            for k=1:length(c2b)-1
                                if (c2b(k+1)==c2b(k)+1)
                                    w2b=w2b+time(c2b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt2b{i,l}=[wt2b{i,l},w2b];%storing waiting time for 30 days for three city
                                    wait2b{i,l,taxi_no(j)+1} = [wait2b{i,l,taxi_no(j)+1},w2b];
                                    w2b=0;
                                end
                            end
                        end
                        

                        
                        v3a=find(avg_kph<0.75);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t3a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt3a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c3a=intersect(v3a,intersect(t3a,tt3a));%common indices between the v1 and t1

                        if (~isempty(c3a))
                            w3a=time(c3a(1));

                            for k=1:length(c3a)-1
                                if (c3a(k+1)==c3a(k)+1)
                                    w3a=w3a+time(c3a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt3a{i,l}=[wt3a{i,l},w3a];%storing waiting time for 30 days for three city
                                    wait3a{i,l,taxi_no(j)+1} = [wait3a{i,l,taxi_no(j)+1},w3a];
                                    w3a=0;
                                end
                            end
                        end
                        
                        
                        v3b=find(avg_kph<0.75);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t3b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt3b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c3b=intersect(v3b,intersect(t3b,tt3b));%common indices between the v1 and t1

                        if (~isempty(c3b))
                            w3b=time(c3b(1));

                            for k=1:length(c3b)-1
                                if (c3b(k+1)==c3b(k)+1)
                                    w3b=w3b+time(c3b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt3b{i,l}=[wt3b{i,l},w3b];%storing waiting time for 30 days for three city
                                    wait3b{i,l,taxi_no(j)+1} = [wait3b{i,l,taxi_no(j)+1},w3b];
                                    w3b=0;
                                end
                            end
                        end
                        

                        
                        v4a=find(avg_kph<1.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t4a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt4a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c4a=intersect(v4a,intersect(t4a,tt4a));%common indices between the v1 and t1

                        if (~isempty(c4a))
                            w4a=time(c4a(1));

                            for k=1:length(c4a)-1
                                if (c4a(k+1)==c4a(k)+1)
                                    w4a=w4a+time(c4a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt4a{i,l}=[wt4a{i,l},w4a];%storing waiting time for 30 days for three city
                                    wait4a{i,l,taxi_no(j)+1} = [wait4a{i,l,taxi_no(j)+1},w4a];
                                    w4a=0;
                                end
                            end
                        end
                        
                        
                        v4b=find(avg_kph<1.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t4b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt4b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c4b=intersect(v4b,intersect(t4b,tt4b));%common indices between the v1 and t1

                        if (~isempty(c4b))
                            w4b=time(c4b(1));

                            for k=1:length(c4b)-1
                                if (c4b(k+1)==c4b(k)+1)
                                    w4b=w4b+time(c4b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt4b{i,l}=[wt4b{i,l},w4b];%storing waiting time for 30 days for three city
                                    wait4b{i,l,taxi_no(j)+1} = [wait4b{i,l,taxi_no(j)+1},w4b];
                                    w4b=0;
                                end
                            end
                        end
                        

                        
                        v5a=find(avg_kph<1.25);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t5a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt5a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c5a=intersect(v5a,intersect(t5a,tt5a));%common indices between the v1 and t1

                        if (~isempty(c5a))
                            w5a=time(c5a(1));

                            for k=1:length(c5a)-1
                                if (c5a(k+1)==c5a(k)+1)
                                    w5a=w5a+time(c5a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt5a{i,l}=[wt5a{i,l},w5a];%storing waiting time for 30 days for three city
                                    wait5a{i,l,taxi_no(j)+1} = [wait5a{i,l,taxi_no(j)+1},w5a];
                                    w5a=0;
                                end
                            end
                        end
                        
                        
                        v5b=find(avg_kph<1.25);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t5b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt5b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c5b=intersect(v5b,intersect(t5b,tt5b));%common indices between the v1 and t1

                        if (~isempty(c5b))
                            w5b=time(c5b(1));

                            for k=1:length(c5b)-1
                                if (c5b(k+1)==c5b(k)+1)
                                    w5b=w5b+time(c5b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt5b{i,l}=[wt5b{i,l},w5b];%storing waiting time for 30 days for three city
                                    wait5b{i,l,taxi_no(j)+1} = [wait5b{i,l,taxi_no(j)+1},w5b];
                                    w5b=0;
                                end
                            end
                        end
                        

                        
                        v6a=find(avg_kph<1.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t6a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt6a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c6a=intersect(v6a,intersect(t6a,tt6a));%common indices between the v1 and t1

                        if (~isempty(c6a))
                            w6a=time(c6a(1));

                            for k=1:length(c6a)-1
                                if (c6a(k+1)==c6a(k)+1)
                                    w6a=w6a+time(c6a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt6a{i,l}=[wt6a{i,l},w6a];%storing waiting time for 30 days for three city
                                    wait6a{i,l,taxi_no(j)+1} = [wait6a{i,l,taxi_no(j)+1},w6a];
                                    w6a=0;
                                end
                            end
                        end
                        
                        
                        v6b=find(avg_kph<1.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t6b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt6b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c6b=intersect(v6b,intersect(t6b,tt6b));%common indices between the v1 and t1

                        if (~isempty(c6b))
                            w6b=time(c6b(1));

                            for k=1:length(c6b)-1
                                if (c6b(k+1)==c6b(k)+1)
                                    w6b=w6b+time(c6b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt6b{i,l}=[wt6b{i,l},w6b];%storing waiting time for 30 days for three city
                                    wait6b{i,l,taxi_no(j)+1} = [wait6b{i,l,taxi_no(j)+1},w6b];
                                    w6b=0;
                                end
                            end
                        end
                        

                        
                        v7a=find(avg_kph<1.75);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t7a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt7a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c7a=intersect(v7a,intersect(t7a,tt7a));%common indices between the v1 and t1

                        if (~isempty(c7a))
                            w7a=time(c7a(1));

                            for k=1:length(c7a)-1
                                if (c7a(k+1)==c7a(k)+1)
                                    w7a=w7a+time(c7a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt7a{i,l}=[wt7a{i,l},w7a];%storing waiting time for 30 days for three city
                                    wait7a{i,l,taxi_no(j)+1} = [wait7a{i,l,taxi_no(j)+1},w7a];
                                    w7a=0;
                                end
                            end
                        end
                        
                        
                        v7b=find(avg_kph<1.75);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t7b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt7b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c7b=intersect(v7b,intersect(t7b,tt7b));%common indices between the v1 and t1

                        if (~isempty(c7b))
                            w7b=time(c7b(1));

                            for k=1:length(c7b)-1
                                if (c7b(k+1)==c7b(k)+1)
                                    w7b=w7b+time(c7b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt7b{i,l}=[wt7b{i,l},w7b];%storing waiting time for 30 days for three city
                                    wait7b{i,l,taxi_no(j)+1} = [wait7b{i,l,taxi_no(j)+1},w7b];
                                    w7b=0;
                                end
                            end
                        end
                        

                        
                        v8a=find(avg_kph<2.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t8a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt8a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c8a=intersect(v8a,intersect(t8a,tt8a));%common indices between the v1 and t1

                        if (~isempty(c8a))
                            w8a=time(c8a(1));

                            for k=1:length(c8a)-1
                                if (c8a(k+1)==c8a(k)+1)
                                    w8a=w8a+time(c8a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt8a{i,l}=[wt8a{i,l},w8a];%storing waiting time for 30 days for three city
                                    wait8a{i,l,taxi_no(j)+1} = [wait8a{i,l,taxi_no(j)+1},w8a];
                                    w8a=0;
                                end
                            end
                        end
                        
                        
                        v8b=find(avg_kph<2.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t8b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt8b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c8b=intersect(v8b,intersect(t8b,tt8b));%common indices between the v1 and t1

                        if (~isempty(c8b))
                            w8b=time(c8b(1));

                            for k=1:length(c8b)-1
                                if (c8b(k+1)==c8b(k)+1)
                                    w8b=w8b+time(c8b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt8b{i,l}=[wt8b{i,l},w8b];%storing waiting time for 30 days for three city
                                    wait8b{i,l,taxi_no(j)+1} = [wait8b{i,l,taxi_no(j)+1},w8b];
                                    w8b=0;
                                end
                            end
                        end
                        

                        
                        v9a=find(avg_kph<2.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t9a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt9a = find((mod(time_st,86400)>9000) & (mod(time_st,86400)<59400))-1; % times stamp between 8am to 10pm
                        c9a=intersect(v9a,intersect(t9a,tt9a));%common indices between the v1 and t1

                        if (~isempty(c9a))
                            w9a=time(c9a(1));

                            for k=1:length(c9a)-1
                                if (c9a(k+1)==c9a(k)+1)
                                    w9a=w9a+time(c9a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt9a{i,l}=[wt9a{i,l},w9a];%storing waiting time for 30 days for three city
                                    wait9a{i,l,taxi_no(j)+1} = [wait9a{i,l,taxi_no(j)+1},w9a];
                                    w9a=0;
                                end
                            end
                        end
                        
                        
                        v9b=find(avg_kph<2.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t9b=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        tt9b = find((mod(time_st,86400)<=9000) | (mod(time_st,86400)>=59400))-1; % times stamp between 8am to 10pm
                        c9b=intersect(v9b,intersect(t9b,tt9b));%common indices between the v1 and t1

                        if (~isempty(c9b))
                            w9b=time(c9b(1));

                            for k=1:length(c9b)-1
                                if (c9b(k+1)==c9b(k)+1)
                                    w9b=w9b+time(c9b(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt9b{i,l}=[wt9b{i,l},w9b];%storing waiting time for 30 days for three city
                                    wait9b{i,l,taxi_no(j)+1} = [wait9b{i,l,taxi_no(j)+1},w9b];
                                    w9b=0;
                                end
                            end
                        end
                        

                        
                        
                        
                        
                        
                    end%end of if loop cmp that array has enough length of data
                end%running the particular day particular city of different taxi

            end
    
        end%%run for three different city
        clear m1 m m2 file   
 end%end for 30 days
 w=D;
save(['Waiting_time_taxis_half_avg_below_2_5_bombay_bang_delhi',month,'.mat']);
