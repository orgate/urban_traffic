%for lt=1:30
%s=time{1,lt};
%v=velocity{1,lt};
%x=diff(s);
%d=find(x<0);
%T{1,1}=s(1:d(1),1)';
%vel{1,1}=v(1:d(1),1)';
%for i=2:length(d)
%T{1,i}=s(d(i-1)+1:d(i),1)';
%vel{1,i}=v(d(i-1)+1:d(i),1)';
%end
%T{1,length(d)+1}=s((d(end)+1:end),1)';
%vel{1,length(d)+1}=v((d(end)+1:end),1)';
%Time_seg{1,lt}=T;
%Velocity_seg{1,lt}=vel;
%end
wt_time=zeros(1,24);
wt_car=zeros(1,24);
ind=[1,2,3,6,7,8,9,10,13,14,15,16,17,20,21,22,23,24,27,28,29,30];
for k=1:24
for i=1:length(ind)
for j=1:126
if (~isempty(idealtime{1,ind(i)}{1,j}{1,k}))
if (max(Velocity24{1,ind(i)}{1,j}{1,k})>0)
wt_time(1,k)=wt_time(1,k)+idealtime{1,ind(i)}{1,j}{1,k};
wt_car(1,k)=wt_car(1,k)+1;
end
end
end
end
end