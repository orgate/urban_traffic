%Plotting waiting time or active time distributions
load wt_time_bombay_bang_delhi.mat
x=[];y=[];z=[];
for i=1:21   %%%%%changed from 30 for wt_time; it's 21 for ac_time
x=[x,wt{1,i}]; %Bombay
y=[y,wt{2,i}]; %Bangalore
z=[z,wt{3,i}]; %Delhi
end
figure;loglog(sort(x,'descend'),(1:length(x))/length(x),'o r')
hold on;loglog(sort(y,'descend'),(1:length(y))/length(y),'o g')
hold on;loglog(sort(z,'descend'),(1:length(z))/length(z),'o b')

%%%% taking transpose just for viewing data in matlab console (by Alfred)
%x = x';
%y = y';
%z = z';


legend('Bombay','Bangalore','Delhi')
