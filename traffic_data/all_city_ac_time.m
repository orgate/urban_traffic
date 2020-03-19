%/usr/local/matlab2010b
cty_tx_ind=cell(1,3);%storing the current day ind of  cities of bombay bangalore and delhi
wt=cell(3,30); %creating the waiting time array
%t_seg=cell(3,30);
for l=1:30
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%Commenting and rewriting the following lines  below %%%%%%%%%%%%
    %l  %%%printing this for testing
    %if (l~=16) %16th day is not there (2013/04/16)
    %    fprintf('hello1\n');    %%%%testing
    %if (l>=10) %put a "0" as prefix if date is between 1 to 9
    % fprintf('anybody here?\n');  %%%%testing
    % %file=(['allcity_2013040' num2str(l),'.dat']);%for loading the
    % %eventdata dat file %%%%currently no data files for those dates, so commenting out
    %%else  %%%%%% making if condition to work only for l>10 due to above
    %%mentioned reason
    % file=(['allcity_201304' num2str(l),'.dat']);%for loading the eventdata dat file
    % fprintf('hello2\n');
    % l   %%printing this for testing
    %end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%  Rewriting here (by Alfred)  %%%%%%%%%%%%%%%%%%%%%%%%%%%
    if((l~=16) & (l>10))
        file=(['allcity_201304' num2str(l),'.dat']);                        %for loading the eventdata dat file
        %%%%%%%%%%%%%%% Rewriting ends  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        M=load(file);

        %M: 1st column: taxi id, 2nd column: time stamp
        %M : 3rd and 4th columns contain latitude and longitude
        %M: 5th column contains speed ?
        %M: 6th column contains distance traveled during the time
        %M: 7th column contains road id

        %BOMBAY
        lat_ind2=find(M(:,3)<20);                                           %store indices of a position if the position latitude less than maximum latitude of the city
        lat_ind1=find(M(:,3)>18);                                           %do for higher than minimum lattitude of the city
        long_ind2=find(M(:,4)<73);                                          %do for less than max longitude of the city
        long_ind1=find(M(:,4)>72);                                          %do for higher than min longitude of the city
        %Store only coordinates for cars within the lat-long defining the city
        cty_tx_ind{1,1}=intersect(intersect(long_ind1,long_ind2),intersect(lat_ind1,lat_ind2));     %bombay

        %BANGALORE
        lat_ind1=find(M(:,3)>12);
        lat_ind2=find(M(:,3)<14);
        long_ind1=find(M(:,4)>77);
        long_ind2=find(M(:,4)<78);
        cty_tx_ind{1,2}=intersect(intersect(long_ind1,long_ind2),intersect(lat_ind1,lat_ind2));     %bang

        %DELHI
        lat_ind1=find(M(:,3)>28);
        lat_ind2=find(M(:,3)<29);
        long_ind1=find(M(:,4)>76);
        long_ind2=find(M(:,4)<78);
        cty_tx_ind{1,3}=intersect(intersect(long_ind1,long_ind2),intersect(lat_ind1,lat_ind2));     %delhi

        %Extracting the taxi number
        m1=M(:,1);

        %Extracting the time-stamp and distance traveled from the last stamp
        %to current time stamp
        m2=M(:,([2,6]));

        clear M;

        for i=1:3                                                           %for the 3 different cities
    
            taxi_no=unique(m1(cty_tx_ind{1,i}));                            %taxi id number
            %we are looking only at taxis which are within the city boundaries
            no_tx=length(taxi_no);                                          %total number of taxi present in the city for a day

            if(no_tx>0)                                                     %check whether there is atleast one taxi present
    
                for j=1:no_tx
    
                    ind=find(m1(:,1)==taxi_no(j));                          %number of data points for a particular taxi

                    if (length(ind)>60)                                     %only using data from a taxi if it has more than 60 data points for a day

                        m=m2(ind,:);                                        %extracting the particular taxi data alone
                        [time,ind1]=sort(m(:,1),'ascend');                  %sorting m array containing time stamps of a particular taxi
                        distance_tr=m(ind1,2);                              %distance traveled by the taxi
                        time=diff(time);                                    %time between the each gps point
                        distance_tr=distance_tr(2:end);                     %distance traveled between each time seqment
                        ind1=find(time==0);                                 %throw out the zero time difference
                        time(ind1)=[];
                        distance_tr(ind1)=[];

                        avg_kph=3600*(distance_tr./time);                   %finding the avg kph between two gps point where taxi travelled   %%%looks like distance is in kms and time is in secs

                        %For calculating waiting time distrn
                        %v1=intersect(find(avg_kph<10),find(avg_kph>0));    %indices of where the avg velocity is less than 5kphr
                        %For calculating active time distrn
                        v1=find((avg_kph>30));                              %only considering data for active time distrn if avg speed > 30 kph
                        t1=find(time<(2*60+1));                             %indices of where the time diffence between gps data is less than 4 minutes
                         c=intersect(v1,t1);                                %common indices between the v1 and t1

                        if (~isempty(c))
                            w=time(c(1));                                   %beginning and ends of the waiting times or active times (depending on what definition of v1 is used above)

                            for k=1:length(c)-1
    
    
                                if (c(k+1)==c(k)+1)
                                    w=w+time(c(k+1));
                                    %t_seg{i,l}=[t_seg{i,l},time(c(k)+1)];
                                else
                                    wt{i,l}=[wt{i,l},w];                    %storing waiting time or active time for 30 days for three city
                                    w=0;
                                end
    
                                %To find waiting time distrn or active time distrn look at distrn of wt    
    
                            end
                        end
                    end                                                     %end of if loop cmp that array has enough length of data
                end                                                         %running the particular day particular city of different taxi
            end
        end                                                                 %run for three different city
    
        clear m1 m m2 file   
    end                                                                     %no data in 16th of april 
end                                                                         %end for 30 days

save wt_time_bombay_bang_delhi

