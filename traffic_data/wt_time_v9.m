%/usr/local/matlab2010b
function w = wt_time_v9(month,days);

%month = '01';%considering only January month of 2013
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];
%weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];%Week days for JAN, 2013
%D = str2num(days);
%D = length(weekdays);
D = days;

cty_tx_ind=cell(1,3);%storing the current day ind of  cities of bombay bangalore and delhi
wt1=cell(3,D);%waiting times while considering dist/time
wait1 = cell(3,D,40000);%assuming taxi ids are about 39340
wt2=cell(3,D);%waiting times while considering dist/time
wait2 = cell(3,D,40000);%assuming taxi ids are about 39340
wt3=cell(3,D);%waiting times while considering dist/time
wait3 = cell(3,D,40000);%assuming taxi ids are about 39340
wt4=cell(3,D);%waiting times while considering dist/time
wait4 = cell(3,D,40000);%assuming taxi ids are about 39340
% wt1a=cell(3,D);%waiting times while considering dist/time
% wait1a = cell(3,D,40000);%assuming taxi ids are about 39340
% wt2a=cell(3,D);%waiting times while considering dist/time
% wait2a = cell(3,D,40000);%assuming taxi ids are about 39340
% wt3a=cell(3,D);%waiting times while considering dist/time
% wait3a = cell(3,D,40000);%assuming taxi ids are about 39340
% wt4a=cell(3,D);%waiting times while considering dist/time
% wait4a = cell(3,D,40000);%assuming taxi ids are about 39340

