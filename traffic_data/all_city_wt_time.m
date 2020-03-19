%/usr/local/matlab2010b
days=[1,2,3,4,5,8,9,10,11,12,15,17,18,19,22,23,24,25,26,29,30];
cty_tx_ind=cell(1,3);%storing the current day ind of  cities of bombay bangalore and delhi
wt=cell(3,length(days));
t_seg=cell(3,length(days));

wait = cell(3,length(days));

for l=1:length(days)
    l1=days(l);

    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%Commenting and rewriting the following lines  below %%%%%%%%%%%%    
    %if(l1~=16)
    %if (l1<10)
    % file=(['allcity_2013040' num2str(l1),'.dat']);%for loading the eventdata dat file
    %else
    % file=(['allcity_201304' num2str(l1),'.dat']);%for loading the eventdata dat file 
    %end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%  Rewriting here (by Alfred)  %%%%%%%%%%%%%%%%%%%%%%%%%%%
    if((l1~=16) & (l1>10))
        file=(['allcity_201304' num2str(l1),'.dat']);                        %for loading the eventdata dat file
        %%%%%%%%%%%%%%% Rewriting ends  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
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
        
        m1=M(:,1);                                                          %tx_number
        m2=M(:,([2,6]));
        clear M;

        for i=1:3 
            taxi_no=unique(m1(cty_tx_ind{1,i}));                            %taxi id number
            no_tx=length(taxi_no);                                          %total number of taxi present in the city for a day
            
            wait{i,l} = cell(2,no_tx);
            
            if(no_tx>0)                                                     %check whether there is atleast one taxi present
    
                for j=1:no_tx
                    ind=find(m1(:,1)==taxi_no(j));
                    wait{i,l}{1,j} = taxi_no(j);                            %taking note of the taxi number - Alfred
    
                    if (length(ind)>60)
                        m=m2(ind,:);                                        %extracting the particular taxi data alone
                        [time,ind1]=sort(m(:,1),'ascend');
                        distance_tr=m(ind1,2);
                        time=diff(time);                                    %time between the each gps point
                        distance_tr=distance_tr(2:end);                     %distance traveled between each time seqment
                        ind1=find(time==0);                                 %throw out the zero time difference
                        time(ind1)=[];
                        distance_tr(ind1)=[];
                        avg_kph=3600*(distance_tr./time);                   %finding the avg kph between two gps point where taxi travelled

                        %v1=intersect(find(avg_kph<10),find(avg_kph>0.01)); %indices of where the avg velocity is less than 5kphr
                        v1=find((avg_kph<10));
                        t1=find(time<(2*60+1));                             %indices of where the time diffence between gps data is less than 4 minutes
                        c=intersect(v1,t1);                                 %common indices between the v1 and t1

                        if (~isempty(c))
                            w=time(c(1));

                            for k=1:length(c)-1
    
                                if (c(k+1)==c(k)+1)
                                    w=w+time(c(k+1));
                                    t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt{i,l}=[wt{i,l},w];                    %storing waiting time for 30 days for three city
                                    wait{i,l}{2,j} = [wait{i,l}{2,j}, w];   %storing waiting time of each taxi - Alfred
                                    w=0;
                                end
                            end
                        end
                    end                                                     %end of if loop cmp that array has enough length of data
                end                                                         %running the particular day particular city of different taxi
            end
        end                                                                 %%run for three different city
        clear m1 m m2 file   
    end                                                                     %no data in 16th of april 
end                                                                         %end for 30 days
save wt_time_bombay_bang_delhi                                              %%%%%uncommented by Alfred
