%/usr/local/matlab2010b
function w = wt_time_v3(month,days);

%month = '01';%considering only January month of 2013
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];%Week days for JAN, 2013
D = str2num(days);
%D = length(weekdays);
%D = days;

cty_tx_ind=cell(1,3);%storing the current day ind of  cities of bombay bangalore and delhi
wt1=cell(3,D);%waiting times while considering dist/time
wait1 = cell(3,D,40000);%assuming taxi ids are about 39340
wt2=cell(3,D);%waiting times while considering dist/time
wait2 = cell(3,D,40000);%assuming taxi ids are about 39340
wt3=cell(3,D);%waiting times while considering dist/time
wait3 = cell(3,D,40000);%assuming taxi ids are about 39340
wt4=cell(3,D);%waiting times while considering dist/time
wait4 = cell(3,D,40000);%assuming taxi ids are about 39340
wt1a=cell(3,D);%waiting times while considering dist/time
wait1a = cell(3,D,40000);%assuming taxi ids are about 39340
wt2a=cell(3,D);%waiting times while considering dist/time
wait2a = cell(3,D,40000);%assuming taxi ids are about 39340
wt3a=cell(3,D);%waiting times while considering dist/time
wait3a = cell(3,D,40000);%assuming taxi ids are about 39340
wt4a=cell(3,D);%waiting times while considering dist/time
wait4a = cell(3,D,40000);%assuming taxi ids are about 39340

% taxis = cell(3,D,288);%counting no. of taxis for every 5 mins interval
% vel = cell(3,D,288);%collecting speeds of taxis for every 5 mins interval
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
            
%             time_stamp = m2(:,1);
%             speed_col = m2(:,2);
%             
%             for ts=1:length(time_stamp)
%                 ts_ind = floor(mod(time_stamp(ts),86400)/300)+1;
%                 taxis{i,l,ts_ind} = [taxis{i,l,ts_ind},m1(ts,1)];
%                 vel{i,l,ts_ind} = [vel{i,l,ts_ind},speed_col(ts_ind)];
%             end
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
                        [time,ind1]=sort(m(:,1),'ascend');
                        distance_tr=m(ind1,3); % changed to 3 for distance travelled column
                        speed = m(ind1,2); % speed of the car at each instant
                        time=diff(time);%time between the each gps point
                        distance_tr=distance_tr(2:end);%distance traveled between each time seqment
                        speed = speed(2:end); % included for consistency in DEC 2017
                        ind1=find(time==0);%throw out the zero time difference
                        time(ind1)=[];
                        distance_tr(ind1)=[];
                        speed(ind1) = [];

                        avg_kph=3600*(distance_tr./time);%finding the avg kph between two gps point where taxi travelled

                        v1=find(avg_kph<5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t1=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c1=intersect(v1,t1);%common indices between the v1 and t1

                        if (~isempty(c1))
                            w1=time(c1(1));

                            for k=1:length(c1)-1
                                if (c1(k+1)==c1(k)+1)
                                    w1=w1+time(c1(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt1{i,l}=[wt1{i,l},w1];%storing waiting time for 30 days for three city
                                    wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w1=0;
                                end
                            end
                        end
                        
                        
                        
                        v2=find(avg_kph<10);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t2=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c2=intersect(v2,t2);%common indices between the v1 and t1

                        if (~isempty(c2))
                            w2=time(c2(1));

                            for k=1:length(c2)-1
                                if (c2(k+1)==c2(k)+1)
                                    w2=w2+time(c2(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt2{i,l}=[wt2{i,l},w2];%storing waiting time for 30 days for three city
                                    wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w2=0;
                                end
                            end
                        end
                        
                        
                        v3=find(avg_kph<15);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t3=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c3=intersect(v3,t3);%common indices between the v1 and t1

                        if (~isempty(c3))
                            w3=time(c3(1));

                            for k=1:length(c3)-1
                                if (c3(k+1)==c3(k)+1)
                                    w3=w3+time(c3(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt3{i,l}=[wt3{i,l},w3];%storing waiting time for 30 days for three city
                                    wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w3=0;
                                end
                            end
                        end
                        
                        
                        v4=find(avg_kph<20);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t4=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c4=intersect(v4,t4);%common indices between the v1 and t1

                        if (~isempty(c4))
                            w4=time(c4(1));

                            for k=1:length(c4)-1
                                if (c4(k+1)==c4(k)+1)
                                    w4=w4+time(c4(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt4{i,l}=[wt4{i,l},w4];%storing waiting time for 30 days for three city
                                    wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w4=0;
                                end
                            end
                        end
                        
                        
                        
                        v1a=find(speed<5);%intersect(find(speed<5),find(speed>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t1a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c1a=intersect(v1a,t1a);%common indices between the v1 and t1

                        if (~isempty(c1a))
                            w1a=0;

                            for k=1:length(c1a)-1
                                if (c1a(k+1)==c1a(k)+1)
                                    w1a=w1a+time(c1a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                elseif(w1a>0)
                                    wt1a{i,l}=[wt1a{i,l},w1a];%storing waiting time for 30 days for three city
                                    wait1a{i,l,taxi_no(j)+1} = [wait1a{i,l,taxi_no(j)+1},w1a];
                                    w1a=0;
                                end
                            end
                        end
                        
                        v2a=find(speed<10);%intersect(find(speed<5),find(speed>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t2a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c2a=intersect(v2a,t2a);%common indices between the v1 and t1

                        if (~isempty(c2a))
                            w2a=0;

                            for k=1:length(c2a)-1
                                if (c2a(k+1)==c2a(k)+1)
                                    w2a=w2a+time(c2a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                elseif(w2a>0)
                                    wt2a{i,l}=[wt2a{i,l},w2a];%storing waiting time for 30 days for three city
                                    wait2a{i,l,taxi_no(j)+1} = [wait2a{i,l,taxi_no(j)+1},w2a];
                                    w2a=0;
                                end
                            end
                        end
                        
                        
                        
                        v3a=find(speed<15);%intersect(find(speed<5),find(speed>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t3a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c3a=intersect(v3a,t3a);%common indices between the v1 and t1

                        if (~isempty(c3a))
                            w3a=0;

                            for k=1:length(c3a)-1
                                if (c3a(k+1)==c3a(k)+1)
                                    w3a=w3a+time(c3a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                elseif(w3a>0)
                                    wt3a{i,l}=[wt3a{i,l},w3a];%storing waiting time for 30 days for three city
                                    wait3a{i,l,taxi_no(j)+1} = [wait3a{i,l,taxi_no(j)+1},w3a];
                                    w3a=0;
                                end
                            end
                        end
                        
                        
                        
                        
                        v4a=find(speed<20);%intersect(find(speed<5),find(speed>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t4a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c4a=intersect(v4a,t4a);%common indices between the v1 and t1

                        if (~isempty(c4a))
                            w4a=0;

                            for k=1:length(c4a)-1
                                if (c4a(k+1)==c4a(k)+1)
                                    w4a=w4a+time(c4a(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                elseif(w4a>0)
                                    wt4a{i,l}=[wt4a{i,l},w4a];%storing waiting time for 30 days for three city
                                    wait4a{i,l,taxi_no(j)+1} = [wait4a{i,l,taxi_no(j)+1},w4a];
                                    w4a=0;
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
save(['Waiting_time_taxis_speed_avg_5_10_15_20_vel_bombay_bang_delhi',month,'.mat'],'wt1','wait1','wt2','wait2','wt3','wait3','wt4','wait4','wt1a','wait1a','wt2a','wait2a','wt3a','wait3a','wt4a','wait4a');