wt5=cell(3,D);%waiting times while considering dist/time
wt6=cell(3,D);%waiting times while considering dist/time
wt7=cell(3,D);%waiting times while considering dist/time
wt8=cell(3,D);%waiting times while considering dist/time
wt9=cell(3,D);%waiting times while considering dist/time
wt10=cell(3,D);%waiting times while considering dist/time
wt11=cell(3,D);%waiting times while considering dist/time
wt12=cell(3,D);%waiting times while considering dist/time
wt13=cell(3,D);%waiting times while considering dist/time
wt14=cell(3,D);%waiting times while considering dist/time
wt15=cell(3,D);%waiting times while considering dist/time
wt16=cell(3,D);%waiting times while considering dist/time
wt17=cell(3,D);%waiting times while considering dist/time
wt18=cell(3,D);%waiting times while considering dist/time
wt19=cell(3,D);%waiting times while considering dist/time
wt20=cell(3,D);%waiting times while considering dist/time
wt21=cell(3,D);%waiting times while considering dist/time
wt22=cell(3,D);%waiting times while considering dist/time
wt23=cell(3,D);%waiting times while considering dist/time
wt24=cell(3,D);%waiting times while considering dist/time
wt25=cell(3,D);%waiting times while considering dist/time
wt26=cell(3,D);%waiting times while considering dist/time
wt27=cell(3,D);%waiting times while considering dist/time
wt28=cell(3,D);%waiting times while considering dist/time
wt29=cell(3,D);%waiting times while considering dist/time
wt30=cell(3,D);%waiting times while considering dist/time
wt31=cell(3,D);%waiting times while considering dist/time
wt32=cell(3,D);%waiting times while considering dist/time
wt33=cell(3,D);%waiting times while considering dist/time
wt34=cell(3,D);%waiting times while considering dist/time


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

                        v1=find(avg_kph<0.025);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
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
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w1=0;
                                end
                            end
                        end
                        
                        
                        
                        v2=find(avg_kph<0.05);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
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
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w2=0;
                                end
                            end
                        end
                        
                        
                        v3=find(avg_kph<0.075);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
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
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w3=0;
                                end
                            end
                        end
                        
                        
                        v4=find(avg_kph<0.1);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
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
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w4=0;
                                end
                            end
                        end
                        
                        

                        
                        v5=find(avg_kph<0.125);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t5=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c5=intersect(v5,t5);%common indices between the v1 and t1

                        if (~isempty(c5))
                            w5=time(c5(1));

                            for k=1:length(c5)-1
                                if (c5(k+1)==c5(k)+1)
                                    w5=w5+time(c5(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt5{i,l}=[wt5{i,l},w5];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w5=0;
                                end
                            end
                        end
                        
                        
                        
                        v6=find(avg_kph<0.15);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t6=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c6=intersect(v6,t6);%common indices between the v1 and t1

                        if (~isempty(c6))
                            w6=time(c6(1));

                            for k=1:length(c6)-1
                                if (c6(k+1)==c6(k)+1)
                                    w6=w6+time(c6(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt6{i,l}=[wt6{i,l},w6];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w6=0;
                                end
                            end
                        end
                        
                        
                        v7=find(avg_kph<0.175);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t7=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c7=intersect(v7,t7);%common indices between the v1 and t1

                        if (~isempty(c7))
                            w7=time(c7(1));

                            for k=1:length(c7)-1
                                if (c7(k+1)==c7(k)+1)
                                    w7=w7+time(c7(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt7{i,l}=[wt7{i,l},w7];%storing waiting time for 30 days for three city
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w7=0;
                                end
                            end
                        end
                        
                        
                        v8=find(avg_kph<0.2);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t8=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c8=intersect(v8,t8);%common indices between the v1 and t1

                        if (~isempty(c8))
                            w8=time(c8(1));

                            for k=1:length(c8)-1
                                if (c8(k+1)==c8(k)+1)
                                    w8=w8+time(c8(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt8{i,l}=[wt8{i,l},w8];%storing waiting time for 30 days for three city
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w8=0;
                                end
                            end
                        end
                        
                        
                        
                        v9=find(avg_kph<0.225);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t9=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c9=intersect(v9,t9);%common indices between the v1 and t1

                        if (~isempty(c9))
                            w9=time(c9(1));

                            for k=1:length(c9)-1
                                if (c9(k+1)==c9(k)+1)
                                    w9=w9+time(c9(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt9{i,l}=[wt9{i,l},w9];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w9=0;
                                end
                            end
                        end
                        
                        
                        
                        v10=find(avg_kph<0.25);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t10=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c10=intersect(v10,t10);%common indices between the v1 and t1

                        if (~isempty(c10))
                            w10=time(c10(1));

                            for k=1:length(c10)-1
                                if (c10(k+1)==c10(k)+1)
                                    w10=w10+time(c10(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt10{i,l}=[wt10{i,l},w10];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w10=0;
                                end
                            end
                        end
                        
                        
                        v11=find(avg_kph<0.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t11=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c11=intersect(v11,t11);%common indices between the v1 and t1

                        if (~isempty(c11))
                            w11=time(c11(1));

                            for k=1:length(c11)-1
                                if (c11(k+1)==c11(k)+1)
                                    w11=w11+time(c11(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt11{i,l}=[wt11{i,l},w11];%storing waiting time for 30 days for three city
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w11=0;
                                end
                            end
                        end
                        
                        
                        v12=find(avg_kph<0.75);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t12=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c12=intersect(v12,t12);%common indices between the v1 and t1

                        if (~isempty(c12))
                            w12=time(c12(1));

                            for k=1:length(c12)-1
                                if (c12(k+1)==c12(k)+1)
                                    w12=w12+time(c12(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt12{i,l}=[wt12{i,l},w12];%storing waiting time for 30 days for three city
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w12=0;
                                end
                            end
                        end
                        
                        
                        
                        v13=find(avg_kph<1.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t13=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c13=intersect(v13,t13);%common indices between the v1 and t1

                        if (~isempty(c13))
                            w13=time(c13(1));

                            for k=1:length(c13)-1
                                if (c13(k+1)==c13(k)+1)
                                    w13=w13+time(c13(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt13{i,l}=[wt13{i,l},w13];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w13=0;
                                end
                            end
                        end
                        
                        
                        
                        v14=find(avg_kph<1.25);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t14=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c14=intersect(v14,t14);%common indices between the v1 and t1

                        if (~isempty(c14))
                            w14=time(c14(1));

                            for k=1:length(c14)-1
                                if (c14(k+1)==c14(k)+1)
                                    w14=w14+time(c14(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt14{i,l}=[wt14{i,l},w14];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w14=0;
                                end
                            end
                        end
                        
                        
                        v15=find(avg_kph<1.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t15=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c15=intersect(v15,t15);%common indices between the v1 and t1

                        if (~isempty(c15))
                            w15=time(c15(1));

                            for k=1:length(c15)-1
                                if (c15(k+1)==c15(k)+1)
                                    w15=w15+time(c15(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt15{i,l}=[wt15{i,l},w15];%storing waiting time for 30 days for three city
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w15=0;
                                end
                            end
                        end
                        
                        
                        v16=find(avg_kph<1.75);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t16=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c16=intersect(v16,t16);%common indices between the v1 and t1

                        if (~isempty(c16))
                            w16=time(c16(1));

                            for k=1:length(c16)-1
                                if (c16(k+1)==c16(k)+1)
                                    w16=w16+time(c16(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt16{i,l}=[wt16{i,l},w16];%storing waiting time for 30 days for three city
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w16=0;
                                end
                            end
                        end
                        
                        
                        
                        v17=find(avg_kph<2.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t17=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c17=intersect(v17,t17);%common indices between the v1 and t1

                        if (~isempty(c17))
                            w17=time(c17(1));

                            for k=1:length(c17)-1
                                if (c17(k+1)==c17(k)+1)
                                    w17=w17+time(c17(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt17{i,l}=[wt17{i,l},w17];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w17=0;
                                end
                            end
                        end
                        
                        
                        
                        v18=find(avg_kph<2.25);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t18=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c18=intersect(v18,t18);%common indices between the v1 and t1

                        if (~isempty(c18))
                            w18=time(c18(1));

                            for k=1:length(c18)-1
                                if (c18(k+1)==c18(k)+1)
                                    w18=w18+time(c18(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt18{i,l}=[wt18{i,l},w18];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w18=0;
                                end
                            end
                        end
                        
                        
                        v19=find(avg_kph<2.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t19=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c19=intersect(v19,t19);%common indices between the v1 and t1

                        if (~isempty(c19))
                            w19=time(c19(1));

                            for k=1:length(c19)-1
                                if (c19(k+1)==c19(k)+1)
                                    w19=w19+time(c19(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt19{i,l}=[wt19{i,l},w19];%storing waiting time for 30 days for three city
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w19=0;
                                end
                            end
                        end
                        
                        
                        v20=find(avg_kph<5.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t20=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c20=intersect(v20,t20);%common indices between the v1 and t1

                        if (~isempty(c20))
                            w20=time(c20(1));

                            for k=1:length(c20)-1
                                if (c20(k+1)==c20(k)+1)
                                    w20=w20+time(c20(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt20{i,l}=[wt20{i,l},w20];%storing waiting time for 30 days for three city
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w20=0;
                                end
                            end
                        end
                        
                        
                        
                        v21=find(avg_kph<7.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t21=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c21=intersect(v21,t21);%common indices between the v1 and t1

                        if (~isempty(c21))
                            w21=time(c21(1));

                            for k=1:length(c21)-1
                                if (c21(k+1)==c21(k)+1)
                                    w21=w21+time(c21(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt21{i,l}=[wt21{i,l},w21];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w21=0;
                                end
                            end
                        end
                        
                        
                        
                        v22=find(avg_kph<10.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t22=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c22=intersect(v22,t22);%common indices between the v1 and t1

                        if (~isempty(c22))
                            w22=time(c22(1));

                            for k=1:length(c22)-1
                                if (c22(k+1)==c22(k)+1)
                                    w22=w22+time(c22(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt22{i,l}=[wt22{i,l},w22];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w22=0;
                                end
                            end
                        end
                        
                        
                        v23=find(avg_kph<12.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t23=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c23=intersect(v23,t23);%common indices between the v1 and t1

                        if (~isempty(c23))
                            w23=time(c23(1));

                            for k=1:length(c23)-1
                                if (c23(k+1)==c23(k)+1)
                                    w23=w23+time(c23(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt23{i,l}=[wt23{i,l},w23];%storing waiting time for 30 days for three city
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w23=0;
                                end
                            end
                        end
                        
                        
                        v24=find(avg_kph<15.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t24=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c24=intersect(v24,t24);%common indices between the v1 and t1

                        if (~isempty(c24))
                            w24=time(c24(1));

                            for k=1:length(c24)-1
                                if (c24(k+1)==c24(k)+1)
                                    w24=w24+time(c24(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt24{i,l}=[wt24{i,l},w24];%storing waiting time for 30 days for three city
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w24=0;
                                end
                            end
                        end
                        
                        
                        
                        v25=find(avg_kph<17.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t25=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c25=intersect(v25,t25);%common indices between the v1 and t1

                        if (~isempty(c25))
                            w25=time(c25(1));

                            for k=1:length(c25)-1
                                if (c25(k+1)==c25(k)+1)
                                    w25=w25+time(c25(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt25{i,l}=[wt25{i,l},w25];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w25=0;
                                end
                            end
                        end
                        
                        
                        
                        v26=find(avg_kph<20.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t26=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c26=intersect(v26,t26);%common indices between the v1 and t1

                        if (~isempty(c26))
                            w26=time(c26(1));

                            for k=1:length(c26)-1
                                if (c26(k+1)==c26(k)+1)
                                    w26=w26+time(c26(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt26{i,l}=[wt26{i,l},w26];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w26=0;
                                end
                            end
                        end
                        
                        
                        v27=find(avg_kph<22.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t27=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c27=intersect(v27,t27);%common indices between the v1 and t1

                        if (~isempty(c27))
                            w27=time(c27(1));

                            for k=1:length(c27)-1
                                if (c27(k+1)==c27(k)+1)
                                    w27=w27+time(c27(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt27{i,l}=[wt27{i,l},w27];%storing waiting time for 30 days for three city
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w27=0;
                                end
                            end
                        end
                        
                        
                        v28=find(avg_kph<25.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t28=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c28=intersect(v28,t28);%common indices between the v1 and t1

                        if (~isempty(c28))
                            w28=time(c28(1));

                            for k=1:length(c28)-1
                                if (c28(k+1)==c28(k)+1)
                                    w28=w28+time(c28(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt28{i,l}=[wt28{i,l},w28];%storing waiting time for 30 days for three city
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w28=0;
                                end
                            end
                        end
                        
                        
                        
                        v29=find(avg_kph<27.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t29=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c29=intersect(v29,t29);%common indices between the v1 and t1

                        if (~isempty(c29))
                            w29=time(c29(1));

                            for k=1:length(c29)-1
                                if (c29(k+1)==c29(k)+1)
                                    w29=w29+time(c29(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt29{i,l}=[wt29{i,l},w29];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w29=0;
                                end
                            end
                        end
                        
                        
                        
                        v30=find(avg_kph<30.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t30=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c30=intersect(v30,t30);%common indices between the v1 and t1

                        if (~isempty(c30))
                            w30=time(c30(1));

                            for k=1:length(c30)-1
                                if (c30(k+1)==c30(k)+1)
                                    w30=w30+time(c30(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt30{i,l}=[wt30{i,l},w30];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w30=0;
                                end
                            end
                        end
                        
                        
                        v31=find(avg_kph<32.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t31=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c31=intersect(v31,t31);%common indices between the v1 and t1

                        if (~isempty(c31))
                            w31=time(c31(1));

                            for k=1:length(c31)-1
                                if (c31(k+1)==c31(k)+1)
                                    w31=w31+time(c31(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt31{i,l}=[wt31{i,l},w31];%storing waiting time for 30 days for three city
%                                     wait3{i,l,taxi_no(j)+1} = [wait3{i,l,taxi_no(j)+1},w3];
                                    w31=0;
                                end
                            end
                        end
                        
                        
                        v32=find(avg_kph<35.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t32=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c32=intersect(v32,t32);%common indices between the v1 and t1

                        if (~isempty(c32))
                            w32=time(c32(1));

                            for k=1:length(c32)-1
                                if (c32(k+1)==c32(k)+1)
                                    w32=w32+time(c32(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt32{i,l}=[wt32{i,l},w32];%storing waiting time for 30 days for three city
%                                     wait4{i,l,taxi_no(j)+1} = [wait4{i,l,taxi_no(j)+1},w4];
                                    w32=0;
                                end
                            end
                        end
                        
                        
                        
                        v33=find(avg_kph<37.5);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t33=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c33=intersect(v33,t33);%common indices between the v1 and t1

                        if (~isempty(c33))
                            w33=time(c33(1));

                            for k=1:length(c33)-1
                                if (c33(k+1)==c33(k)+1)
                                    w33=w33+time(c33(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt33{i,l}=[wt33{i,l},w33];%storing waiting time for 30 days for three city
%                                     wait1{i,l,taxi_no(j)+1} = [wait1{i,l,taxi_no(j)+1},w1];
                                    w33=0;
                                end
                            end
                        end
                        
                        
                        
                        v34=find(avg_kph<40.0);%intersect(find(avg_kph<5),find(avg_kph>0));%indices of where the avg velocity is less than 5kphr
                        %v1=find((avg_kph<5));
                        t34=find(time<(5*60+1));%indices of where the time diffence between gps data is less than 5 minutes
                        c34=intersect(v34,t34);%common indices between the v1 and t1

                        if (~isempty(c34))
                            w34=time(c34(1));

                            for k=1:length(c34)-1
                                if (c34(k+1)==c34(k)+1)
                                    w34=w34+time(c34(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt34{i,l}=[wt34{i,l},w34];%storing waiting time for 30 days for three city
%                                     wait2{i,l,taxi_no(j)+1} = [wait2{i,l,taxi_no(j)+1},w2];
                                    w34=0;
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
save(['Waiting_time_taxis_speed_avg_all_vel_bombay_bang_delhi_fullday_',month,'.mat']);


