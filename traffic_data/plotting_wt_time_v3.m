%Plotting waiting time or active time distributions
% load Waiting_time_taxis_half_avg_below_2_5_bombay_bang_delhi_fullyear201312_v2.mat % data of 2013
load Waiting_time_taxis_half_avg_below_1_bombay_bang_delhi_201312.mat % data of 2013
% x1=[];y1=[];z1=[];
% x2=[];y2=[];z2=[];
% x3=[];y3=[];z3=[];
% x4=[];y4=[];z4=[];
% clear('x1a','x1b','x2a','x2b','x3a','x3b','x4a','x4b','x5a','x5b','x6a','x6b','x7a','x7b','x8a','x8b','y1a','y1b','y2a','y2b','y3a','y3b','y4a','y4b','y5a','y5b','y6a','y6b','y7a','y7b','y8a','y8b','z1a','z1b','z2a','z2b','z3a','z3b','z4a','z4b','z5a','z5b','z6a','z6b','z7a','z7b','z8a','z8b');

% fx1a=[];fy1a=[];fz1a=[];
% fx2a=[];fy2a=[];fz2a=[];
% fx3a=[];fy3a=[];fz3a=[];
% fx4a=[];fy4a=[];fz4a=[];
% fx5a=[];fy5a=[];fz5a=[];
% 
% fx6a=[];fy6a=[];fz6a=[];
% fx7a=[];fy7a=[];fz7a=[];
% fx8a=[];fy8a=[];fz8a=[];
% fx9a=[];fy9a=[];fz9a=[];
% fx10a=[];fy10a=[];fz10a=[];
% 
% fx1b=[];fy1b=[];fz1b=[];
% fx2b=[];fy2b=[];fz2b=[];
% fx3b=[];fy3b=[];fz3b=[];
% fx4b=[];fy4b=[];fz4b=[];
% fx5b=[];fy5b=[];fz5b=[];
% 
% fx6b=[];fy6b=[];fz6b=[];
% fx7b=[];fy7b=[];fz7b=[];
% fx8b=[];fy8b=[];fz8b=[];
% fx9b=[];fy9b=[];fz9b=[];
% fx10b=[];fy10b=[];fz10b=[];

% x=cell(1,40000);
% y=cell(1,40000);
% z=cell(1,40000);
% xa=cell(1,40000);
% ya=cell(1,40000);
% za=cell(1,40000);
% x2=cell(1,40000);
% y2=cell(1,40000);
% z2=cell(1,40000);
% x2a=cell(1,40000);
% y2a=cell(1,40000);
% z2a=cell(1,40000);

% weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];   %Week days for JAN, 2013
% weekdays = [1,4,5,6,7,8,11,12,13,14,15,18,19,20,21,22,25,26,27,28];           %Week days for FEB, 2013
% weekdays = [1,4,5,6,7,8,11,12,13,14,15,18,19,20,21,22,25,26,27,28,29];        %Week days for MAR, 2013
% weekdays = [1,2,3,4,5,8,9,10,11,12,15,16,17,18,19,22,23,24,25,26,29,30];      %Weekdays for APR, 2013
% weekdays = [1,2,3,6,7,8,9,10,13,14,15,16,17,20,21,22,23,24,27,28,29,30,31];   %Weekdays for MAY, 2013
% weekdays = [3,4,5,6,7,10,11,12,13,14,17,18,19,20,21,24,25,26,27,28];          %Weekdays for JUN, 2013
% weekdays = [1,2,3,4,5,8,9,10,11,12,15,16,17,18,19,22,23,24,25,26,29,30,31];   %Week days for JUL, 2013
% weekdays = [1,2,5,6,7,8,9,12,13,14,15,16,19,20,21,22,23,26,27,28,29,30];      %Weekdays for AUG, 2013
% weekdays = [2,3,4,5,6,9,10,11,12,13,16,17,18,19,20,23,24,25,26,27,30];        %Weekdays for SEP, 2013
% weekdays = [1,2,3,4,7,8,9,10,11,14,15,16,17,18,21,22,23,24,25,28,29,30,31];   %Weekdays for OCT, 2013
% weekdays = [1,4,5,6,7,8,11,12,13,14,15,18,19,20,21,22,25,26,27,28,29];        %Weekdays for NOV, 2013
weekdays = [2,3,4,5,6,9,10,11,12,13,16,17,18,19,20,23,24,25,26,27,30,31];     %Weekdays for DEC, 2013
for i=1:length(weekdays)   %%%%%changed from 30 for wt_time; it's 21 for ac_time
%     for j=1:40000
        d = weekdays(1,i)
        fx1a=[fx1a,wt1a{1,d}]; %Bombay
        fy1a=[fy1a,wt1a{2,d}]; %Bangalore
        fz1a=[fz1a,wt1a{3,d}]; %Delhi
        fx2a=[fx2a,wt2a{1,d}]; %Bombay
        fy2a=[fy2a,wt2a{2,d}]; %Bangalore
        fz2a=[fz2a,wt2a{3,d}]; %Delhi
        fx3a=[fx3a,wt3a{1,d}]; %Bombay
        fy3a=[fy3a,wt3a{2,d}]; %Bangalore
        fz3a=[fz3a,wt3a{3,d}]; %Delhi
        fx4a=[fx4a,wt4a{1,d}]; %Bombay
        fy4a=[fy4a,wt4a{2,d}]; %Bangalore
        fz4a=[fz4a,wt4a{3,d}]; %Delhi
        fx5a=[fx5a,wt5a{1,d}]; %Bombay
        fy5a=[fy5a,wt5a{2,d}]; %Bangalore
        fz5a=[fz5a,wt5a{3,d}]; %Delhi
        fx6a=[fx6a,wt6a{1,d}]; %Bombay
        fy6a=[fy6a,wt6a{2,d}]; %Bangalore
        fz6a=[fz6a,wt6a{3,d}]; %Delhi
        fx7a=[fx7a,wt7a{1,d}]; %Bombay
        fy7a=[fy7a,wt7a{2,d}]; %Bangalore
        fz7a=[fz7a,wt7a{3,d}]; %Delhi
        fx8a=[fx8a,wt8a{1,d}]; %Bombay
        fy8a=[fy8a,wt8a{2,d}]; %Bangalore
        fz8a=[fz8a,wt8a{3,d}]; %Delhi
        fx9a=[fx9a,wt9a{1,d}]; %Bombay
        fy9a=[fy9a,wt9a{2,d}]; %Bangalore
        fz9a=[fz9a,wt9a{3,d}]; %Delhi
        fx10a=[fx10a,wt10a{1,d}]; %Bombay
        fy10a=[fy10a,wt10a{2,d}]; %Bangalore
        fz10a=[fz10a,wt10a{3,d}]; %Delhi


        fx1b=[fx1b,wt1b{1,d}]; %Bombay
        fy1b=[fy1b,wt1b{2,d}]; %Bangalore
        fz1b=[fz1b,wt1b{3,d}]; %Delhi
        fx2b=[fx2b,wt2b{1,d}]; %Bombay
        fy2b=[fy2b,wt2b{2,d}]; %Bangalore
        fz2b=[fz2b,wt2b{3,d}]; %Delhi
        fx3b=[fx3b,wt3b{1,d}]; %Bombay
        fy3b=[fy3b,wt3b{2,d}]; %Bangalore
        fz3b=[fz3b,wt3b{3,d}]; %Delhi
        fx4b=[fx4b,wt4b{1,d}]; %Bombay
        fy4b=[fy4b,wt4b{2,d}]; %Bangalore
        fz4b=[fz4b,wt4b{3,d}]; %Delhi
        fx5b=[fx5b,wt5b{1,d}]; %Bombay
        fy5b=[fy5b,wt5b{2,d}]; %Bangalore
        fz5b=[fz5b,wt5b{3,d}]; %Delhi
        fx6b=[fx6b,wt6b{1,d}]; %Bombay
        fy6b=[fy6b,wt6b{2,d}]; %Bangalore
        fz6b=[fz6b,wt6b{3,d}]; %Delhi
        fx7b=[fx7b,wt7b{1,d}]; %Bombay
        fy7b=[fy7b,wt7b{2,d}]; %Bangalore
        fz7b=[fz7b,wt7b{3,d}]; %Delhi
        fx8b=[fx8b,wt8b{1,d}]; %Bombay
        fy8b=[fy8b,wt8b{2,d}]; %Bangalore
        fz8b=[fz8b,wt8b{3,d}]; %Delhi
        fx9b=[fx9b,wt9b{1,d}]; %Bombay
        fy9b=[fy9b,wt9b{2,d}]; %Bangalore
        fz9b=[fz9b,wt9b{3,d}]; %Delhi
        fx10b=[fx10b,wt10b{1,d}]; %Bombay
        fy10b=[fy10b,wt10b{2,d}]; %Bangalore
        fz10b=[fz10b,wt10b{3,d}]; %Delhi

        
