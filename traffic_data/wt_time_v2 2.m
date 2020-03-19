%/usr/local/matlab2010b
function w = wt_time(month,days);

%month = '01';%considering only January month of 2013
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];%Week days for JAN, 2013
D = str2num(days);
%D = length(weekdays);
%D = days;

cty_tx_ind=cell(1,3);%storing the current day ind of  cities of bombay bangalore and delhi
wt=cell(3,D);%waiting times while considering dist/time
wait = cell(3,D,40000);%assuming taxi ids are about 39340
wta=cell(3,D);%waiting times while considering dist/time
waita = cell(3,D,40000);%assuming taxi ids are about 39340
wt2=cell(3,D);%waiting times while considering the velocities itself
wait2 = cell(3,D,40000);%assuming taxi ids are about 39340
wt2a=cell(3,D);%waiting times while considering the velocities itself
wait2a = cell(3,D,40000);%assuming taxi ids are about 39340

taxis = cell(3,D,288);%counting no. of taxis for every 5 mins interval
vel = cell(3,D,288);%collecting speeds of taxis for every 5 mins interval
vel1 = cell(3,D,288);%collecting speeds of taxis for every 5 mins interval (avoiding idle taxis)
mean_vel = zeros(3,D,288);%collecting mean speed values for every 5 mins interval
median_vel = zeros(3,D,288);%collecting median speed values for every 5 mins interval

%t_seg=cell(3,30);
for l1=1:D
%     l1 = weekdays(l)
        l = l1;
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

        for i=2:2 
    
            taxi_no=unique(m1(cty_tx_ind{1,i}));%taxi id number
            no_tx=length(taxi_no);%total number of taxi present in the city for a day
            
            time_stamp = m2(:,1);
            speed_col = m2(:,2);
            
            for ts=1:length(time_stamp)
                %ts_ind = floor(mod(time_stamp(ts),86400)/300)+1;
                %taxis{i,l,ts_ind} = [taxis{i,l,ts_ind},m1(ts,1)];
                %vel{i,l,ts_ind} = [vel{i,l,ts_ind},speed_col(ts_ind)];
            end
            
            for ve=1:288
                %mean_vel(i,l,ve) = mean(vel{i,l,ve});
                %median_vel(i,l,ve) = median(vel{i,l,ve});
            end
            
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
                        ind1=find(time==0);%throw out the zero time difference
                        time(ind1)=[];
                        distance_tr(ind1)=[];
                        speed(ind1) = [];
                        time_st(ind1) = []; % included in DEC 2017

%                         avg_kph=3600*(distance_tr./time);%finding the avg kph between two gps point where taxi travelled
% 
%                         v1=find(avg_kph<15);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
%                         %v1=find((avg_kph<5));
%                         t1=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
%                         c=intersect(v1,t1);%common indices between the v1 and t1
% 
%                         if (~isempty(c))
%                             w=time(c(1));
% 
%                             for k=1:length(c)-1
%                                 if (c(k+1)==c(k)+1)
%                                     w=w+time(c(k+1));
%                                     %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
%                                 else
%                                     wt{i,l}=[wt{i,l},w];%storing waiting time for 30 days for three city
%                                     wait{i,l,taxi_no(j)+1} = [wait{i,l,taxi_no(j)+1},w];
%                                     w=0;
%                                 end
%                             end
%                         end
%                         
%                         
%                         v1a=find(avg_kph<20);%intersect(find(avg_kph<10),find(avg_kph>0));%indices of where the avg velocity is less than 10kphr
%                         %v1=find((avg_kph<5));
%                         t1a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
%                         ca=intersect(v1a,t1a);%common indices between the v1 and t1
% 
%                         if (~isempty(ca))
%                             w=time(ca(1));
% 
%                             for k=1:length(ca)-1
%                                 if (ca(k+1)==ca(k)+1)
%                                     w=w+time(ca(k+1));
%                                     %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
%                                 else
%                                     wta{i,l}=[wta{i,l},w];%storing waiting time for 30 days for three city
%                                     waita{i,l,taxi_no(j)+1} = [waita{i,l,taxi_no(j)+1},w];
%                                     w=0;
%                                 end
%                             end
%                         end
                        
                        
                        v2=find(speed<5);%intersect(find(speed<5),find(speed>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t2=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c2=intersect(v2,t2);%common indices between the v1 and t1

                        if (~isempty(c2))
%                            w2=0;

                            for k=1:length(c2)-1
                                
                                                               
                                
                                ts_ind = floor(mod(time_st(k),86400)/300)+1;% included in DEC 2017
                                vel1{i,l,ts_ind} = [vel{i,l,ts_ind},speed_col(ts_ind)];% included in DEC 2017
%                                                                 
%                                 
%                                 if (c2(k+1)==c2(k)+1)
%                                     w2=w2+time(c2(k+1));
%                                     %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
%                                 elseif(w2>0)
%                                     wt2{i,l}=[wt2{i,l},w2];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
%                                     w2=0;
%                                 end
                            end
                        end
                        
%                         v2a=find(speed<20);%intersect(find(speed<10),find(speed>0));%indices of where the avg velocity is less than 10kphr
%                         %v1=find((avg_kph<5));
%                         t2a=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
%                         c2a=intersect(v2a,t2a);%common indices between the v1 and t1
% 
%                         if (~isempty(c2a))
%                             w2=0;
% 
%                             for k=1:length(c2a)-1
%                                 if (c2a(k+1)==c2a(k)+1)
%                                     w2=w2+time(c2a(k+1));
%                                     %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
%                                 elseif(w2>0)
%                                     wt2a{i,l}=[wt2a{i,l},w2];%storing waiting time for 30 days for three city
%                                     wait2a{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
%                                     w2=0;
%                                 end
%                             end
%                         end
                    end%end of if loop cmp that array has enough length of data
                end%running the particular day particular city of different taxi

            end
    
            
            
            for ve=1:288
                mean_vel(i,l,ve) = mean(vel{i,l,ve});
                median_vel(i,l,ve) = median(vel{i,l,ve});
            end
            
            
        end%%run for three different city
        clear m1 m m2 file   
 end%end for 30 days
save(['Wait_time_taxis_bang',month]);