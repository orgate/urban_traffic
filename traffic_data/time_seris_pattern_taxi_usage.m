days=[1,2,3,4,5,8,9,10,11,12,15,17,18,19,22,23,24,25,26,29,30];
tm_sr=cell(1,3);%storing the number of vehicle present in the ntwk
cty_tx_ind=cell(1,3);%storing the current day ind of  cities of bombay bangalore and delhi
tm_sr_to_taxi=cell(1,3);
tm_sr{1,1}=zeros(length(days),96);
tm_sr{1,2}=zeros(length(days),96);
tm_sr{1,3}=zeros(length(days),96);
for l1=1:length(days)
    l=days(l1);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%Commenting and rewriting the following lines  below %%%%%%%%%%%%
    %if (l<10)
    % file=(['allcity_2013040' num2str(l),'.dat']);%for loading the eventdata dat file
    %else
    % file=(['allcity_201304' num2str(l),'.dat']);%for loading the eventdata dat file 
    %end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%  Rewriting here (by Alfred)  %%%%%%%%%%%%%%%%%%%%%%%%%%%
    if((l1~=16) & (l1>10))
        file=(['allcity_201304' num2str(l1),'.dat']);                        %for loading the eventdata dat file
    %end
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
m1=M(:,1);%tx_number


for i=1:3
    
    taxi_no=unique(m1(cty_tx_ind{1,i}));%taxi id number
    no_tx=length(taxi_no);%total number of taxi present in the city for a day
    tm_sr_to_taxi{1,i}(1,l1)=no_tx;
for j=1:no_tx
    ind=find(m1(:,1)==taxi_no(j));
    
    m=M(ind,[2,6]);%extracting the particular taxi data alone
[time,ind1]=sort(m(:,1),'ascend');
distance_tr=m(ind1,2);
  time=rem(time,24*3600);
  
  for k=1:96  
      
      t_ind=intersect(find(time>((k-1)*15*60)),find(time<(k*15*60+1)));
      if (sum(distance_tr(t_ind))~=0)
  tm_sr{1,i}(l1,k)=tm_sr{1,i}(l1,k)+1;
      end
  end
end
   
end

    
    end
end %added by Alfred