%         x{1,j}=[x{1,j},wait{1,d,j}]; %Bombay
%         y{1,j}=[y{1,j},wait{2,d,j}]; %Bangalore
%         z{1,j}=[z{1,j},wait{3,d,j}]; %Delhi
%         xa{1,j}=[xa{1,j},waita{1,d,j}]; %Bombay
%         ya{1,j}=[ya{1,j},waita{2,d,j}]; %Bangalore
%         za{1,j}=[za{1,j},waita{3,d,j}]; %Delhi
%         x2{1,j}=[x2{1,j},wait2{1,d,j}]; %Bombay
%         y2{1,j}=[y2{1,j},wait2{2,d,j}]; %Bangalore
%         z2{1,j}=[z2{1,j},wait2{3,d,j}]; %Delhi
%         x2a{1,j}=[x2a{1,j},wait2a{1,d,j}]; %Bombay
%         y2a{1,j}=[y2a{1,j},wait2a{2,d,j}]; %Bangalore
%         z2a{1,j}=[z2a{1,j},wait2a{3,d,j}]; %Delhi
%     end
end
% % 
% figure;loglog(sort(x,'descend'),(1:length(x))/length(x),'o r')
% hold on;loglog(sort(y,'descend'),(1:length(y))/length(y),'o g')
% hold on;loglog(sort(z,'descend'),(1:length(z))/length(z),'o b')
% legend('Bombay','Bangalore','Delhi')
% % 
% figure;loglog(sort(xa,'descend'),(1:length(xa))/length(xa),'o r')
% hold on;loglog(sort(ya,'descend'),(1:length(ya))/length(ya),'o g')
% hold on;loglog(sort(za,'descend'),(1:length(za))/length(za),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2,'descend'),(1:length(x2))/length(x2),'o r')
% hold on;loglog(sort(y2,'descend'),(1:length(y2))/length(y2),'o g')
% hold on;loglog(sort(z2,'descend'),(1:length(z2))/length(z2),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2a,'descend'),(1:length(x2a))/length(x2a),'o r')
% hold on;loglog(sort(y2a,'descend'),(1:length(y2a))/length(y2a),'o g')
% hold on;loglog(sort(z2a,'descend'),(1:length(z2a))/length(z2a),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% xlen = zeros(1,40000);
% ylen = zeros(1,40000);
% zlen = zeros(1,40000);
% xalen = zeros(1,40000);
% yalen = zeros(1,40000);
% zalen = zeros(1,40000);
% x2len = zeros(1,40000);
% y2len = zeros(1,40000);
% z2len = zeros(1,40000);
% x2alen = zeros(1,40000);
% y2alen = zeros(1,40000);
% z2alen = zeros(1,40000);
% 
% % 
% for i=1:40000
% xlen(1,i) = length(x{1,i});
% ylen(1,i) = length(y{1,i});
% zlen(1,i) = length(z{1,i});
% xalen(1,i) = length(xa{1,i});
% yalen(1,i) = length(ya{1,i});
% zalen(1,i) = length(za{1,i});
% x2len(1,i) = length(x2{1,i});
% y2len(1,i) = length(y2{1,i});
% z2len(1,i) = length(z2{1,i});
% x2alen(1,i) = length(x2a{1,i});
% y2alen(1,i) = length(y2a{1,i});
% z2alen(1,i) = length(z2a{1,i});
% end
% 
% 
% figure;loglog(sort(x{1,find(xlen==max(xlen))},'descend'),(1:length(x{1,find(xlen==max(xlen))}))/length(x{1,find(xlen==max(xlen))}),'o r')
% hold on; loglog(sort(y{1,find(ylen==max(ylen))},'descend'),(1:length(y{1,find(ylen==max(ylen))}))/length(y{1,find(ylen==max(ylen))}),'o g')
% hold on; loglog(sort(z{1,find(zlen==max(zlen))},'descend'),(1:length(z{1,find(zlen==max(zlen))}))/length(z{1,find(zlen==max(zlen))}),'o b')
% legend('Bombay','Bangalore','Delhi')
% % 
% figure;loglog(sort(xa{1,find(xalen==max(xalen))},'descend'),(1:length(xa{1,find(xalen==max(xalen))}))/length(xa{1,find(xalen==max(xalen))}),'o r')
% hold on; loglog(sort(ya{1,find(yalen==max(yalen))},'descend'),(1:length(ya{1,find(yalen==max(yalen))}))/length(ya{1,find(yalen==max(yalen))}),'o g')
% hold on; loglog(sort(za{1,find(zalen==max(zalen))},'descend'),(1:length(za{1,find(zalen==max(zalen))}))/length(za{1,find(zalen==max(zalen))}),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2{1,find(x2len==max(x2len))},'descend'),(1:length(x2{1,find(x2len==max(x2len))}))/length(x2{1,find(x2len==max(x2len))}),'o r')
% hold on; loglog(sort(y2{1,find(y2len==max(y2len))},'descend'),(1:length(y2{1,find(y2len==max(y2len))}))/length(y2{1,find(y2len==max(y2len))}),'o g')
% hold on; loglog(sort(z2{1,find(z2len==max(z2len))},'descend'),(1:length(z2{1,find(z2len==max(z2len))}))/length(z2{1,find(z2len==max(z2len))}),'o b')
% legend('Bombay','Bangalore','Delhi')
% 
% figure;loglog(sort(x2a{1,find(x2alen==max(x2alen))},'descend'),(1:length(x2a{1,find(x2alen==max(x2alen))}))/length(x2a{1,find(x2alen==max(x2alen))}),'o r')
% hold on; loglog(sort(y2a{1,find(y2alen==max(y2alen))},'descend'),(1:length(y2a{1,find(y2alen==max(y2alen))}))/length(y2a{1,find(y2alen==max(y2alen))}),'o g')
% hold on; loglog(sort(z2a{1,find(z2alen==max(z2alen))},'descend'),(1:length(z2a{1,find(z2alen==max(z2alen))}))/length(z2a{1,find(z2alen==max(z2alen))}),'o b')
% legend('Bombay','Bangalore','Delhi')



%%%% taking transpose just for viewing data in matlab console (by Alfred)
%x = x';
%y = y';
%z = z';
