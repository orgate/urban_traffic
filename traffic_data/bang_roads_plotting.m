load bangroads.mat

t_seg = cell(7,length(days));
wt = cell(7,length(days));

latlon = [  12.972745,77.618028;  12.931894,77.632365;  12.982945,77.637549;  13.107664,77.602516;  12.959129,77.659385;  12.920936,77.665852;  12.917203,77.580261;   ];

for i=1:7
    for j=1:length(days)
        m1 = cty_tx_ind{i,j};
        if(length(m1)>0)
        taxi_no = unique(m1(:,1));
        if(length(taxi_no)>0)
            for t = 1:length(taxi_no)
                ind=find(m1(:,1)==taxi_no(t));
                
                if (length(ind)>1)
                    m=m1(ind,2:end);                                        %extracting the particular taxi data alone
                    [time,ind1]=sort(m(:,1),'ascend');
                    distance_tr=m(ind1,5);
%                     distance_tr = sqrt(((m(ind1,2)-latlon(i,1)).^2)+((m(ind1,3)-latlon(i,2)).^2));
                    time=diff(time);                                    %time between the each gps point
                    distance_tr=distance_tr(2:end);                     %distance traveled between each time seqment
%                     distance_tr = diff(distance_tr);
                    ind1=find(time==0);                                 %throw out the zero time difference
                    time(ind1)=[];
                    distance_tr(ind1)=[];
                    avg_kph=3600*(distance_tr./time);                   %finding the avg kph between two gps point where taxi travelled

                    %v1=intersect(find(avg_kph<10),find(avg_kph>0.01)); %indices of where the avg velocity is less than 10kphr
                    v1=find((avg_kph<10));
                    t1=find(time<(2*60+1));                             %indices of where the time diffence between gps data is less than 2 minutes
                    c=intersect(v1,t1);                                 %common indices between the v1 and t1

                    if (~isempty(c))
                        w=time(c(1));

                        for k=1:length(c)-1
    
                            if (c(k+1)==c(k)+1)
                                w=w+time(c(k+1));
                                t_seg{i,j}=[t_seg{i,j},time(c(k)+1)];
                            else
                                wt{i,j}=[wt{i,j},w];                    %storing waiting time for 30 days for three city
                                w=0;
                            end
                        end
                    end
                end
           end
        end
        end
    end
end

wait_road = cell(1,7);
wait = [];

for r=1:7
    for d=1:length(days)
        wait_road{1,r} = [wait_road{1,r},wt{r,d}];
        wait = [wait,wt{r,d}];
    end
end

for r=1:7
    figure, loglog(sort(wait_road{1,r},'descend'),(1:length(wait_road{1,r}))/length(wait_road{1,r}),'o r');
end

figure, loglog(sort(wait,'descend'),(1:length(wait))/length(wait),'o r');
